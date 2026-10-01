import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/models.dart';
import '../l10n/app_localizations.dart';

extension LocalizedContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String categoryLabel(BuildContext context, String category) =>
    switch (category) {
      'Electronics' => context.l10n.categoryElectronics,
      'Appliances' => context.l10n.categoryAppliances,
      'Tools' => context.l10n.categoryTools,
      'Other' => context.l10n.categoryOther,
      _ => category,
    };

String attachmentRoleLabel(BuildContext context, AttachmentRole role) =>
    switch (role) {
      AttachmentRole.receipt => context.l10n.receipt,
      AttachmentRole.warranty => context.l10n.warrantyPaper,
      AttachmentRole.product => context.l10n.productPhoto,
      AttachmentRole.businessCard => context.l10n.businessCard,
    };

String contactRoleLabel(BuildContext context, ContactRole role) =>
    switch (role) {
      ContactRole.sales => context.l10n.salesContact,
      ContactRole.service => context.l10n.serviceContact,
    };

String dateLabel(BuildContext context, CalendarDate date) =>
    DateFormat.yMMMd(context.l10n.localeName).format(date.localDate);

String numberLabel(BuildContext context, num value) =>
    NumberFormat.decimalPattern(context.l10n.localeName).format(value);

String? optionalText(String value) =>
    value.trim().isEmpty ? null : value.trim();

String normalizedDigits(String value) {
  const zeroes = [
    0x0660,
    0x06f0,
    0x0966,
    0x09e6,
    0x0a66,
    0x0ae6,
    0x0b66,
    0x0be6,
    0x0c66,
    0x0ce6,
    0x0d66,
    0x0e50,
  ];
  return String.fromCharCodes(
    value.runes.map((rune) {
      for (final zero in zeroes) {
        if (rune >= zero && rune < zero + 10) return 0x30 + rune - zero;
      }
      return rune;
    }),
  );
}

String normalizedPrice(BuildContext context, String value) {
  final decimal = NumberFormat.decimalPattern(context.l10n.localeName)
      .symbols
      .DECIMAL_SEP;
  return normalizedDigits(value.trim()).replaceAll(decimal, '.');
}

String? noticeLabel(BuildContext context, String notice) {
  final l10n = context.l10n;
  final text = switch (notice) {
    'Warranty saved on this device.' => l10n.saved,
    'Warranty and its attachments deleted.' => l10n.deleted,
    'Settings saved.' => l10n.settingsSaved,
    'Backup restored. All referenced attachments verified.' => l10n.restored,
    'Export ready.' => l10n.exportReady,
    'Export cancelled.' => l10n.exportCancelled,
    'Choose where to save or send the file in the share sheet.' =>
      l10n.shareOpened,
    'Export handed to the selected app. Finish saving or sharing there.' =>
      l10n.shareOpened,
    _ => null,
  };
  if (text != null) return text;
  for (final prefix in ['File saved to ', 'Saved to ']) {
    if (notice.startsWith(prefix)) {
      return l10n.fileSavedTo(notice.substring(prefix.length));
    }
  }
  return null;
}

class NoticePanel extends StatelessWidget {
  const NoticePanel({super.key, required this.notice, required this.onDismiss});
  final String notice;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final label = noticeLabel(context, notice);
    return Semantics(
      liveRegion: true,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(label ?? context.l10n.operationFailed),
              if (label == null) ErrorDetails(error: notice),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: onDismiss,
                  child: Text(context.l10n.dismiss),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Rect shareOriginFor(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final object = context.findRenderObject();
  if (object is RenderBox && object.hasSize && !object.size.isEmpty) {
    final origin = (object.localToGlobal(Offset.zero) & object.size).intersect(
      Offset.zero & size,
    );
    if (!origin.isEmpty) return origin;
  }
  return Rect.fromLTWH(size.width / 2, size.height / 2, 1, 1);
}

Future<T?> restoreFocusAfter<T>(Future<T?> Function() action) async {
  final focus = FocusManager.instance.primaryFocus;
  try {
    return await action();
  } finally {
    if (focus?.context != null && focus!.canRequestFocus) focus.requestFocus();
  }
}

Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  String? cancelLabel,
}) async =>
    await restoreFocusAfter(
      () => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              autofocus: true,
              onPressed: () => Navigator.pop(context, false),
              child: Text(cancelLabel ?? context.l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ),
    ) ??
    false;

Future<void> showOperationError(BuildContext context, Object error) async {
  await restoreFocusAfter(
    () => showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(context.l10n.operationFailed),
        content: ErrorDetails(error: error),
        actions: [
          TextButton(
            autofocus: true,
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.close),
          ),
        ],
      ),
    ),
  );
}

Future<void> runUiAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
  } catch (error) {
    if (context.mounted) await showOperationError(context, error);
  }
}

Future<bool> confirmLargeFile(BuildContext context, String path) async {
  final size = await File(path).length();
  if (size <= 10 * 1024 * 1024) return true;
  if (!context.mounted) return false;
  return confirmAction(
    context,
    title: context.l10n.largeAttachmentTitle,
    message: context.l10n.largeAttachmentWarning(
      NumberFormat.decimalPatternDigits(
        locale: context.l10n.localeName,
        decimalDigits: 1,
      ).format(size / (1024 * 1024)),
    ),
    confirmLabel: context.l10n.continueAction,
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.primary = false,
    this.autofocus = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool primary;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final child = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        ExcludeSemantics(child: Icon(icon, size: 20)),
        Text(label, textAlign: TextAlign.center),
      ],
    );
    final style = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
      padding: const WidgetStatePropertyAll(
        EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
      ),
    );
    return primary
        ? FilledButton(
            style: style,
            autofocus: autofocus,
            onPressed: onPressed,
            child: child,
          )
        : OutlinedButton(
            style: style,
            autofocus: autofocus,
            onPressed: onPressed,
            child: child,
          );
  }
}

class AccessibleIconButton extends StatelessWidget {
  const AccessibleIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
    onPressed: onPressed,
    icon: Icon(icon),
  );
}

class Choice<T> {
  const Choice(this.value, this.label);
  final T value;
  final String label;
}

class ChoiceField<T> extends StatelessWidget {
  const ChoiceField({
    super.key,
    required this.label,
    required this.value,
    required this.choices,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<Choice<T>> choices;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = choices
        .where((choice) => choice.value == value)
        .firstOrNull;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 64),
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onChanged == null
          ? null
          : () async {
              final result = await restoreFocusAfter(
                () => showDialog<T>(
                  context: context,
                  builder: (context) => AlertDialog(
                    scrollable: true,
                    title: Text(label),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final choice in choices)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: 8,
                            ),
                            child: Semantics(
                              selected: choice.value == value,
                              child: ActionButton(
                                label: choice.label,
                                icon: choice.value == value
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                onPressed: () =>
                                    Navigator.pop(context, choice.value),
                              ),
                            ),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(context.l10n.cancel),
                      ),
                    ],
                  ),
                ),
              );
              if (result != null) onChanged!(result);
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(selected?.label ?? context.l10n.notSet),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 24, bottom: 12),
    child: Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    ),
  );
}

class LabeledValue extends StatelessWidget {
  const LabeledValue({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4),
        SelectableText(value),
      ],
    ),
  );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final ItemStatus status;

  @override
  Widget build(BuildContext context) {
    final (icon, label) = switch (status) {
      ItemStatus.active => (Icons.verified_outlined, context.l10n.active),
      ItemStatus.expired => (Icons.event_busy_outlined, context.l10n.expired),
      ItemStatus.claimed => (Icons.task_alt, context.l10n.claimed),
    };
    final colors = Theme.of(context).colorScheme;
    return Semantics(
      label: label,
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            border: Border.all(color: colors.outline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            child: Wrap(
              spacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(icon, size: 20, color: colors.onSurface),
                Text(label, style: TextStyle(color: colors.onSurface)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorDetails extends StatelessWidget {
  const ErrorDetails({super.key, required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: ExpansionTile(
      tilePadding: EdgeInsets.zero,
      expandedAlignment: AlignmentDirectional.centerStart,
      title: Text(context.l10n.technicalDetails),
      children: [SelectableText(error.toString()), const SizedBox(height: 12)],
    ),
  );
}

class ErrorPanel extends StatelessWidget {
  const ErrorPanel({super.key, required this.error, this.onRetry});
  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            liveRegion: true,
            child: Text(
              context.l10n.operationFailed,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ErrorDetails(error: error),
          if (onRetry != null)
            ActionButton(
              label: context.l10n.retry,
              icon: Icons.refresh,
              onPressed: onRetry,
            ),
        ],
      ),
    ),
  );
}

class BusyIndicator extends StatelessWidget {
  const BusyIndicator({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    label: label ?? context.l10n.busy,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          LinearProgressIndicator(semanticsLabel: context.l10n.loading),
          const SizedBox(height: 8),
          Text(label ?? context.l10n.busy),
        ],
      ),
    ),
  );
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.file,
    required this.label,
    this.height = 160,
  });
  final File file;
  final String label;
  final double height;

  @override
  Widget build(BuildContext context) => Image.file(
    file,
    height: height,
    width: double.infinity,
    fit: BoxFit.contain,
    semanticLabel: label,
    cacheWidth: 1200,
    errorBuilder: (context, error, stackTrace) => Semantics(
      image: true,
      label: context.l10n.unavailableImage,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(context.l10n.unavailableImage),
      ),
    ),
  );
}

class AttachmentCard extends StatelessWidget {
  const AttachmentCard({
    super.key,
    required this.name,
    required this.role,
    required this.isImage,
    required this.file,
    required this.onOpen,
    this.onRemove,
  });
  final String name;
  final AttachmentRole role;
  final bool isImage;
  final File file;
  final VoidCallback? onOpen;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsetsDirectional.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isImage) ImagePreview(file: file, label: name),
          Text(name),
          Text(
            attachmentRoleLabel(context, role),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionButton(
                label: context.l10n.openAttachment,
                icon: Icons.open_in_new,
                onPressed: onOpen,
              ),
              if (onRemove != null)
                ActionButton(
                  label: context.l10n.removeAttachment,
                  icon: Icons.remove_circle_outline,
                  onPressed: onRemove,
                ),
            ],
          ),
        ],
      ),
    ),
  );
}

class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.child,
    this.maxWidth = 840,
    this.controller,
  });
  final Widget child;
  final double maxWidth;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: controller,
    child: SingleChildScrollView(
      controller: controller,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
      child: Align(
        alignment: AlignmentDirectional.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    ),
  );
}
