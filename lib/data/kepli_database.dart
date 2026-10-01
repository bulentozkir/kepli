import 'package:drift/drift.dart';

part 'kepli_database.g.dart';

@DataClassName('ItemRecord')
class Items extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get purchaseDate => text()();
  IntColumn get warrantyLengthMonths => integer()();
  TextColumn get price => text().nullable()();
  TextColumn get currency => text()();
  TextColumn get vendor => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get contactsJson => text().withDefault(const Constant('[]'))();
  BoolColumn get claimed => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AttachmentRecord')
class Attachments extends Table {
  TextColumn get id => text()();
  TextColumn get itemId =>
      text().references(Items, #id, onDelete: KeyAction.cascade)();
  TextColumn get relativePath => text().unique()();
  TextColumn get originalName => text()();
  TextColumn get mimeType => text()();
  TextColumn get role => text()();
  TextColumn get contactId => text().nullable()();
  IntColumn get size => integer()();
  TextColumn get sha256 => text()();
  TextColumn get addedAt => text()();
  IntColumn get position => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MetaRecord')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(tables: [Items, Attachments, AppMeta])
class KepliDatabase extends _$KepliDatabase {
  KepliDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      throw StateError('Unsupported Kepli database version: $from.');
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA busy_timeout = 5000');
      await customStatement('PRAGMA journal_mode = WAL');
      await customStatement('PRAGMA synchronous = FULL');
    },
  );
}
