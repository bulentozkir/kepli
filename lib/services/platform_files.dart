import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui' show Locale;

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart' as desktop_files;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart' hide XFile;
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart' hide XFile;
import 'package:uuid/uuid.dart';

import '../data/attachment_files.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import 'backup_service.dart';

/// How a user-initiated export finished.
enum ExportStatus { cancelled, saved, handedOff, unconfirmed }

class ExportOutcome {
  const ExportOutcome._(this.status) : destination = null;

  /// The file was written to [destination], a path or document name.
  const ExportOutcome.saved(String this.destination)
    : status = ExportStatus.saved;

  /// The user dismissed the save or share dialog.
  static const cancelled = ExportOutcome._(ExportStatus.cancelled);

  /// A share sheet accepted the file; the chosen app completes the save.
  static const handedOff = ExportOutcome._(ExportStatus.handedOff);

  /// The platform could not report whether the user finished sharing.
  static const unconfirmed = ExportOutcome._(ExportStatus.unconfirmed);

  final ExportStatus status;
  final String? destination;
}

class PlatformFiles {
  PlatformFiles({required this.temporaryDirectory});

  final Directory temporaryDirectory;
  static const _storage = MethodChannel('kepli/storage');
  static const _maxAttachmentBytes = AttachmentFiles.maxAttachmentBytes;
  static const _attachmentExtensions = [
    'pdf',
    'jpg',
    'jpeg',
    'png',
    'webp',
    'gif',
    'bmp',
  ];
  final ImagePicker _images = ImagePicker();
  bool _photoPickerActive = false;
  String? _protectedRoot;

  bool get isDesktop => switch (defaultTargetPlatform) {
    TargetPlatform.windows ||
    TargetPlatform.linux ||
    TargetPlatform.macOS => true,
    _ => false,
  };

  bool get cameraAvailable => switch (defaultTargetPlatform) {
    TargetPlatform.android || TargetPlatform.iOS => true,
    _ => false,
  };

  Future<List<PendingAttachment>> pickAttachments({
    required AttachmentRole role,
    String? contactId,
  }) => _guard('Import attachments', () async {
    _validateLink(role, contactId);
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _attachmentExtensions,
    );
    for (final file in files) {
      final length = file.lengthSync() ?? await file.length();
      _validateLength(length, _maxAttachmentBytes);
    }
    return _stageAttachments(
      [
        for (final file in files)
          (name: file.name, bytes: file.readAsByteStream()),
      ],
      role,
      contactId,
    );
  });

  Future<List<PendingAttachment>> pickPhotos({
    AttachmentRole role = AttachmentRole.receipt,
    String? contactId,
  }) => _photoOperation(role, contactId, () async {
    if (!cameraAvailable) {
      throw const KepliException(
        'Photo-library import is unavailable here. Use Import files instead.',
      );
    }
    final images = await _images.pickMultiImage(
      requestFullMetadata: false,
      imageQuality: 95,
      maxWidth: 4096,
      maxHeight: 4096,
    );
    return _stageImages(images, role, contactId);
  });

  Future<PendingAttachment?> takePhoto({
    AttachmentRole role = AttachmentRole.receipt,
    String? contactId,
  }) async {
    final result = await _photoOperation(role, contactId, () async {
      if (!cameraAvailable) {
        throw const KepliException(
          'Camera capture is unavailable on this platform. Import a photo instead.',
        );
      }
      final image = await _images.pickImage(
        source: ImageSource.camera,
        requestFullMetadata: false,
        imageQuality: 95,
        maxWidth: 4096,
        maxHeight: 4096,
      );
      if (image == null) return <PendingAttachment>[];
      return _stageImages([image], role, contactId);
    });
    return result.isEmpty ? null : result.single;
  }

  File get _photoContext =>
      File(p.join(temporaryDirectory.path, 'pending-photo-request.json'));

  Future<List<PendingAttachment>> _photoOperation(
    AttachmentRole role,
    String? contactId,
    Future<List<PendingAttachment>> Function() operation,
  ) => _guard('Import photo', () async {
    _validateLink(role, contactId);
    if (_photoPickerActive) {
      throw const KepliException('A photo picker is already open.');
    }
    _photoPickerActive = true;
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        await temporaryDirectory.create(recursive: true);
        // Android may kill the activity while the camera/gallery is open.
        // Persist the contact link before launching it, not after it returns.
        await _photoContext.writeAsString(
          jsonEncode({'role': role.name, 'contactId': contactId}),
          flush: true,
        );
      }
      return await operation();
    } finally {
      _photoPickerActive = false;
      if (defaultTargetPlatform == TargetPlatform.android &&
          await _photoContext.exists()) {
        await _photoContext.delete();
      }
    }
  });

  Future<List<PendingAttachment>>
  recoverLostPhotos() => _guard('Recover interrupted photo import', () async {
    if (defaultTargetPlatform != TargetPlatform.android) return const [];
    if (_photoPickerActive) {
      throw const KepliException('Wait for the photo picker to close.');
    }
    var role = AttachmentRole.receipt;
    String? contactId;
    if (await _photoContext.exists()) {
      final context = jsonObject(
        jsonDecode(await _photoContext.readAsString()),
        'Photo recovery context',
      );
      final roleName = jsonString(context, 'role');
      role = AttachmentRole.values.firstWhere(
        (value) => value.name == roleName,
        orElse: () => throw const KepliException(
          'The interrupted photo import has an invalid attachment type.',
        ),
      );
      contactId = jsonOptionalString(context, 'contactId');
      _validateLink(role, contactId);
    }
    final response = await _images.retrieveLostData();
    try {
      if (response.exception != null) throw response.exception!;
      if (response.isEmpty) return const [];
      final files =
          response.files ??
          (response.file == null ? <XFile>[] : [response.file!]);
      if (files.isEmpty) {
        throw const KepliException(
          'The interrupted photo import could not be recovered. Please try again.',
        );
      }
      return await _stageImages(files, role, contactId);
    } finally {
      if (await _photoContext.exists()) await _photoContext.delete();
    }
  });

  Future<String?> pickBackup() => _guard('Import backup', () async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['zip'],
    );
    if (file == null) return null;
    _validateLength(
      file.lengthSync() ?? await file.length(),
      BackupService.maxArchiveBytes,
    );
    final staged = await _stageFile(
      file.name,
      file.readAsByteStream(),
      maxBytes: BackupService.maxArchiveBytes,
    );
    return staged.path;
  });

  Future<ExportOutcome> saveOrShare(
    File file, {
    Rect? shareOrigin,
    String languageCode = 'en',
  }) => _guard('Export file', () async {
    if (!await file.exists()) {
      throw const KepliException('The export file no longer exists.');
    }
    final name = p.basename(file.path);
    final mimeType = lookupMimeType(name) ?? 'application/octet-stream';
    if (defaultTargetPlatform == TargetPlatform.android) {
      final strings = lookupAppLocalizations(Locale(languageCode));
      final destination = await _storage.invokeMethod<String>('saveExport', {
        'sourcePath': file.absolute.path,
        'fileName': name,
        'mimeType': mimeType,
        'successMessage': strings.exportReady,
        'failureMessage': strings.operationFailed,
      });
      return destination == null
          ? ExportOutcome.cancelled
          : ExportOutcome.saved(destination);
    }
    if (isDesktop) {
      final extension = p.extension(name).substring(1);
      final saved = await desktop_files.getSaveLocation(
        suggestedName: name,
        acceptedTypeGroups: [
          desktop_files.XTypeGroup(
            label: extension.toUpperCase(),
            extensions: [extension],
          ),
        ],
      );
      if (saved == null) return ExportOutcome.cancelled;
      final destination = File(saved.path);
      final destinationParent = await destination.parent.resolveSymbolicLinks();
      final resolved = p.join(destinationParent, p.basename(destination.path));
      if (_protectedRoot != null &&
          (p.equals(_protectedRoot!, resolved) ||
              p.isWithin(_protectedRoot!, resolved))) {
        throw const KepliException(
          'Choose a location outside Kepli internal storage for your export.',
        );
      }
      if (p.equals(p.absolute(file.path), p.absolute(destination.path))) {
        return ExportOutcome.saved(destination.path);
      }
      final pending = File(
        p.join(destinationParent, '.kepli-${const Uuid().v4()}.partial'),
      );
      try {
        await file.copy(pending.path);
        final handle = await pending.open(mode: FileMode.append);
        try {
          await handle.flush();
        } finally {
          await handle.close();
        }
        if (await pending.length() != await file.length()) {
          throw const KepliException(
            'The export could not be verified at the selected destination.',
          );
        }
        await pending.rename(destination.path);
      } finally {
        if (await pending.exists()) await pending.delete();
      }
      if (!await destination.exists()) {
        throw const KepliException(
          'The export was not found at the selected destination.',
        );
      }
      return ExportOutcome.saved(destination.path);
    }
    if (!cameraAvailable) {
      throw const KepliException('File sharing is unavailable here.');
    }
    final origin =
        shareOrigin != null &&
            shareOrigin.isFinite &&
            shareOrigin.width > 0 &&
            shareOrigin.height > 0 &&
            shareOrigin.left >= 0 &&
            shareOrigin.top >= 0
        ? shareOrigin
        : const Rect.fromLTWH(0, 0, 1, 1);
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: mimeType)],
        sharePositionOrigin: origin,
        mailToFallbackEnabled: false,
        downloadFallbackEnabled: false,
      ),
    );
    return switch (result.status) {
      ShareResultStatus.success => ExportOutcome.handedOff,
      ShareResultStatus.dismissed => ExportOutcome.cancelled,
      ShareResultStatus.unavailable => ExportOutcome.unconfirmed,
    };
  });

  Future<void> openAttachment(File file) => _guard('Open attachment', () async {
    if (!await file.exists()) {
      throw const KepliException('This attachment is no longer available.');
    }
    final result = await OpenFilex.open(
      file.path,
      type: lookupMimeType(file.path),
    );
    if (result.type != ResultType.done) {
      throw KepliException(switch (result.type) {
        ResultType.noAppToOpen =>
          'No installed application can open this attachment.',
        ResultType.permissionDenied =>
          'The operating system denied access to this attachment.',
        ResultType.fileNotFound => 'This attachment is no longer available.',
        _ => 'The attachment could not be opened: ${result.message}',
      });
    }
  });

  Future<void> protectLocalStorage(
    Directory root,
  ) => _guard('Protect local storage', () async {
    await root.create(recursive: true);
    _protectedRoot = p.normalize(await root.resolveSymbolicLinks());
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      final protected = await _storage.invokeMethod<bool>('excludeFromBackup', {
        'path': root.absolute.path,
      });
      if (protected != true) {
        throw const KepliException(
          'The operating system did not confirm exclusion from cloud backups.',
        );
      }
    }
  });

  void _validateLink(AttachmentRole role, String? contactId) {
    if ((role == AttachmentRole.businessCard &&
            (contactId == null || !isUuid(contactId))) ||
        (role != AttachmentRole.businessCard && contactId != null)) {
      throw const KepliException(
        'A business card must be linked to a contact.',
      );
    }
  }

  void _validateLength(int? length, int maximum) {
    if (length != null && (length <= 0 || length > maximum)) {
      throw KepliException(
        'Choose a nonempty file smaller than ${maximum ~/ (1024 * 1024)} MiB.',
      );
    }
  }

  Future<List<PendingAttachment>> _stageImages(
    List<XFile> images,
    AttachmentRole role,
    String? contactId,
  ) => _stageAttachments(
    [for (final image in images) (name: image.name, bytes: image.openRead())],
    role,
    contactId,
  );

  Future<List<PendingAttachment>> _stageAttachments(
    List<({String name, Stream<List<int>> bytes})> files,
    AttachmentRole role,
    String? contactId,
  ) async {
    final staged = <File>[];
    final result = <PendingAttachment>[];
    try {
      for (final file in files) {
        final name = p.posix.basename(file.name.replaceAll('\\', '/'));
        if (name.isEmpty || name.length > 255) {
          throw const KepliException('The attachment name is invalid.');
        }
        final copy = await _stageFile(
          name,
          file.bytes,
          maxBytes: _maxAttachmentBytes,
        );
        staged.add(copy);
        final input = await copy.open();
        late final List<int> header;
        try {
          header = await input.read(1024);
        } finally {
          await input.close();
        }
        final mimeType = lookupMimeType(name, headerBytes: header);
        if (header.isEmpty ||
            mimeType == null ||
            !(mimeType.startsWith('image/') || mimeType == 'application/pdf')) {
          throw const KepliException('Choose an image or PDF attachment.');
        }
        AttachmentFiles.extensionFor(mimeType);
        result.add(
          PendingAttachment(
            sourcePath: copy.path,
            originalName: name,
            mimeType: mimeType,
            role: role,
            contactId: contactId,
          ),
        );
      }
      return result;
    } catch (_) {
      for (final file in staged) {
        if (await file.exists()) await file.delete();
      }
      rethrow;
    }
  }

  Future<File> _stageFile(
    String name,
    Stream<List<int>> bytes, {
    int? maxBytes,
  }) async {
    final directory = Directory(p.join(temporaryDirectory.path, 'imports'));
    await directory.create(recursive: true);
    final extension = p.extension(name).toLowerCase();
    final safeExtension = RegExp(r'^\.[a-z0-9]{1,10}$').hasMatch(extension)
        ? extension
        : '';
    final file = File(
      p.join(directory.path, '${const Uuid().v4()}$safeExtension'),
    );
    try {
      final sink = file.openWrite();
      try {
        var length = 0;
        await sink.addStream(
          bytes.map((chunk) {
            length += chunk.length;
            if (maxBytes != null && length > maxBytes) {
              throw KepliException(
                'The file exceeds the ${maxBytes ~/ (1024 * 1024)} MiB safety limit.',
              );
            }
            return chunk;
          }),
        );
        await sink.flush();
      } finally {
        await sink.close();
      }
      return file;
    } catch (_) {
      if (await file.exists()) await file.delete();
      rethrow;
    }
  }

  Future<T> _guard<T>(String operation, Future<T> Function() action) async {
    try {
      return await action();
    } catch (error, stack) {
      developer.log(
        '$operation failed',
        name: 'kepli.files',
        error: error,
        stackTrace: stack,
      );
      if (error is KepliException) rethrow;
      throw KepliException('$operation failed: $error');
    }
  }
}
