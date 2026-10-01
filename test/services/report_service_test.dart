import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/report_service.dart';
import 'package:uuid/uuid.dart';

import '../data/test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late VaultHarness harness;
  late ReportService service;

  setUp(() async {
    harness = await VaultHarness.create();
    service = ReportService(
      repository: harness.repository,
      temporaryDirectory: harness.work,
    );
  });
  tearDown(() async => harness.dispose());

  test('CSV has explicit columns and round-trips quotes, commas, newlines and Unicode', () async {
    final item = sampleItem(
      name: 'Café, "Drill"\nLarge',
      vendor: 'Shop, "Counter 2"',
      notes: 'Line one\r\nLine two, with "quotes"',
      price: '1234.50',
    );
    await harness.repository.saveItem(item);
    final file = await service.exportCsv(await harness.repository.load());
    final text = await file.readAsString();
    final rows = Csv().decode(text);
    expect(rows.first, ReportService.csvColumns);
    expect(rows, hasLength(2));
    expect(rows[1][1], item.name);
    expect(rows[1][4], '1234.50');
    expect(rows[1][6], item.vendor);
    expect(rows[1][10], item.notes);
    expect(text, contains('""Drill""'));
    expect(text, contains('\r\n'));
    expect(rows[1][8], '2025-02-28');
    expect(rows[1][14], item.updatedAt.toUtc().toIso8601String());
  });

  test(
    'CSV neutralizes formula prefixes in every untrusted textual field',
    () async {
      final prefixes = [
        '=HYPERLINK("https://example.invalid")',
        '+SUM(1,2)',
        '-2+3',
        '@SUM(A1:A2)',
        '  =1+2',
        '\t@SUM(1,2)',
        '\r=1+2',
        '\n+1+2',
        '\uFEFF=1+2',
      ];
      for (final value in prefixes) {
        await harness.repository.saveItem(
          sampleItem(
            id: const Uuid().v4(),
            name: value,
            vendor: value,
            notes: value,
            price: '0.00',
          ),
        );
      }
      final snapshot = await harness.repository.load();
      final rows = Csv().decode(
        await (await service.exportCsv(snapshot)).readAsString(),
      );
      for (var index = 0; index < snapshot.items.length; index++) {
        final original = snapshot.items[index];
        final row = rows[index + 1];
        expect(row[1], "'${original.name}");
        expect(row[6], "'${original.vendor}");
        expect(row[10], "'${original.notes}");
        expect(row[4], '0.00');
        expect(row[7], '13');
      }
    },
  );

  test(
    'CSV neutralizes custom category and attachment-name formulas too',
    () async {
      await harness.saveWithPdf(
        sampleItem(category: '=Custom category'),
        originalName: '@receipt.pdf',
      );
      final rows = Csv().decode(
        await (await service.exportCsv(await harness.repository.load()))
            .readAsString(),
      );
      expect(rows[1][2], "'=Custom category");
      expect(rows[1][12], "'@receipt.pdf");
      expect(rows[1][11], '1');
    },
  );

  test(
    'CSV reports claimed state and never converts null prices into zero',
    () async {
      await harness.repository.saveItem(sampleItem(claimed: true, price: null));
      final rows = Csv().decode(
        await (await service.exportCsv(await harness.repository.load()))
            .readAsString(),
      );
      expect(rows[1][9], 'claimed');
      expect(rows[1][4], '');
    },
  );

  test(
    'separate report exports never overwrite a previously exported report',
    () async {
      await harness.repository.saveItem(sampleItem());
      final snapshot = await harness.repository.load();
      final first = await service.exportCsv(snapshot);
      final content = await first.readAsBytes();
      final second = await service.exportCsv(snapshot);
      expect(first.path, isNot(second.path));
      expect(await first.readAsBytes(), content);
    },
  );

  test('offline PDF is a complete document with image and PDF reference attachments', () async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    canvas.drawColor(const ui.Color(0xff445566), ui.BlendMode.src);
    final picture = recorder.endRecording();
    final image = await picture.toImage(40, 30);
    final png = (await image.toByteData(format: ui.ImageByteFormat.png))!;
    final imageFile = await harness.source(
      png.buffer.asUint8List(png.offsetInBytes, png.lengthInBytes),
      suffix: 'png',
    );
    image.dispose();
    picture.dispose();
    final pdfFile = await harness.source(smallPdf);
    await harness.repository.saveItem(
      sampleItem(
        name: r'Drill (large) \ Model',
        notes: 'Café — "proof", original receipt.',
      ),
      additions: [
        PendingAttachment(
          sourcePath: imageFile.path,
          originalName: 'receipt (photo).png',
          mimeType: 'image/png',
        ),
        PendingAttachment(
          sourcePath: pdfFile.path,
          originalName: 'original warranty.pdf',
          mimeType: 'application/pdf',
        ),
      ],
    );
    final item = (await harness.repository.load()).items.single;
    final report = await service.exportItemPdf(item);
    final bytes = await report.readAsBytes();
    final ascii = latin1.decode(bytes);
    expect(ascii, startsWith('%PDF-1.'));
    expect(ascii.substring(ascii.length - 30), contains('%%EOF'));
    expect(RegExp(r'/Type\s*/Catalog').hasMatch(ascii), isTrue);
    expect(RegExp(r'/Subtype\s*/Image').hasMatch(ascii), isTrue);
    expect(ascii, contains('/Font'));
    expect(bytes.length, greaterThan(1000));
    expect(
      (await harness.repository.load()).items.single.toJson(),
      item.toJson(),
    );
  });

  test('PDF uses live metadata under the snapshot lock rather than stale item details', () async {
    final stale = sampleItem(name: 'Before edit');
    await harness.repository.saveItem(stale);
    await harness.repository.saveItem(
      sampleItem(name: 'After edit', updatedAt: DateTime.utc(2026)),
    );
    final output = await service.exportItemPdf(stale);
    expect(await output.length(), greaterThan(1000));
    final ascii = latin1.decode(await output.readAsBytes());
    expect(ascii, contains('After edit'));
    expect(ascii, isNot(contains('Before edit')));
  });

  test(
    'a damaged image fails visibly instead of disappearing from the PDF',
    () async {
      final damaged = await harness.source([
        0x89,
        0x50,
        0x4e,
        0x47,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        0,
      ], suffix: 'png');
      await harness.repository.saveItem(
        sampleItem(),
        additions: [
          PendingAttachment(
            sourcePath: damaged.path,
            originalName: 'damaged receipt.png',
            mimeType: 'image/png',
          ),
        ],
      );
      final item = (await harness.repository.load()).items.single;
      await expectLater(
        service.exportItemPdf(item),
        throwsA(
          isA<KepliException>()
              .having(
                (error) => error.message,
                'filename',
                contains('damaged receipt.png'),
              )
              .having(
                (error) => error.message,
                'reason',
                contains('could not be decoded'),
              ),
        ),
      );
      final reports = await harness.base
          .list(recursive: true)
          .where(
            (file) => file is File && file.path.contains('kepli-warranty-'),
          )
          .toList();
      expect(reports, isEmpty);
      expect(
        await harness.repository
            .attachmentFile(item.attachments.single)
            .exists(),
        isTrue,
      );
    },
  );

  test(
    'PDF refuses a deleted item without exporting a misleading empty report',
    () async {
      await expectLater(
        service.exportItemPdf(sampleItem()),
        throwsA(isA<KepliException>()),
      );
    },
  );
}
