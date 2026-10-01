import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../application/vault_controller.dart';
import '../domain/models.dart';
import '../services/backup_service.dart';
import 'ui_support.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  late final VaultController _controller;
  BackupPreview? _preview;
  RestoreMode _mode = RestoreMode.merge;
  final _keepLocalIds = <String>{};
  bool _working = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _controller = ref.read(vaultProvider.notifier);
  }

  @override
  void dispose() {
    final preview = _preview;
    if (preview != null) {
      unawaited(
        _controller.discardPreview(preview).catchError((Object error) {}),
      );
    }
    super.dispose();
  }

  Future<void> _chooseBackup() async {
    if (_working || ref.read(vaultProvider).busy) return;
    setState(() {
      _working = true;
      _error = null;
    });
    try {
      final oldPreview = _preview;
      if (oldPreview != null) {
        await _controller.discardPreview(oldPreview);
        if (mounted) setState(() => _preview = null);
      }
      final preview = await _controller.inspectBackup();
      if (!mounted) {
        if (preview != null) await _controller.discardPreview(preview);
        return;
      }
      setState(() {
        _preview = preview;
        _mode = RestoreMode.merge;
        _keepLocalIds.clear();
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _cancelPreview() async {
    final preview = _preview;
    if (preview == null || _working) return;
    setState(() => _working = true);
    try {
      await _controller.discardPreview(preview);
      if (mounted) {
        setState(() {
          _preview = null;
          _keepLocalIds.clear();
        });
      }
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _restore() async {
    final preview = _preview;
    if (preview == null || _working || ref.read(vaultProvider).busy) return;
    if (_mode == RestoreMode.replace) {
      if (!await confirmAction(
        context,
        title: context.l10n.replaceAll,
        message: context.l10n.replaceConfirmation(
          ref.read(vaultProvider).snapshot.items.length,
        ),
        confirmLabel: context.l10n.confirmReplace,
      )) {
        return;
      }
      if (!mounted) return;
    }
    setState(() {
      _working = true;
      _error = null;
    });
    try {
      await _controller.restore(
        preview,
        _mode,
        keepLocalIds: _mode == RestoreMode.merge ? Set.of(_keepLocalIds) : {},
      );
      if (mounted) {
        setState(() {
          _preview = null;
          _keepLocalIds.clear();
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
        await showOperationError(context, error);
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaultProvider);
    final busy = state.busy || _working;
    final l10n = context.l10n;
    final preview = _preview;
    return PageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(l10n.backups),
          Text(l10n.backupExplanation),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ExcludeSemantics(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Icon(Icons.privacy_tip_outlined),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.backupPrivacy),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Builder(
            builder: (anchor) => ActionButton(
              key: const Key('export-backup'),
              label: l10n.exportBackup,
              icon: Icons.archive_outlined,
              primary: true,
              onPressed: busy
                  ? null
                  : () {
                      final origin = shareOriginFor(anchor);
                      runUiAction(
                        context,
                        () => _controller.exportBackup(shareOrigin: origin),
                      );
                    },
            ),
          ),
          SectionHeading(l10n.restoreBackup),
          ActionButton(
            key: const Key('choose-backup'),
            label: l10n.chooseBackup,
            icon: Icons.folder_open_outlined,
            onPressed: busy ? null : _chooseBackup,
          ),
          if (busy) const BusyIndicator(),
          if (_error != null)
            ErrorPanel(error: _error!, onRetry: busy ? null : _chooseBackup),
          if (preview != null) ...[
            SectionHeading(l10n.backupPreview),
            Text(
              l10n.backupSummary(
                preview.snapshot.items.length,
                preview.snapshot.items.fold(
                  0,
                  (sum, item) => sum + item.attachments.length,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.exportedOn(
                DateFormat.yMMMd(
                  l10n.localeName,
                ).add_jm().format(preview.exportedAt.toLocal()),
                preview.platform,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.newWarranties}: ${numberLabel(context, preview.newItemCount)}',
            ),
            const SizedBox(height: 16),
            ChoiceField<RestoreMode>(
              key: const Key('restore-mode'),
              label: l10n.restoreBackup,
              value: _mode,
              choices: [
                Choice(RestoreMode.merge, l10n.merge),
                Choice(RestoreMode.replace, l10n.replaceAll),
              ],
              onChanged: busy ? null : (mode) => setState(() => _mode = mode),
            ),
            const SizedBox(height: 12),
            Text(
              _mode == RestoreMode.merge ? l10n.mergeHelp : l10n.replaceHelp,
            ),
            if (_mode == RestoreMode.merge && preview.conflicts.isNotEmpty) ...[
              SectionHeading(l10n.conflicts),
              Text(l10n.newerWinsHelp),
              const SizedBox(height: 12),
              for (final conflict in preview.conflicts)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          conflict.local.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (conflict.local.name != conflict.incoming.name)
                          Text(conflict.incoming.name),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.keepLocal),
                          value:
                              !conflict.incomingIsNewer ||
                              _keepLocalIds.contains(conflict.local.id),
                          onChanged: busy || !conflict.incomingIsNewer
                              ? null
                              : (value) => setState(() {
                                  if (value!) {
                                    _keepLocalIds.add(conflict.local.id);
                                  } else {
                                    _keepLocalIds.remove(conflict.local.id);
                                  }
                                }),
                        ),
                        Text(
                          conflict.incomingIsNewer &&
                                  !_keepLocalIds.contains(conflict.local.id)
                              ? l10n.useBackup
                              : l10n.keepLocal,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionButton(
                  key: const Key('restore-backup'),
                  label: l10n.restore,
                  icon: Icons.restore,
                  primary: true,
                  onPressed: busy ? null : _restore,
                ),
                ActionButton(
                  key: const Key('cancel-backup-preview'),
                  label: l10n.cancel,
                  icon: Icons.close,
                  onPressed: busy ? null : _cancelPreview,
                ),
              ],
            ),
          ],
          SectionHeading(l10n.exportReports),
          Text(l10n.documentFooter),
          const SizedBox(height: 12),
          Builder(
            builder: (anchor) => ActionButton(
              label: l10n.exportCsv,
              icon: Icons.table_view_outlined,
              onPressed: busy
                  ? null
                  : () {
                      final origin = shareOriginFor(anchor);
                      runUiAction(
                        context,
                        () => _controller.exportCsv(shareOrigin: origin),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
}
