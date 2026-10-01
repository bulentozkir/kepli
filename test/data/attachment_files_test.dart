import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/data/attachment_files.dart';
import 'package:kepli/domain/models.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

void main() {
  const itemId = '11111111-1111-4111-8111-111111111111';
  const attachmentId = '22222222-2222-4222-8222-222222222222';
  final bytes = utf8.encode('%PDF-1.4\nReceipt bytes\n%%EOF\n');
  late Directory base;
  late Directory root;
  late File source;

  setUp(() async {
    base = Directory(
      p.join(
        Directory.current.path,
        '.dart_tool',
        'kepli-file-tests',
        const Uuid().v4(),
      ),
    );
    root = Directory(p.join(base.path, 'vault'));
    await AttachmentFiles.initialize(root);
    source = File(p.join(base.path, 'original.pdf'));
    await source.writeAsBytes(bytes);
  });
  tearDown(() async {
    await base.delete(recursive: true);
  });

  WarrantyAttachment metadata(String path, {String? digest}) =>
      WarrantyAttachment(
        id: attachmentId,
        relativePath: path,
        originalName: 'Receipt.pdf',
        mimeType: 'application/pdf',
        role: AttachmentRole.receipt,
        size: bytes.length,
        sha256: digest ?? sha256.convert(bytes).toString(),
        addedAt: DateTime.utc(2024),
      );

  test('copies and hashes exactly the durable destination bytes', () async {
    final target = await AttachmentFiles.create(
      root,
      itemId,
      'application/pdf',
    );
    final digest = await AttachmentFiles.copy(
      source: source,
      target: target,
      mimeType: 'application/pdf',
    );
    final path = AttachmentFiles.relativePath(root, target);
    expect(path, startsWith('attachments/$itemId/'));
    expect(path, isNot(contains(r'\')));
    expect(digest.size, bytes.length);
    expect(digest.sha256, sha256.convert(bytes).toString());
    expect(await target.readAsBytes(), bytes);
    AttachmentFiles.validateMetadata(metadata(path), itemId);
    await AttachmentFiles.verify(target, metadata(path));
    await source.delete();
    expect(await target.readAsBytes(), bytes);
  });

  test(
    'fresh immutable names never overwrite an existing attachment',
    () async {
      final first = await AttachmentFiles.create(
        root,
        itemId,
        'application/pdf',
      );
      await AttachmentFiles.copy(
        source: source,
        target: first,
        mimeType: 'application/pdf',
      );
      final second = await AttachmentFiles.create(
        root,
        itemId,
        'application/pdf',
      );
      expect(second.path, isNot(first.path));
      expect(await first.readAsBytes(), bytes);
      expect(await second.length(), 0);
    },
  );

  test('rejects unsupported MIME and mismatched file signatures', () async {
    expect(
      () => AttachmentFiles.extensionFor('image/heic'),
      throwsA(isA<KepliException>()),
    );
    final target = await AttachmentFiles.create(root, itemId, 'image/png');
    await expectLater(
      AttachmentFiles.copy(
        source: source,
        target: target,
        mimeType: 'image/png',
      ),
      throwsA(isA<KepliException>()),
    );
    expect(await source.readAsBytes(), bytes);
  });

  test('rejects corrupt receipt hashes and missing files', () async {
    final path = 'attachments/$itemId/$attachmentId.pdf';
    await expectLater(
      AttachmentFiles.verify(
        source,
        metadata(path, digest: List.filled(64, '0').join()),
      ),
      throwsA(isA<KepliException>()),
    );
    await source.delete();
    await expectLater(
      AttachmentFiles.verify(source, metadata(path)),
      throwsA(isA<KepliException>()),
    );
  });

  test('enforces the 256 MiB safety cap before reading content', () async {
    final oversized = await source.open(mode: FileMode.writeOnly);
    await oversized.truncate(AttachmentFiles.maxAttachmentBytes + 1);
    await oversized.close();
    final target = await AttachmentFiles.create(
      root,
      itemId,
      'application/pdf',
    );
    await expectLater(
      AttachmentFiles.copy(
        source: source,
        target: target,
        mimeType: 'application/pdf',
      ),
      throwsA(isA<KepliException>()),
    );
    expect(await target.length(), 0);
  });

  test('rejects traversal, absolute paths and invalid filename UUIDs', () {
    for (final path in [
      '../original.pdf',
      '/original.pdf',
      r'C:\original.pdf',
      'attachments/$itemId/../../original.pdf',
      'attachments/$itemId/------------------------------------.pdf',
    ]) {
      expect(
        () => AttachmentFiles.file(root, path),
        throwsA(isA<KepliException>()),
      );
    }
  });

  test('will not treat a directory as an attachment file', () async {
    final relative = 'attachments/$itemId/$attachmentId.pdf';
    await Directory(
      p.join(root.path, 'attachments', itemId, '$attachmentId.pdf'),
    ).create(recursive: true);
    expect(
      () => AttachmentFiles.file(root, relative),
      throwsA(isA<KepliException>()),
    );
  });

  test(
    'rejects filesystem links in the attachment directory',
    () async {
      final outside = Directory(p.join(base.path, 'outside'));
      await outside.create();
      await Link(p.join(root.path, 'attachments', itemId)).create(outside.path);
      expect(
        () =>
            AttachmentFiles.file(root, 'attachments/$itemId/$attachmentId.pdf'),
        throwsA(isA<KepliException>()),
      );
      expect(await outside.list().isEmpty, isTrue);
    },
    skip: Platform.isWindows
        ? 'Creating OS symlinks requires Windows developer/admin privileges.'
        : false,
  );
}
