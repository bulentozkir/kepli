import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as imaging;
import 'package:path/path.dart' as p;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:uuid/uuid.dart';

import '../domain/models.dart';

class ScanPage {
  const ScanPage({
    required this.sourcePath,
    this.quarterTurns = 0,
    this.cropTop = 0,
    this.cropBottom = 0,
    this.cropLeft = 0,
    this.cropRight = 0,
    this.enhance = true,
  });

  final String sourcePath;
  final int quarterTurns;
  final double cropTop;
  final double cropBottom;
  final double cropLeft;
  final double cropRight;
  final bool enhance;

  ScanPage copyWith({
    int? quarterTurns,
    double? cropTop,
    double? cropBottom,
    double? cropLeft,
    double? cropRight,
    bool? enhance,
  }) => ScanPage(
    sourcePath: sourcePath,
    quarterTurns: quarterTurns ?? this.quarterTurns,
    cropTop: cropTop ?? this.cropTop,
    cropBottom: cropBottom ?? this.cropBottom,
    cropLeft: cropLeft ?? this.cropLeft,
    cropRight: cropRight ?? this.cropRight,
    enhance: enhance ?? this.enhance,
  );

  void validate() {
    for (final edge in [cropTop, cropBottom, cropLeft, cropRight]) {
      if (!edge.isFinite || edge < 0 || edge > 0.45) {
        throw const KepliException(
          'Each crop edge must be between 0 and 45 percent.',
        );
      }
    }
    if (sourcePath.isEmpty) {
      throw const KepliException('A scan page needs an image.');
    }
  }
}

class DocumentScanner {
  const DocumentScanner({required this.temporaryDirectory});

  final Directory temporaryDirectory;

  static const maxPages = 50;
  static const maxSourceBytes = 64 * 1024 * 1024;
  static const maxPixels = 40 * 1000 * 1000;
  static const maxOutputEdge = 2400;

  Future<PendingAttachment> createPdf({
    required List<ScanPage> pages,
    required String name,
    required AttachmentRole role,
    String? contactId,
  }) async {
    if (pages.isEmpty || pages.length > maxPages) {
      throw const KepliException(
        'A document must have between 1 and 50 pages.',
      );
    }
    if (name.trim().isEmpty || name.length > 180) {
      throw const KepliException(
        'Enter a document name of 1 to 180 characters.',
      );
    }
    if (role == AttachmentRole.businessCard &&
        (contactId == null || !isUuid(contactId))) {
      throw const KepliException('Select a contact for this business card.');
    }
    for (final page in pages) {
      page.validate();
    }
    final directory = Directory(p.join(temporaryDirectory.path, 'scans'));
    await directory.create(recursive: true);
    final output = p.join(directory.path, '${const Uuid().v4()}.pdf');
    final immutablePages = List<ScanPage>.of(pages);
    await Isolate.run(() => _writeDocument(immutablePages, output));
    final safeName = name.trim().replaceAll(
      RegExp(r'[<>:"/\\|?*\x00-\x1f]'),
      '_',
    );
    final filename = safeName.toLowerCase().endsWith('.pdf')
        ? safeName
        : '$safeName.pdf';
    return PendingAttachment(
      sourcePath: output,
      originalName: filename,
      mimeType: 'application/pdf',
      role: role,
      contactId: contactId,
    );
  }

  static Future<void> _writeDocument(
    List<ScanPage> pages,
    String output,
  ) async {
    final document = pdf.Document(
      creator: 'Kepli',
      producer: 'Kepli offline document scanner',
    );
    for (final page in pages) {
      final jpeg = await processPage(page);
      document.addPage(
        pdf.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pdf.EdgeInsets.all(18),
          build: (context) => pdf.Center(
            child: pdf.Image(pdf.MemoryImage(jpeg), fit: pdf.BoxFit.contain),
          ),
        ),
      );
    }
    final file = File(output);
    final pending = File('$output.partial');
    try {
      await pending.writeAsBytes(await document.save(), flush: true);
      await pending.rename(file.path);
    } finally {
      if (await pending.exists()) await pending.delete();
    }
  }

  static Future<Uint8List> processPage(ScanPage page) async {
    page.validate();
    final file = File(page.sourcePath);
    final length = await file.length();
    if (length < 16 || length > maxSourceBytes) {
      throw const KepliException(
        'Scan images must be nonempty and smaller than 64 MB.',
      );
    }
    final bytes = await file.readAsBytes();
    final decoded = _decodeImage(bytes);
    var image = imaging.bakeOrientation(decoded);
    final turns = page.quarterTurns % 4;
    if (turns != 0) {
      image = imaging.copyRotate(image, angle: turns * 90);
    }
    final left = (image.width * page.cropLeft).round();
    final top = (image.height * page.cropTop).round();
    final right = (image.width * page.cropRight).round();
    final bottom = (image.height * page.cropBottom).round();
    image = imaging.copyCrop(
      image,
      x: left,
      y: top,
      width: image.width - left - right,
      height: image.height - top - bottom,
    );
    if (image.width > maxOutputEdge || image.height > maxOutputEdge) {
      image = imaging.copyResize(
        image,
        width: image.width >= image.height ? maxOutputEdge : null,
        height: image.height > image.width ? maxOutputEdge : null,
        interpolation: imaging.Interpolation.average,
      );
    }
    if (image.hasAlpha) {
      final background = imaging.Image(
        width: image.width,
        height: image.height,
        numChannels: 3,
      );
      imaging.fill(background, color: imaging.ColorRgb8(255, 255, 255));
      image = imaging.compositeImage(background, image);
    }
    if (page.enhance) {
      image = imaging.adjustColor(image, contrast: 1.15, saturation: 0);
    }
    return Uint8List.fromList(imaging.encodeJpg(image, quality: 88));
  }

  static imaging.Image _decodeImage(Uint8List bytes) {
    try {
      final decoder = imaging.findDecoderForData(bytes);
      final info = decoder?.startDecode(bytes);
      if (info == null) {
        throw const KepliException(
          'This image cannot be scanned. Choose a JPEG, PNG or another supported image.',
        );
      }
      if (info.width * info.height > maxPixels) {
        throw const KepliException(
          'Resize scan images larger than 40 megapixels first.',
        );
      }
      final decoded = decoder!.decodeFrame(0);
      if (decoded == null) {
        throw const KepliException('The scan image is damaged or incomplete.');
      }
      return decoded;
    } on RangeError {
      throw const KepliException('The scan image is damaged or incomplete.');
    } on FormatException {
      throw const KepliException('The scan image is damaged or incomplete.');
    } on imaging.ImageException {
      throw const KepliException('The scan image is damaged or incomplete.');
    }
  }
}
