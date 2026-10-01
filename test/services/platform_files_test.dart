import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart'
    as selector;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/data/attachment_files.dart';
import 'package:kepli/services/platform_files.dart';
import 'package:path/path.dart' as p;

const _contactId = '12345678-1234-4234-8234-123456789012';
const _imageChannel = MethodChannel('plugins.flutter.io/image_picker');
const _shareChannel = MethodChannel('dev.fluttercommunity.plus/share');
const _storageChannel = MethodChannel('kepli/storage');
const _openChannel = MethodChannel('open_file');
final _png = Uint8List.fromList([137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 0]);

base class _MemoryFile extends PlatformFile {
  _MemoryFile(this.name, this.bytes, {this.reportedLength});

  @override
  final String name;
  final Uint8List bytes;
  final int? reportedLength;

  @override
  Uri get uri => Uri.parse('content://selected-document/$name');
  @override
  XFile get xFile => throw StateError('A local path must not be assumed.');
  @override
  int? lengthSync() => reportedLength ?? bytes.length;
  @override
  Future<int?> length() async => reportedLength ?? bytes.length;
  @override
  Future<Uint8List> readAsBytes() async => bytes;
  @override
  Stream<Uint8List> readAsByteStream() => Stream.value(bytes);
}

class _Picker extends FilePickerPlatform {
  List<PlatformFile> files = [];
  PlatformFile? backup;
  List<String>? lastExtensions;

  @override
  Future<List<PlatformFile>> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    lastExtensions = allowedExtensions;
    return files;
  }

  @override
  Future<PlatformFile?> pickFile({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    AndroidOptions androidOptions = const AndroidOptions(),
    DarwinOptions darwinOptions = const DarwinOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    lastExtensions = allowedExtensions;
    return backup;
  }
}

class _SavePicker extends selector.FileSelectorPlatform {
  File? destination;
  String? suggestedName;
  List<selector.XTypeGroup>? groups;

  @override
  Future<selector.FileSaveLocation?> getSaveLocation({
    List<selector.XTypeGroup>? acceptedTypeGroups,
    selector.SaveDialogOptions options = const selector.SaveDialogOptions(),
  }) async {
    suggestedName = options.suggestedName;
    groups = acceptedTypeGroups;
    final path = destination?.path;
    return path == null ? null : selector.FileSaveLocation(path);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final originalPicker = FilePickerPlatform.instance;
  final originalSavePicker = selector.FileSelectorPlatform.instance;
  late Directory work;
  late PlatformFiles files;
  late _Picker picker;
  late _SavePicker savePicker;
  var serial = 0;

  setUp(() async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    work = Directory(
      p.join('test', '.platform_files_work_${pid}_${serial++}'),
    ).absolute;
    await work.create(recursive: true);
    files = PlatformFiles(temporaryDirectory: work);
    picker = _Picker();
    FilePickerPlatform.instance = picker;
    savePicker = _SavePicker();
    selector.FileSelectorPlatform.instance = savePicker;
  });

  tearDown(() async {
    for (final channel in [
      _imageChannel,
      _shareChannel,
      _storageChannel,
      _openChannel,
    ]) {
      messenger.setMockMethodCallHandler(channel, null);
    }
    FilePickerPlatform.instance = originalPicker;
    selector.FileSelectorPlatform.instance = originalSavePicker;
    debugDefaultTargetPlatformOverride = null;
    if (await work.exists()) await work.delete(recursive: true);
  });

  test('desktop camera capability is false on every desktop OS', () {
    for (final target in [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ]) {
      debugDefaultTargetPlatformOverride = target;
      expect(files.isDesktop, isTrue);
      expect(files.cameraAvailable, isFalse);
    }
    for (final target in [TargetPlatform.android, TargetPlatform.iOS]) {
      debugDefaultTargetPlatformOverride = target;
      expect(files.isDesktop, isFalse);
      expect(files.cameraAvailable, isTrue);
    }
  });

  test(
    'desktop capture reports unsupported rather than launching a picker',
    () {
      expect(files.takePhoto(), throwsA(isA<KepliException>()));
    },
  );

  test('picker cancellation is distinct from failure', () async {
    expect(await files.pickAttachments(role: AttachmentRole.receipt), isEmpty);
    expect(await files.pickBackup(), isNull);
  });

  test(
    'content URI attachments are copied with their role and contact link',
    () async {
      picker.files = [_MemoryFile('card.png', _png)];
      final result = await files.pickAttachments(
        role: AttachmentRole.businessCard,
        contactId: _contactId,
      );
      final attachment = result.single;
      expect(attachment.role, AttachmentRole.businessCard);
      expect(attachment.contactId, _contactId);
      expect(attachment.originalName, 'card.png');
      expect(attachment.mimeType, 'image/png');
      expect(await File(attachment.sourcePath).readAsBytes(), _png);
      expect(p.isWithin(work.path, attachment.sourcePath), isTrue);
      expect(picker.lastExtensions, containsAll(['pdf', 'png', 'jpg']));
      expect(picker.lastExtensions, isNot(contains('heic')));
    },
  );

  test('invalid business-card links fail before opening the picker', () async {
    await expectLater(
      files.pickAttachments(role: AttachmentRole.businessCard),
      throwsA(isA<KepliException>()),
    );
    await expectLater(
      files.pickAttachments(
        role: AttachmentRole.receipt,
        contactId: _contactId,
      ),
      throwsA(isA<KepliException>()),
    );
    expect(picker.lastExtensions, isNull);
  });

  test('a bad member of an import cleans up staged copies', () async {
    picker.files = [
      _MemoryFile('first.png', _png),
      _MemoryFile(
        'second.txt',
        Uint8List.fromList(utf8.encode('not an image')),
      ),
    ];
    await expectLater(
      files.pickAttachments(role: AttachmentRole.receipt),
      throwsA(isA<KepliException>()),
    );
    expect(
      await Directory(p.join(work.path, 'imports')).list().toList(),
      isEmpty,
    );
  });

  test(
    'oversize attachments are rejected before filling local storage',
    () async {
      picker.files = [
        _MemoryFile(
          'huge.png',
          _png,
          reportedLength: AttachmentFiles.maxAttachmentBytes + 1,
        ),
      ];
      await expectLater(
        files.pickAttachments(role: AttachmentRole.receipt),
        throwsA(
          isA<KepliException>().having(
            (error) => error.message,
            'message',
            contains('256 MiB'),
          ),
        ),
      );
      expect(await Directory(p.join(work.path, 'imports')).exists(), isFalse);
    },
  );

  test('opening a missing attachment returns an actionable error', () async {
    await expectLater(
      files.openAttachment(File(p.join(work.path, 'missing.pdf'))),
      throwsA(
        isA<KepliException>().having(
          (error) => error.message,
          'message',
          contains('no longer available'),
        ),
      ),
    );
  });

  test(
    'backup content URIs are staged locally and cancellation remains null',
    () async {
      final bytes = Uint8List.fromList([80, 75, 3, 4, 1, 2, 3]);
      picker.backup = _MemoryFile('backup.zip', bytes);
      final path = await files.pickBackup();
      expect(path, isNotNull);
      expect(await File(path!).readAsBytes(), bytes);
      expect(picker.lastExtensions, ['zip']);
    },
  );

  for (final target in [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ]) {
    test(
      '$target Save As actually writes identical bytes to the chosen file',
      () async {
        debugDefaultTargetPlatformOverride = target;
        final original = File(p.join(work.path, 'export.pdf'));
        final bytes = utf8.encode('%PDF-1.7\nlocal export');
        await original.writeAsBytes(bytes);
        final destination = File(p.join(work.path, 'chosen.pdf'));
        savePicker.destination = destination;
        final result = await files.saveOrShare(original);
        expect(result, contains(destination.path));
        expect(await destination.readAsBytes(), bytes);
        expect(savePicker.suggestedName, 'export.pdf');
        expect(savePicker.groups!.single.extensions, ['pdf']);
      },
    );
  }

  test(
    'cancelled Save As does not report success or delete the export',
    () async {
      final original = File(p.join(work.path, 'export.zip'));
      await original.writeAsBytes([1, 2, 3]);
      expect(await files.saveOrShare(original), isNull);
      expect(await original.exists(), isTrue);
    },
  );

  test(
    'an unavailable destination is reported without losing the export',
    () async {
      final original = File(p.join(work.path, 'export.csv'));
      await original.writeAsString('a,b');
      savePicker.destination = File(p.join(work.path, 'missing', 'export.csv'));
      await expectLater(
        files.saveOrShare(original),
        throwsA(isA<KepliException>()),
      );
      expect(await original.readAsString(), 'a,b');
    },
  );

  test('desktop export refuses to overwrite internal vault data', () async {
    final vault = Directory(p.join(work.path, 'vault'));
    await files.protectLocalStorage(vault);
    final database = File(p.join(vault.path, 'kepli.db'));
    await database.writeAsString('existing vault');
    final export = File(p.join(work.path, 'export.zip'));
    await export.writeAsString('new export');
    savePicker.destination = database;
    await expectLater(
      files.saveOrShare(export),
      throwsA(isA<KepliException>()),
    );
    expect(await database.readAsString(), 'existing vault');
  });

  test(
    'Android saves through the system document picker without large byte messages',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final export = File(p.join(work.path, 'export.zip'));
      await export.writeAsBytes([80, 75, 3, 4]);
      messenger.setMockMethodCallHandler(_storageChannel, (call) async {
        expect(call.method, 'saveExport');
        final args = call.arguments as Map;
        expect(args['sourcePath'], export.absolute.path);
        expect(args['fileName'], 'export.zip');
        expect(args['mimeType'], 'application/zip');
        expect(args.containsKey('bytes'), isFalse);
        expect(args['failureMessage'], isNotEmpty);
        return 'export.zip';
      });
      expect(
        await files.saveOrShare(export, languageCode: 'tr'),
        'Saved to export.zip',
      );
      messenger.setMockMethodCallHandler(_storageChannel, (_) async => null);
      expect(await files.saveOrShare(export), isNull);
      expect(await export.exists(), isTrue);
    },
  );

  test(
    'iPad sharing always has a nonzero origin and preserves a supplied anchor',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final original = File(p.join(work.path, 'export.pdf'));
      await original.writeAsString('%PDF-1.7');
      final calls = <MethodCall>[];
      messenger.setMockMethodCallHandler(_shareChannel, (call) async {
        calls.add(call);
        return 'com.apple.UIKit.activity.SaveToFiles';
      });
      expect(await files.saveOrShare(original), contains('selected app'));
      final fallback = calls.last.arguments as Map;
      expect(fallback['originWidth'], greaterThan(0));
      expect(fallback['originHeight'], greaterThan(0));
      expect(fallback['paths'], [original.path]);

      const anchor = Rect.fromLTWH(10, 20, 30, 40);
      await files.saveOrShare(original, shareOrigin: anchor);
      final anchored = calls.last.arguments as Map;
      expect(anchored['originX'], 10);
      expect(anchored['originY'], 20);
      expect(anchored['originWidth'], 30);
      expect(anchored['originHeight'], 40);
    },
  );

  test(
    'mobile share cancellation and unavailable results never claim a saved file',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final original = File(p.join(work.path, 'export.zip'));
      await original.writeAsBytes([1, 2]);
      messenger.setMockMethodCallHandler(_shareChannel, (_) async => '');
      expect(await files.saveOrShare(original), isNull);
      messenger.setMockMethodCallHandler(
        _shareChannel,
        (_) async => 'dev.fluttercommunity.plus/share/unavailable',
      );
      expect(
        await files.saveOrShare(original),
        contains('without confirming an export'),
      );
    },
  );

  test(
    'camera request persists business-card linkage before leaving the app',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final cameraFile = File(p.join(work.path, 'camera.png'));
      await cameraFile.writeAsBytes(_png);
      messenger.setMockMethodCallHandler(_imageChannel, (call) async {
        expect(call.method, 'pickImage');
        final context =
            jsonDecode(
                  await File(
                    p.join(work.path, 'pending-photo-request.json'),
                  ).readAsString(),
                )
                as Map;
        expect(context['role'], 'businessCard');
        expect(context['contactId'], _contactId);
        expect((call.arguments as Map)['requestFullMetadata'], isFalse);
        return cameraFile.path;
      });
      final attachment = await files.takePhoto(
        role: AttachmentRole.businessCard,
        contactId: _contactId,
      );
      expect(attachment!.contactId, _contactId);
      expect(attachment.role, AttachmentRole.businessCard);
      expect(attachment.sourcePath, isNot(cameraFile.path));
      expect(await File(attachment.sourcePath).readAsBytes(), _png);
      expect(
        await File(p.join(work.path, 'pending-photo-request.json')).exists(),
        isFalse,
      );
    },
  );

  test(
    'photo-library import supports multiple photos without full-metadata permission',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      final first = File(p.join(work.path, 'first.png'));
      final second = File(p.join(work.path, 'second.png'));
      await first.writeAsBytes(_png);
      await second.writeAsBytes(_png);
      messenger.setMockMethodCallHandler(_imageChannel, (call) async {
        expect(call.method, 'pickMultiImage');
        expect((call.arguments as Map)['requestFullMetadata'], isFalse);
        return [first.path, second.path];
      });
      final attachments = await files.pickPhotos(role: AttachmentRole.product);
      expect(attachments, hasLength(2));
      expect(
        attachments.every((value) => value.role == AttachmentRole.product),
        isTrue,
      );
    },
  );

  test(
    'camera cancellation returns null, permission errors remain visible',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      messenger.setMockMethodCallHandler(_imageChannel, (_) async => null);
      expect(await files.takePhoto(), isNull);
      messenger.setMockMethodCallHandler(_imageChannel, (_) async {
        throw PlatformException(code: 'camera_access_denied');
      });
      await expectLater(
        files.takePhoto(),
        throwsA(
          isA<KepliException>().having(
            (error) => error.message,
            'message',
            contains('camera_access_denied'),
          ),
        ),
      );
    },
  );

  test(
    'Android lost photos recover the original attachment role and contact',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final source = File(p.join(work.path, 'lost.png'));
      await source.writeAsBytes(_png);
      await File(p.join(work.path, 'pending-photo-request.json')).writeAsString(
        jsonEncode({'role': 'businessCard', 'contactId': _contactId}),
      );
      messenger.setMockMethodCallHandler(_imageChannel, (call) async {
        expect(call.method, 'retrieve');
        return {
          'type': 'image',
          'path': source.path,
          'pathList': [source.path],
        };
      });
      final recovered = await files.recoverLostPhotos();
      expect(recovered.single.role, AttachmentRole.businessCard);
      expect(recovered.single.contactId, _contactId);
      expect(await File(recovered.single.sourcePath).readAsBytes(), _png);
    },
  );

  test(
    'Android lost picker failures are surfaced, not converted to empty results',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      messenger.setMockMethodCallHandler(
        _imageChannel,
        (_) async => {
          'type': 'image',
          'errorCode': 'camera_error',
          'errorMessage': 'Camera could not create a photo.',
        },
      );
      await expectLater(
        files.recoverLostPhotos(),
        throwsA(
          isA<KepliException>().having(
            (error) => error.message,
            'message',
            contains('camera_error'),
          ),
        ),
      );
    },
  );

  test('lost-picker recovery is not called on non-Android platforms', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    messenger.setMockMethodCallHandler(_imageChannel, (_) async {
      fail('The Android-only lost-data API must not be called on iOS.');
    });
    expect(await files.recoverLostPhotos(), isEmpty);
  });

  for (final target in [TargetPlatform.iOS, TargetPlatform.macOS]) {
    test(
      '$target storage protection requires affirmative native confirmation',
      () async {
        debugDefaultTargetPlatformOverride = target;
        final root = Directory(p.join(work.path, 'vault'));
        messenger.setMockMethodCallHandler(_storageChannel, (call) async {
          expect(call.method, 'excludeFromBackup');
          expect((call.arguments as Map)['path'], root.absolute.path);
          return true;
        });
        await files.protectLocalStorage(root);
        expect(await root.exists(), isTrue);
        messenger.setMockMethodCallHandler(_storageChannel, (_) async => false);
        await expectLater(
          files.protectLocalStorage(root),
          throwsA(isA<KepliException>()),
        );
      },
    );
  }
}
