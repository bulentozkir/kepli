import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:csv/csv.dart';
import 'package:image/image.dart' as imaging;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

import '../data/attachment_files.dart';
import '../data/vault_repository.dart';
import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import '../l10n/value_labels.dart';
import 'document_scanner.dart';
import 'pdf_fonts.dart';

class ReportService {
  ReportService({
    required this._repository,
    required Directory temporaryDirectory,
  }) : _temporaryDirectory = Directory(p.absolute(temporaryDirectory.path));

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
    'Sales contacts',
    'Service contacts',
  ];

  // Bound image decoding and PDF memory use. Originals remain untouched.
  static const maxSourceImagePixels = DocumentScanner.maxPixels;
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
        _safeText(_contactText(item.contacts, ContactRole.sales)),
        _safeText(_contactText(item.contacts, ContactRole.service)),
      ];
    }
  }

  static String _contactText(List<ItemContact> contacts, ContactRole role) =>
      contacts
          .where((contact) => contact.role == role)
          .map(
            (contact) => [
              contact.name,
              contact.organization,
              contact.phone,
              contact.email,
              contact.notes,
            ].nonNulls.where((value) => value.isNotEmpty).join(' | '),
          )
          .join('\n');

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
    for (final attachment in current.attachments) {
      await AttachmentFiles.verify(
        _repository.attachmentFile(attachment),
        attachment,
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
    final locale = snapshot.settings.languageCode;
    await initializeDateFormatting(locale);
    final strings = lookupAppLocalizations(ui.Locale(locale));
    final direction = const ['ar', 'fa', 'ur'].contains(locale)
        ? pw.TextDirection.rtl
        : pw.TextDirection.ltr;
    final dateFormat = DateFormat.yMMMd(locale);
    final today = CalendarDate.fromDateTime(DateTime.now());
    final monthCount = NumberFormat.decimalPattern(
      locale,
    ).format(current.warrantyLengthMonths);
    final fields = <List<String>>[
      [strings.name, current.name],
      [strings.category, localizeCategory(strings, current.category)],
      [strings.purchaseDate, dateFormat.format(current.purchaseDate.localDate)],
      [strings.warrantyLength, '$monthCount ${strings.months}'],
      [strings.expiryDate, dateFormat.format(current.expiryDate.localDate)],
      [strings.status, localizeStatus(strings, current.statusAt(today))],
      [
        strings.price,
        current.price == null
            ? strings.notSet
            : '${current.price} ${current.currency}',
      ],
      [strings.vendor, current.vendor ?? strings.notSet],
      ['ID', current.id],
    ];
    final fontText = <String>[
      for (final field in fields) ...field,
      strings.reportTitle,
      strings.documentFooter,
      strings.pageNumber(100),
      strings.notes,
      strings.notSet,
      strings.attachments,
      strings.pdfReferences,
      strings.contacts,
      strings.salesContact,
      strings.serviceContact,
      strings.organization,
      strings.phone,
      strings.email,
      strings.contactNotes,
      current.notes ?? '',
      for (final attachment in current.attachments) ...[
        attachment.originalName,
        localizeAttachmentRole(strings, attachment.role),
      ],
      for (final contact in current.contacts) ...[
        contact.name,
        contact.organization ?? '',
        contact.phone ?? '',
        contact.email ?? '',
        contact.notes ?? '',
      ],
    ];
    final fonts = await loadReportFonts(fontText);
    final document = pw.Document(
      theme: pw.ThemeData.withFont(
        base: fonts.regular,
        bold: fonts.bold,
        fontFallback: fonts.fallback,
      ),
      title: 'Kepli ${strings.reportTitle}: ${current.name}',
      author: 'Kepli',
      creator: 'Kepli (offline)',
    );
    String attachmentLabel(WarrantyAttachment attachment) {
      final contact = current.contacts
          .where((contact) => contact.id == attachment.contactId)
          .firstOrNull;
      return '${localizeAttachmentRole(strings, attachment.role)}'
          '${contact == null ? '' : ' - ${contact.name}'}: '
          '${attachment.originalName}';
    }

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        textDirection: direction,
        maxPages: 100,
        footer: (context) => pw.Text(
          '${strings.documentFooter} - ${strings.pageNumber(context.pageNumber)}',
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
        ),
        build: (context) => [
          pw.Header(level: 0, text: strings.reportTitle),
          pw.TableHelper.fromTextArray(
            data: fields,
            headerCount: 0,
            columnWidths: {0: const pw.FixedColumnWidth(110)},
            cellAlignment: direction == pw.TextDirection.rtl
                ? pw.Alignment.topRight
                : pw.Alignment.topLeft,
            cellPadding: const pw.EdgeInsets.all(6),
            cellStyle: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 16),
          pw.Header(level: 1, text: strings.notes),
          pw.Text(
            current.notes?.isNotEmpty == true ? current.notes! : strings.notSet,
            overflow: pw.TextOverflow.span,
          ),
          if (current.contacts.isNotEmpty) ...[
            pw.SizedBox(height: 16),
            pw.Header(level: 1, text: strings.contacts),
            for (final contact in current.contacts) ...[
              pw.Header(
                level: 2,
                text:
                    '${localizeContactRole(strings, contact.role)}: ${contact.name}',
              ),
              for (final detail in [
                (strings.organization, contact.organization),
                (strings.phone, contact.phone),
                (strings.email, contact.email),
                (strings.contactNotes, contact.notes),
              ])
                if (detail.$2 != null && detail.$2!.isNotEmpty)
                  pw.Text(
                    '${detail.$1}: ${detail.$2}',
                    overflow: pw.TextOverflow.span,
                  ),
            ],
          ],
          pw.SizedBox(height: 16),
          pw.Header(level: 1, text: strings.attachments),
          if (current.attachments.any((attachment) => attachment.isPdf))
            pw.Paragraph(text: strings.pdfReferences),
          if (current.attachments.isEmpty)
            pw.Paragraph(text: strings.notSet)
          else
            ...current.attachments.map(
              (attachment) => pw.Paragraph(text: attachmentLabel(attachment)),
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
          textDirection: direction,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                attachmentLabel(attachment),
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
                'SHA-256: ${attachment.sha256}',
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

  Future<({pw.MemoryImage image, int pixels})> _decodeImage(
    WarrantyAttachment attachment,
    int remainingPixels,
  ) async {
    try {
      final bytes = await _renderImage(
        _repository.attachmentFile(attachment).path,
      );
      final descriptor = imaging.JpegDecoder().startDecode(bytes);
      if (descriptor == null) {
        throw const KepliException('The receipt preview could not be decoded.');
      }

      final pixels = descriptor.width * descriptor.height;
      if (pixels > remainingPixels) {
        throw const KepliException(
          'This report exceeds the 32-megapixel rendered-image safety limit. '
          'Export the original images in a ZIP backup instead.',
        );
      }
      return (image: pw.MemoryImage(bytes), pixels: pixels);
    } on Exception catch (error) {
      throw KepliException(
        'Receipt image "${attachment.originalName}" could not be decoded. '
        'It may be damaged or unsupported; no report was exported. ($error)',
      );
    }
  }

  static Future<Uint8List> _renderImage(String path) => Isolate.run(
    () =>
        DocumentScanner.processPage(ScanPage(sourcePath: path, enhance: false)),
  );

  Future<Directory> _newDirectory() async {
    final managed = p.join(_repository.root.path, 'attachments');
    if (p.equals(managed, _temporaryDirectory.path) ||
        p.isWithin(managed, _temporaryDirectory.path)) {
      throw const KepliException(
        'Report staging must be outside the managed attachments directory.',
      );
    }
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
