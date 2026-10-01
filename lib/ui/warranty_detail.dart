import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../application/vault_controller.dart';
import '../domain/models.dart';
import 'ui_support.dart';
import 'warranty_editor.dart';

class WarrantyDetailScreen extends StatelessWidget {
  const WarrantyDetailScreen({super.key, required this.itemId});
  final String itemId;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        context.l10n.readOnlyDetails,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    body: SafeArea(
      child: WarrantyDetailPane(
        itemId: itemId,
        onDeleted: () => Navigator.of(context).pop(),
      ),
    ),
  );
}

class WarrantyDetailPane extends ConsumerStatefulWidget {
  const WarrantyDetailPane({super.key, required this.itemId, this.onDeleted});
  final String itemId;
  final VoidCallback? onDeleted;

  @override
  ConsumerState<WarrantyDetailPane> createState() => _WarrantyDetailPaneState();
}

class _WarrantyDetailPaneState extends ConsumerState<WarrantyDetailPane> {
  bool _exporting = false;
  String? _exportNotice;
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(WarrantyDetailPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.itemId != widget.itemId) {
      _exportNotice = null;
      if (_scrollController.hasClients) _scrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _delete(WarrantyItem item) async {
    if (!await confirmAction(
      context,
      title: context.l10n.deleteWarranty,
      message: context.l10n.deleteWarrantyWarning(item.name),
      confirmLabel: context.l10n.delete,
    )) {
      return;
    }
    if (!mounted) return;
    await runUiAction(context, () async {
      await ref.read(vaultProvider.notifier).deleteItem(item.id);
      if (mounted) widget.onDeleted?.call();
    });
  }

  Future<void> _exportCsv(WarrantyItem item, Rect origin) async {
    setState(() => _exporting = true);
    await runUiAction(context, () async {
      final dependencies = ref.read(dependenciesProvider);
      final snapshot = VaultSnapshot(
        items: [item],
        settings: ref.read(vaultProvider).snapshot.settings,
      );
      final file = await dependencies.reports.exportCsv(snapshot);
      final notice = await dependencies.files.saveOrShare(
        file,
        shareOrigin: origin,
      );
      if (mounted) {
        setState(() => _exportNotice = notice ?? 'Export cancelled.');
      }
    });
    if (mounted) setState(() => _exporting = false);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaultProvider);
    final item = state.snapshot.items
        .where((item) => item.id == widget.itemId)
        .firstOrNull;
    final l10n = context.l10n;
    if (item == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(l10n.selectWarranty),
        ),
      );
    }
    final busy = state.busy || _exporting;
    final controller = ref.read(vaultProvider.notifier);
    final today = CalendarDate.fromDateTime(DateTime.now());
    return PageBody(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (busy) const BusyIndicator(),
          if (_exportNotice != null)
            NoticePanel(
              notice: _exportNotice!,
              onDismiss: () => setState(() => _exportNotice = null),
            ),
          Semantics(
            header: true,
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              StatusBadge(status: item.statusAt(today)),
              Text(categoryLabel(context, item.category)),
              if (item.statusAt(today) == ItemStatus.active)
                Text(l10n.daysLeft(item.expiryDate.differenceInDays(today))),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionButton(
                key: const Key('edit-warranty'),
                label: l10n.edit,
                icon: Icons.edit_outlined,
                onPressed: busy
                    ? null
                    : () => restoreFocusAfter(
                        () => Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (context) => WarrantyEditor(item: item),
                          ),
                        ),
                      ),
              ),
              ActionButton(
                label: item.claimed ? l10n.markActive : l10n.markClaimed,
                icon: item.claimed ? Icons.undo : Icons.task_alt,
                onPressed: busy
                    ? null
                    : () => runUiAction(
                        context,
                        () => controller.setClaimed(item, !item.claimed),
                      ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          LabeledValue(
            label: l10n.purchaseDate,
            value: dateLabel(context, item.purchaseDate),
          ),
          LabeledValue(
            label: l10n.warrantyLength,
            value:
                '${numberLabel(context, item.warrantyLengthMonths)} ${l10n.months}',
          ),
          LabeledValue(
            label: l10n.expiryDate,
            value: dateLabel(context, item.expiryDate),
          ),
          LabeledValue(
            label: l10n.price,
            value: item.price == null
                ? l10n.notSet
                : NumberFormat.currency(
                    locale: l10n.localeName,
                    name: item.currency,
                    symbol: item.currency,
                    decimalDigits: 2,
                  ).format(num.parse(item.price!)),
          ),
          LabeledValue(label: l10n.vendor, value: item.vendor ?? l10n.notSet),
          LabeledValue(label: l10n.notes, value: item.notes ?? l10n.notSet),
          SectionHeading(l10n.contacts),
          if (item.contacts.isEmpty) Text(l10n.noContacts),
          for (final contact in item.contacts)
            Card(
              margin: const EdgeInsetsDirectional.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        contact.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(contactRoleLabel(context, contact.role)),
                    const SizedBox(height: 12),
                    if (contact.organization != null)
                      LabeledValue(
                        label: l10n.organization,
                        value: contact.organization!,
                      ),
                    if (contact.phone != null)
                      LabeledValue(label: l10n.phone, value: contact.phone!),
                    if (contact.email != null)
                      LabeledValue(label: l10n.email, value: contact.email!),
                    if (contact.notes != null)
                      LabeledValue(
                        label: l10n.contactNotes,
                        value: contact.notes!,
                      ),
                    for (final attachment in item.attachments.where(
                      (entry) => entry.contactId == contact.id,
                    ))
                      _attachment(attachment, busy),
                  ],
                ),
              ),
            ),
          SectionHeading(l10n.attachments),
          if (item.attachments
              .where((entry) => entry.contactId == null)
              .isEmpty)
            Text(l10n.notSet),
          for (final attachment in item.attachments.where(
            (entry) => entry.contactId == null,
          ))
            _attachment(attachment, busy),
          SectionHeading(l10n.exportReports),
          Text(l10n.pdfReferences),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Builder(
                builder: (anchor) => ActionButton(
                  label: l10n.exportPdf,
                  icon: Icons.picture_as_pdf_outlined,
                  onPressed: busy
                      ? null
                      : () {
                          final origin = shareOriginFor(anchor);
                          runUiAction(
                            context,
                            () =>
                                controller.exportPdf(item, shareOrigin: origin),
                          );
                        },
                ),
              ),
              Builder(
                builder: (anchor) => ActionButton(
                  label: l10n.exportCsv,
                  icon: Icons.table_view_outlined,
                  onPressed: busy
                      ? null
                      : () => _exportCsv(item, shareOriginFor(anchor)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          ActionButton(
            key: const Key('delete-warranty'),
            label: l10n.delete,
            icon: Icons.delete_outline,
            onPressed: busy ? null : () => _delete(item),
          ),
        ],
      ),
    );
  }

  Widget _attachment(WarrantyAttachment attachment, bool busy) {
    final controller = ref.read(vaultProvider.notifier);
    return AttachmentCard(
      name: attachment.originalName,
      role: attachment.role,
      isImage: attachment.isImage,
      file: controller.attachmentFile(attachment),
      onOpen: busy
          ? null
          : () => runUiAction(
              context,
              () => controller.openAttachment(attachment),
            ),
    );
  }
}
