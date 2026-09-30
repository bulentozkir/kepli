import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

import '../data/vault_repository.dart';
import '../domain/models.dart';

class ReportService {
  ReportService({
    required VaultRepository repository,
    required Directory temporaryDirectory,
  }) : _repository = repository,
       _temporaryDirectory = Directory(p.absolute(temporaryDirectory.path));

  static const csvColumns = [
    'ID',
    'Name',
    'Category',
    'Purchase date',
    'Price',
    'Currency',
    'Vendor',
    'Warranty length (months)',
    'Expiry date',
    'Status',
    'Notes',
    'Attachment count',
    'Attachment names',
    'Created at (UTC)',
    'Updated at (UTC)',
  ];

  // Bound image decoding and PDF memory use. Originals remain untouched.
  static const maxSourceImagePixels = 40 * 1024 * 1024;
  static const maxReportImagePixels = 32 * 1024 * 1024;
  static const maxReportImageBytes = 64 * 1024 * 1024;

  final VaultRepository _repository;
  final Directory _temporaryDirectory;

  Future<File> exportCsv(VaultSnapshot snapshot) async {
    snapshot.validate();
    final directory = await _newDirectory();
    final file = File(p.join(directory.path, 'kepli-warranties.csv'));
    try {
      await Stream<List<dynamic>>.fromIterable(_csvRows(snapshot))
          .transform(Csv(addBom: true).encoder)
          .transform(utf8.encoder)
          .pipe(file.openWrite());
      return file;
    } catch (error) {
      await _removeFailedDirectory(directory, error);
      rethrow;
    }
  }

  static Iterable<List<dynamic>> _csvRows(VaultSnapshot snapshot) sync* {
    yield csvColumns;
    final today = CalendarDate.fromDateTime(DateTime.now());
    for (final item in snapshot.items) {
      yield [
        _safeText(item.id),
        _safeText(item.name),
        _safeText(item.category),
        item.purchaseDate.toString(),
        // Exact decimal text stays numeric in spreadsheet applications.
        item.price ?? '',
        _safeText(item.currency),
        _safeText(item.vendor ?? ''),
        item.warrantyLengthMonths,
        item.expiryDate.toString(),
        item.statusAt(today).name,
        _safeText(item.notes ?? ''),
        item.attachments.length,
        _safeText(
          item.attachments.map((entry) => entry.originalName).join('; '),
        ),
        item.createdAt.toUtc().toIso8601String(),
        item.updatedAt.toUtc().toIso8601String(),
      ];
    }
  }

  static String _safeText(String value) {
    final formula = RegExp(r'^[\s\u0000-\u0020\u007f-\u009f\uFEFF]*[=+\-@]');
    if (formula.hasMatch(value) ||
        value.startsWith('\t') ||
        value.startsWith('\r') ||
        value.startsWith('\n')) {
      return "'$value";
    }
    return value;
  }

  Future<File> exportItemPdf(WarrantyItem item) => _repository.withSnapshot((
    snapshot,
  ) async {
    final current = snapshot.items
        .where((entry) => entry.id == item.id)
        .firstOrNull;
    if (current == null) {
      throw const KepliException(
        'This warranty no longer exists. Refresh before exporting it.',
      );
    }
    final images = current.attachments.where(
      (attachment) => attachment.isImage,
    );
    if (images.fold(0, (sum, image) => sum + image.size) >
        maxReportImageBytes) {
      throw const KepliException(
        'This report contains more than 64 MiB of images. '
        'Export the original files in a ZIP backup instead.',
      );
    }
    final theme = await _loadFonts();
    final document = pw.Document(
      theme: theme,
      title: 'Kepli warranty report: ${current.name}',
      author: 'Kepli',
      creator: 'Kepli (offline)',
    );
    final today = CalendarDate.fromDateTime(DateTime.now());
    final fields = <List<String>>[
      ['Item', current.name],
      ['Category', current.category],
      ['Purchase date', current.purchaseDate.toString()],
      ['Warranty', '${current.warrantyLengthMonths} months'],
      ['Expiry date', current.expiryDate.toString()],
      ['Status', current.statusAt(today).name],
      [
        'Price',
        current.price == null
            ? 'Not recorded'
            : '${current.price} ${current.currency}',
      ],
      ['Store / vendor', current.vendor ?? 'Not recorded'],
      ['Item ID', current.id],
      ['Created (UTC)', current.createdAt.toUtc().toIso8601String()],
      ['Updated (UTC)', current.updatedAt.toUtc().toIso8601String()],
    ];
    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        maxPages: 100,
        footer: (context) => pw.Text(
          'Kepli · Private, offline warranty report · Page ${context.pageNumber}',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
        build: (context) => [
          pw.Header(level: 0, text: 'Warranty report'),
          pw.TableHelper.fromTextArray(
            data: fields,
            headerCount: 0,
            columnWidths: {0: const pw.FixedColumnWidth(110)},
            cellAlignment: pw.Alignment.topLeft,
            cellPadding: const pw.EdgeInsets.all(6),
            cellStyle: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 16),
          pw.Header(level: 1, text: 'Notes'),
          pw.Paragraph(
            text: current.notes?.isNotEmpty == true
                ? current.notes!
                : 'No notes.',
          ),
          pw.Header(level: 1, text: 'Attachments'),
          if (current.attachments.isEmpty)
            pw.Paragraph(text: 'No attachments.')
          else
            ...current.attachments.map(
              (attachment) => pw.Paragraph(
                text: attachment.isPdf
                    ? 'PDF reference: ${attachment.originalName}\n'
                          'Original PDF is not embedded. Include it separately or share the ZIP backup.'
                    : '${attachment.role.name}: ${attachment.originalName}\n'
                          'Image included on a following page.',
              ),
            ),
        ],
      ),
    );
    var remainingPixels = maxReportImagePixels;
    for (final attachment in images) {
      final decoded = await _decodeImage(attachment, remainingPixels);
      remainingPixels -= decoded.pixels;
      document.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(36),
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${attachment.role.name}: ${attachment.originalName}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),
              pw.Expanded(
                child: pw.Center(
                  child: pw.Image(decoded.image, fit: pw.BoxFit.contain),
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                'Original SHA-256: ${attachment.sha256}',
                style: const pw.TextStyle(fontSize: 8),
              ),
            ],
          ),
        ),
      );
    }
    final bytes = await document.save();
    final directory = await _newDirectory();
    final file = File(
      p.join(directory.path, 'kepli-warranty-${current.id}.pdf'),
    );
    try {
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (error) {
      await _removeFailedDirectory(directory, error);
      rethrow;
    }
  });

  static Future<pw.ThemeData> _loadFonts() async {
    try {
      final regular = await rootBundle.load(
        'assets/fonts/NotoSans-Regular.ttf',
      );
      final bold = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
      return pw.ThemeData.withFont(
        base: pw.Font.ttf(regular),
        bold: pw.Font.ttf(bold),
      );
    } catch (error) {
      throw KepliException(
        'The bundled offline PDF fonts could not be loaded. Reinstall Kepli. ($error)',
      );
    }
  }

  Future<({pw.MemoryImage image, int pixels})> _decodeImage(
    WarrantyAttachment attachment,
    int remainingPixels,
  ) async {
    ui.ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    ui.Codec? codec;
    ui.Image? image;
    try {
      final bytes = await _repository.attachmentFile(attachment).readAsBytes();
      buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      descriptor = await ui.ImageDescriptor.encoded(buffer);
      if (descriptor.width * descriptor.height > maxSourceImagePixels) {
        throw KepliException(
          'Image "${attachment.originalName}" exceeds the 40-megapixel decoding limit.',
        );
      }
      final scale = math.min(
        1.0,
        2400 / math.max(descriptor.width, descriptor.height),
      );
      final width = math.max(1, (descriptor.width * scale).round());
      final height = math.max(1, (descriptor.height * scale).round());
      final pixels = width * height;
      if (pixels > remainingPixels) {
        throw const KepliException(
          'This report exceeds the 32-megapixel rendered-image safety limit. '
          'Export the original images in a ZIP backup instead.',
        );
      }
      codec = await descriptor.instantiateCodec(
        targetWidth: width,
        targetHeight: height,
      );
      image = (await codec.getNextFrame()).image;
      final png = await image.toByteData(format: ui.ImageByteFormat.png);
      if (png == null)
        throw const KepliException('The decoded image could not be encoded.');
      return (
        image: pw.MemoryImage(
          png.buffer.asUint8List(png.offsetInBytes, png.lengthInBytes),
        ),
        pixels: pixels,
      );
    } on KepliException {
      rethrow;
    } catch (error) {
      throw KepliException(
        'Receipt image "${attachment.originalName}" could not be decoded. '
        'It may be damaged or unsupported; no report was exported. ($error)',
      );
    } finally {
      image?.dispose();
      codec?.dispose();
      descriptor?.dispose();
      buffer?.dispose();
    }
  }

  Future<Directory> _newDirectory() async {
    final type = await FileSystemEntity.type(
      _temporaryDirectory.path,
      followLinks: false,
    );
    if (type != FileSystemEntityType.notFound &&
        type != FileSystemEntityType.directory) {
      throw const KepliException(
        'The report staging location must be a directory, not a link.',
      );
    }
    await _temporaryDirectory.create(recursive: true);
    return Directory(
      p.join(_temporaryDirectory.path, 'kepli-report-${const Uuid().v4()}'),
    ).create();
  }

  static Future<void> _removeFailedDirectory(
    Directory directory,
    Object original,
  ) async {
    try {
      await directory.delete(recursive: true);
    } on FileSystemException catch (error) {
      throw KepliException(
        '$original The incomplete report could not be removed: ${error.message}.',
      );
    }
  }
}
