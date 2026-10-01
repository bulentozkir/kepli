import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as imaging;
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/document_scanner.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory root;
  late File source;
  late DocumentScanner scanner;

  setUp(() async {
    root = await Directory.systemTemp.createTemp('kepli-scan-test-');
    scanner = DocumentScanner(temporaryDirectory: root);
    source = File(p.join(root.path, 'original.png'));
    final image = imaging.Image(width: 100, height: 80);
    imaging.fill(image, color: imaging.ColorRgb8(100, 160, 200));
    await source.writeAsBytes(imaging.encodePng(image));
  });

  tearDown(() async => root.delete(recursive: true));

  test(
    'rotation and crop produce expected dimensions without altering source',
    () async {
      final original = await source.readAsBytes();
      final output = await DocumentScanner.processPage(
        ScanPage(
          sourcePath: source.path,
          quarterTurns: 1,
          cropLeft: 0.1,
          cropTop: 0.1,
          enhance: false,
        ),
      );
      final processed = imaging.decodeJpg(output)!;
      expect(processed.width, 72);
      expect(processed.height, 90);
      expect(await source.readAsBytes(), original);
    },
  );

  test('transparent documents are flattened onto a white background', () async {
    final transparent = imaging.Image(width: 30, height: 30, numChannels: 4);
    final file = File(p.join(root.path, 'transparent.png'));
    await file.writeAsBytes(imaging.encodePng(transparent));
    final bytes = await DocumentScanner.processPage(
      ScanPage(sourcePath: file.path, enhance: false),
    );
    final image = imaging.decodeJpg(bytes)!;
    final pixel = image.getPixel(0, 0);
    expect(pixel.r, greaterThanOrEqualTo(250));
    expect(pixel.g, greaterThanOrEqualTo(250));
    expect(pixel.b, greaterThanOrEqualTo(250));
  });

  test('produces an offline multipage PDF attachment', () async {
    final result = await scanner.createPdf(
      pages: [
        ScanPage(sourcePath: source.path),
        ScanPage(sourcePath: source.path, quarterTurns: 1),
      ],
      name: 'Warranty papers',
      role: AttachmentRole.warranty,
    );
    final bytes = await File(result.sourcePath).readAsBytes();
    expect(ascii.decode(bytes.take(5).toList()), '%PDF-');
    expect(
      RegExp(r'/Type\s*/Page\b').allMatches(latin1.decode(bytes)).length,
      2,
    );
    expect(result.originalName, 'Warranty papers.pdf');
    expect(result.role, AttachmentRole.warranty);
    expect(result.mimeType, 'application/pdf');
  });

  test('business card scan retains its contact relationship', () async {
    const contactId = '3f2a1b4c-2222-4444-8888-123456789012';
    final result = await scanner.createPdf(
      pages: [ScanPage(sourcePath: source.path)],
      name: 'Service business card',
      role: AttachmentRole.businessCard,
      contactId: contactId,
    );
    expect(result.contactId, contactId);
    expect(result.role, AttachmentRole.businessCard);
  });

  test('rejects missing pages, unsafe crop values and damaged input', () async {
    await expectLater(
      scanner.createPdf(pages: [], name: 'Empty', role: AttachmentRole.receipt),
      throwsA(isA<KepliException>()),
    );
    await expectLater(
      DocumentScanner.processPage(
        ScanPage(sourcePath: source.path, cropLeft: double.nan),
      ),
      throwsA(isA<KepliException>()),
    );
    final corrupt = File(p.join(root.path, 'broken.jpg'));
    await corrupt.writeAsBytes([1, 2, 3]);
    await expectLater(
      DocumentScanner.processPage(ScanPage(sourcePath: corrupt.path)),
      throwsA(isA<KepliException>()),
    );
  });
}
