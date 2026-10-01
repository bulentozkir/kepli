import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/application/vault_controller.dart';
import 'package:kepli/data/kepli_database.dart';
import 'package:kepli/data/vault_repository.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/backup_service.dart';
import 'package:kepli/services/document_scanner.dart';
import 'package:kepli/services/platform_files.dart';
import 'package:kepli/services/reminder_service.dart';
import 'package:kepli/services/report_service.dart';

import '../data/test_support.dart';

class _Reminders implements ReminderGateway {
  static const status = ReminderStatus(authorized: true, supported: true);

  @override
  Future<ReminderStatus> initialize() async => status;

  @override
  Future<ReminderStatus> requestPermission() async => status;

  @override
  Future<ReminderStatus> reconcile(VaultSnapshot snapshot) async => status;

  @override
  Future<void> dispose() async {}
}

class _CleanupWarningRepository extends VaultRepository {
  _CleanupWarningRepository({required super.database, required super.root});

  @override
  Future<void> saveItem(
    WarrantyItem item, {
    List<PendingAttachment> additions = const [],
  }) async {
    await super.saveItem(item, additions: additions);
    throw const VaultCleanupException(
      'Saved, but unused file cleanup needs retrying.',
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'committed cleanup warnings refresh visible data instead of claiming failure',
    () async {
      final harness = await VaultHarness.create();
      await harness.repository.close();
      final repository = _CleanupWarningRepository(
        database: KepliDatabase(NativeDatabase.memory()),
        root: harness.root,
      );
      final snapshot = await repository.load();
      final dependencies = AppDependencies(
        repository: repository,
        backups: BackupService(
          repository: repository,
          temporaryDirectory: harness.work,
        ),
        reports: ReportService(
          repository: repository,
          temporaryDirectory: harness.work,
        ),
        files: PlatformFiles(temporaryDirectory: harness.work),
        scanner: DocumentScanner(temporaryDirectory: harness.work),
        reminders: _Reminders(),
        initialSnapshot: snapshot,
        initialReminderStatus: _Reminders.status,
      );
      final container = ProviderContainer(
        overrides: [dependenciesProvider.overrideWithValue(dependencies)],
      );
      try {
        await container.read(vaultProvider.notifier).saveItem(sampleItem());
        final state = container.read(vaultProvider);
        expect(state.snapshot.items.single.name, 'Cordless drill');
        expect(state.busy, isFalse);
        expect(state.notice, contains('cleanup'));
      } finally {
        container.dispose();
        await repository.close();
        await harness.dispose();
      }
    },
  );
}
