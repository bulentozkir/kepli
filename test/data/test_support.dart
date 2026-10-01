import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart' as archive;
import 'package:drift/native.dart';
import 'package:kepli/data/kepli_database.dart';
import 'package:kepli/data/vault_repository.dart';
import 'package:kepli/domain/models.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

const firstItemId = '11111111-1111-4111-8111-111111111111';
const secondItemId = '22222222-2222-4222-8222-222222222222';

final smallPdf = utf8.encode(
  '%PDF-1.4\n1 0 obj\n<< /Type /Catalog >>\nendobj\n'
  'trailer\n<< /Root 1 0 R >>\n%%EOF\n',
);

WarrantyItem sampleItem({
  String id = firstItemId,
  String name = 'Cordless drill',
  String category = 'Tools',
  String? price = '149.90',
  String currency = 'USD',
  String? vendor = 'Local hardware',
  String? notes = 'Keep the receipt.',
  DateTime? createdAt,
  DateTime? updatedAt,
  bool claimed = false,
  List<WarrantyAttachment> attachments = const [],
  List<ItemContact> contacts = const [],
}) => WarrantyItem(
  id: id,
  name: name,
  category: category,
  purchaseDate: CalendarDate(2024, 1, 31),
  warrantyLengthMonths: 13,
  price: price,
  currency: currency,
  vendor: vendor,
  notes: notes,
  createdAt: createdAt ?? DateTime.utc(2024, 2, 1, 10, 20, 30, 123, 456),
  updatedAt: updatedAt ?? DateTime.utc(2024, 2, 2, 10, 20, 30, 123, 456),
  attachments: attachments,
  contacts: contacts,
  claimed: claimed,
);

class VaultHarness {
  VaultHarness._(this.base, this.root, this.database, this.repository);

  final Directory base;
  final Directory root;
  final KepliDatabase database;
  final VaultRepository repository;

  Directory get work => Directory(p.join(base.path, 'exports'));
  File get databaseFile => File(p.join(root.path, 'kepli.db'));

  static Future<VaultHarness> create({bool persistent = false}) async {
    final base = Directory(
      p.join(
        Directory.current.path,
        '.dart_tool',
        'kepli-tests',
        const Uuid().v4(),
      ),
    );
    final root = Directory(p.join(base.path, 'vault'));
    await root.create(recursive: true);
    final database = KepliDatabase(
      persistent
          ? NativeDatabase(File(p.join(root.path, 'kepli.db')))
          : NativeDatabase.memory(),
    );
    final repository = VaultRepository(database: database, root: root);
    await repository.load();
    return VaultHarness._(base, root, database, repository);
  }

  Future<File> source(List<int> bytes, {String suffix = 'pdf'}) async {
    final file = File(p.join(base.path, '${const Uuid().v4()}.$suffix'));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<WarrantyItem> saveWithPdf(
    WarrantyItem item, {
    String originalName = 'receipt.pdf',
    List<int>? bytes,
  }) async {
    final file = await source(bytes ?? smallPdf);
    await repository.saveItem(
      item,
      additions: [
        PendingAttachment(
          sourcePath: file.path,
          originalName: originalName,
          mimeType: 'application/pdf',
        ),
      ],
    );
    return (await repository.load()).items.singleWhere(
      (entry) => entry.id == item.id,
    );
  }

  Future<void> dispose() async {
    await repository.close();
    if (await base.exists()) await base.delete(recursive: true);
  }
}

Map<String, dynamic> backupManifest({
  List<WarrantyItem> items = const [],
  AppSettings? settings,
  int schema = 1,
  String platform = 'windows',
}) => {
  'schema_version': schema,
  'exported_at': '2026-01-02T03:04:05.123456Z',
  'exported_by_platform': platform,
  'settings': (settings ?? AppSettings()).toJson(),
  'items': items.map((item) => item.toJson()).toList(),
};

class TestZipEntry {
  const TestZipEntry(
    this.name,
    this.bytes, {
    this.declaredSize,
    this.crc,
    this.localName,
    this.mode = 0x81a4,
    this.deflate = false,
    this.flags = 0,
  });

  final String name;
  final List<int> bytes;
  final int? declaredSize;
  final int? crc;
  final String? localName;
  final int mode;
  final bool deflate;
  final int flags;
}

/// Intentionally permits malformed and duplicate entries for adversarial tests.
Uint8List testZip(List<TestZipEntry> entries) {
  final output = BytesBuilder();
  final central = BytesBuilder();
  void u16(BytesBuilder to, int value) {
    to.add(
      (ByteData(2)..setUint16(0, value, Endian.little)).buffer.asUint8List(),
    );
  }

  void u32(BytesBuilder to, int value) {
    to.add(
      (ByteData(4)..setUint32(0, value, Endian.little)).buffer.asUint8List(),
    );
  }

  for (final entry in entries) {
    final name = utf8.encode(entry.name);
    final localName = utf8.encode(entry.localName ?? entry.name);
    final bytes = entry.deflate
        ? ZLibEncoder(raw: true).convert(entry.bytes)
        : entry.bytes;
    final size = entry.declaredSize ?? entry.bytes.length;
    final crc = entry.crc ?? archive.getCrc32(entry.bytes);
    final offset = output.length;
    u32(output, 0x04034b50);
    u16(output, 20);
    u16(output, entry.flags);
    u16(output, entry.deflate ? 8 : 0);
    u16(output, 0);
    u16(output, 0);
    u32(output, crc);
    u32(output, bytes.length);
    u32(output, size);
    u16(output, localName.length);
    u16(output, 0);
    output.add(localName);
    output.add(bytes);
    u32(central, 0x02014b50);
    u16(central, 0x0314);
    u16(central, 20);
    u16(central, entry.flags);
    u16(central, entry.deflate ? 8 : 0);
    u16(central, 0);
    u16(central, 0);
    u32(central, crc);
    u32(central, bytes.length);
    u32(central, size);
    u16(central, name.length);
    u16(central, 0);
    u16(central, 0);
    u16(central, 0);
    u16(central, 0);
    u32(central, entry.mode << 16);
    u32(central, offset);
    central.add(name);
  }
  final centralOffset = output.length;
  final centralSize = central.length;
  output.add(central.takeBytes());
  u32(output, 0x06054b50);
  u16(output, 0);
  u16(output, 0);
  u16(output, entries.length);
  u16(output, entries.length);
  u32(output, centralSize);
  u32(output, centralOffset);
  u16(output, 0);
  return output.takeBytes();
}

TestZipEntry manifestEntry(Map<String, dynamic> manifest) =>
    TestZipEntry('manifest.json', utf8.encode(jsonEncode(manifest)));
