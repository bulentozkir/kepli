import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/vault_repository.dart';
import '../domain/models.dart';
import '../services/backup_service.dart';
import '../services/document_scanner.dart';
import '../services/platform_files.dart';
import '../services/reminder_service.dart';
import '../services/report_service.dart';

class AppDependencies {
  const AppDependencies({
    required this.repository,
    required this.backups,
    required this.reports,
    required this.files,
    required this.reminders,
    required this.scanner,
    required this.initialSnapshot,
    required this.initialReminderStatus,
    this.recoveredPhotos = const [],
    this.startupNotice,
  });

  final VaultRepository repository;
  final BackupService backups;
  final ReportService reports;
  final PlatformFiles files;
  final ReminderGateway reminders;
  final DocumentScanner scanner;
  final VaultSnapshot initialSnapshot;
  final ReminderStatus initialReminderStatus;
  final List<PendingAttachment> recoveredPhotos;
  final String? startupNotice;
}

final dependenciesProvider = Provider<AppDependencies>(
  (ref) => throw StateError('Kepli has not been initialized.'),
);

final vaultProvider = NotifierProvider<VaultController, VaultState>(
  VaultController.new,
);

class VaultState {
  const VaultState({
    required this.snapshot,
    required this.reminderStatus,
    this.busy = false,
    this.notice,
    this.selectedItemId,
    this.recoveredPhotos = const [],
  });

  final VaultSnapshot snapshot;
  final ReminderStatus reminderStatus;
  final bool busy;
  final String? notice;
  final String? selectedItemId;
  final List<PendingAttachment> recoveredPhotos;

  VaultState copyWith({
    VaultSnapshot? snapshot,
    ReminderStatus? reminderStatus,
    bool? busy,
    String? notice,
    bool clearNotice = false,
    String? selectedItemId,
    bool clearSelection = false,
    List<PendingAttachment>? recoveredPhotos,
  }) => VaultState(
    snapshot: snapshot ?? this.snapshot,
    reminderStatus: reminderStatus ?? this.reminderStatus,
    busy: busy ?? this.busy,
    notice: clearNotice ? null : notice ?? this.notice,
    selectedItemId: clearSelection
        ? null
        : selectedItemId ?? this.selectedItemId,
    recoveredPhotos: recoveredPhotos ?? this.recoveredPhotos,
  );
}

class VaultController extends Notifier<VaultState> {
  AppDependencies get _dependencies => ref.read(dependenciesProvider);

  @override
  VaultState build() {
    final dependencies = ref.watch(dependenciesProvider);
    return VaultState(
      snapshot: dependencies.initialSnapshot,
      reminderStatus: dependencies.initialReminderStatus,
      recoveredPhotos: dependencies.recoveredPhotos,
      notice: dependencies.startupNotice,
    );
  }

  void selectItem(String? id) {
    state = state.copyWith(selectedItemId: id, clearSelection: id == null);
  }

  void dismissNotice() => state = state.copyWith(clearNotice: true);

  void clearRecoveredPhotos() =>
      state = state.copyWith(recoveredPhotos: const []);

  Future<T> _perform<T>(Future<T> Function() operation) async {
    if (state.busy) {
      throw const KepliException('Please wait for the current operation to finish.');
    }
    state = state.copyWith(busy: true, clearNotice: true);
    try {
      return await operation();
    } finally {
      state = state.copyWith(busy: false);
    }
  }

  Future<void> _reload({String? notice}) async {
    final snapshot = await _dependencies.repository.load();
    state = state.copyWith(snapshot: snapshot, notice: notice);
    final status = await _dependencies.reminders.reconcile(snapshot);
    state = state.copyWith(reminderStatus: status);
  }

  Future<void> refresh() async {
    if (state.busy) return;
    await _perform(() => _reload());
  }

  Future<void> saveItem(
    WarrantyItem item, {
    List<PendingAttachment> additions = const [],
  }) => _perform(() async {
    await _dependencies.repository.saveItem(item, additions: additions);
    await _reload(notice: 'Warranty saved on this device.');
    selectItem(item.id);
  });

  Future<void> deleteItem(String id) => _perform(() async {
    await _dependencies.repository.deleteItem(id);
    if (state.selectedItemId == id) selectItem(null);
    await _reload(notice: 'Warranty and its attachments deleted.');
  });

  Future<void> setClaimed(WarrantyItem item, bool claimed) => saveItem(
    item.copyWith(claimed: claimed, updatedAt: DateTime.now().toUtc()),
  );

  Future<void> saveSettings(AppSettings settings) => _perform(() async {
    settings.validate();
    if (settings.remindersEnabled &&
        !state.snapshot.settings.remindersEnabled) {
      final status = await _dependencies.reminders.requestPermission();
      state = state.copyWith(reminderStatus: status);
    }
    await _dependencies.repository.saveSettings(settings);
    await _reload(notice: 'Settings saved.');
  });

  Future<BackupPreview?> inspectBackup() => _perform(() async {
    final path = await _dependencies.files.pickBackup();
    if (path == null) return null;
    return _dependencies.backups.inspectBackup(path);
  });

  Future<void> restore(
    BackupPreview preview,
    RestoreMode mode, {
    Set<String> keepLocalIds = const {},
  }) => _perform(() async {
    await _dependencies.backups.restore(
      preview,
      mode,
      keepLocalIds: keepLocalIds,
    );
    selectItem(null);
    await _reload(notice: 'Backup restored. All referenced attachments verified.');
  });

  Future<void> discardPreview(BackupPreview preview) =>
      _dependencies.backups.discardPreview(preview);

  Future<void> _export(
    Future<File> Function() generate,
    Rect? shareOrigin,
  ) => _perform(() async {
    final file = await generate();
    final notice = await _dependencies.files.saveOrShare(
      file,
      shareOrigin: shareOrigin,
    );
    if (notice != null) state = state.copyWith(notice: notice);
  });

  Future<void> exportBackup({Rect? shareOrigin}) =>
      _export(_dependencies.backups.exportBackup, shareOrigin);

  Future<void> exportCsv({Rect? shareOrigin}) => _export(
    () => _dependencies.reports.exportCsv(state.snapshot),
    shareOrigin,
  );

  Future<void> exportPdf(WarrantyItem item, {Rect? shareOrigin}) =>
      _export(() => _dependencies.reports.exportItemPdf(item), shareOrigin);

  File attachmentFile(WarrantyAttachment attachment) =>
      _dependencies.repository.attachmentFile(attachment);

  Future<void> openAttachment(WarrantyAttachment attachment) =>
      _dependencies.files.openAttachment(attachmentFile(attachment));
}
