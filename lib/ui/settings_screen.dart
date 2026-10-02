import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/vault_controller.dart';
import '../domain/models.dart';
import '../domain/number_input.dart';
import '../l10n/language_catalog.dart';
import 'ui_support.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _days;
  late final TextEditingController _hour;
  late final TextEditingController _currency;
  late List<String> _categories;
  late bool _enabled;
  late bool _highContrast;
  late bool _reduceMotion;
  late String _language;
  bool _dirty = false;
  bool _working = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(vaultProvider).snapshot.settings;
    _categories = [...settings.categories];
    _days = TextEditingController(text: settings.reminderDays.join(', '));
    _hour = TextEditingController(text: '${settings.reminderHour}');
    _currency = TextEditingController(text: settings.currency);
    _enabled = settings.remindersEnabled;
    _highContrast = settings.highContrast;
    _reduceMotion = settings.reduceMotion;
    _language = settings.languageCode;
  }

  @override
  void dispose() {
    _days.dispose();
    _hour.dispose();
    _currency.dispose();
    super.dispose();
  }

  Future<bool> confirmLeave() async {
    if (_working || ref.read(vaultProvider).busy) return false;
    if (!_dirty) return true;
    return confirmAction(
      context,
      title: context.l10n.discardChanges,
      message: context.l10n.discardChanges,
      confirmLabel: context.l10n.discard,
      cancelLabel: context.l10n.keepEditing,
    );
  }

  List<int>? _parseDays(String text) => parseReminderDays(text);

  Future<void> _save() async {
    if (_working ||
        ref.read(vaultProvider).busy ||
        !_form.currentState!.validate()) {
      return;
    }
    setState(() {
      _working = true;
      _error = null;
    });
    try {
      await ref
          .read(vaultProvider.notifier)
          .saveSettings(
            AppSettings(
              categories: List.of(_categories),
              reminderDays: _parseDays(_days.text)!,
              remindersEnabled: _enabled,
              reminderHour: parseWholeNumber(_hour.text)!,
              currency: _currency.text.trim().toUpperCase(),
              highContrast: _highContrast,
              reduceMotion: _reduceMotion,
              languageCode: _language,
            ),
          );
      if (mounted) setState(() => _dirty = false);
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
        await showOperationError(context, error);
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _permission() async {
    setState(() => _working = true);
    await runUiAction(context, () async {
      await ref.read(dependenciesProvider).reminders.requestPermission();
      await ref.read(vaultProvider.notifier).refresh();
    });
    if (mounted) setState(() => _working = false);
  }

  bool _inUse(String category) => ref
      .read(vaultProvider)
      .snapshot
      .items
      .any((item) => item.category == category);

  Future<void> _categoryInUse() async {
    await restoreFocusAfter(
      () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          scrollable: true,
          content: Text(context.l10n.categoryInUse),
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

  Future<void> _editCategory([String? current]) async {
    final name = await restoreFocusAfter(
      () => showDialog<String>(
        context: context,
        builder: (context) =>
            _CategoryDialog(current: current, categories: _categories),
      ),
    );
    if (name == null || !mounted) return;
    final persisted =
        current != null &&
        ref.read(vaultProvider).snapshot.settings.categories.contains(current);
    if (persisted) {
      setState(() => _working = true);
      try {
        await ref.read(vaultProvider.notifier).renameCategory(current, name);
      } catch (error) {
        if (mounted) await showOperationError(context, error);
        return;
      } finally {
        if (mounted) setState(() => _working = false);
      }
      if (!mounted) return;
    }
    setState(() {
      if (current == null) {
        _categories.add(name);
      } else {
        _categories[_categories.indexOf(current)] = name;
      }
      if (!persisted) _dirty = true;
    });
  }

  Future<void> _deleteCategory(String category) async {
    if (_inUse(category)) {
      await _categoryInUse();
      return;
    }
    if (_categories.length <= 1) return;
    if (!await confirmAction(
      context,
      title: context.l10n.deleteCategory,
      message: categoryLabel(context, category),
      confirmLabel: context.l10n.delete,
    )) {
      return;
    }
    if (mounted) {
      setState(() {
        _categories.remove(category);
        _dirty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaultProvider);
    final status = state.reminderStatus;
    final busy = _working || state.busy;
    final l10n = context.l10n;
    final reminderLabel = !_enabled
        ? l10n.remindersOff
        : !status.supported
        ? l10n.remindersUnavailable
        : !status.authorized
        ? l10n.permissionRequired
        : l10n.remindersScheduled(status.scheduledCount);
    return PageBody(
      child: Form(
        key: _form,
        onChanged: () => _dirty = true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeading(l10n.settings),
            if (busy) const BusyIndicator(),
            if (_error != null) ErrorPanel(error: _error!),
            SectionHeading(l10n.language),
            Text(l10n.languageHelp),
            const SizedBox(height: 12),
            ChoiceField<String>(
              key: const Key('settings-language'),
              label: l10n.language,
              value: _language,
              choices: [
                for (final entry in languageNames.entries)
                  Choice(entry.key, entry.value),
              ],
              onChanged: busy
                  ? null
                  : (value) => setState(() {
                      _language = value;
                      _dirty = true;
                    }),
            ),
            SectionHeading(l10n.accessibility),
            SwitchListTile(
              key: const Key('settings-high-contrast'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.highContrast),
              value: _highContrast,
              onChanged: busy
                  ? null
                  : (value) => setState(() {
                      _highContrast = value;
                      _dirty = true;
                    }),
            ),
            SwitchListTile(
              key: const Key('settings-reduce-motion'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.reduceMotion),
              value: _reduceMotion,
              onChanged: busy
                  ? null
                  : (value) => setState(() {
                      _reduceMotion = value;
                      _dirty = true;
                    }),
            ),
            Text(l10n.accessibilityHelp),
            SectionHeading(l10n.notifications),
            SwitchListTile(
              key: const Key('settings-reminders'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.enableReminders),
              value: _enabled,
              onChanged: busy
                  ? null
                  : (value) => setState(() {
                      _enabled = value;
                      _dirty = true;
                    }),
            ),
            Semantics(liveRegion: true, child: Text(reminderLabel)),
            if (status.message != null) ErrorDetails(error: status.message!),
            const SizedBox(height: 12),
            if (_enabled && status.supported && !status.authorized)
              ActionButton(
                label: l10n.requestPermission,
                icon: Icons.notifications_active_outlined,
                onPressed: busy ? null : _permission,
              ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('settings-reminder-days'),
              controller: _days,
              enabled: !busy,
              decoration: InputDecoration(
                labelText: l10n.reminderDays,
                helperText: l10n.reminderDaysHelp,
                helperMaxLines: 8,
                errorMaxLines: 8,
              ),
              validator: (value) =>
                  _parseDays(value!) == null ? l10n.invalidReminderDays : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('settings-reminder-hour'),
              controller: _hour,
              enabled: !busy,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.reminderHour,
                errorMaxLines: 8,
              ),
              validator: (value) {
                final hour = parseWholeNumber(value!);
                return hour == null || hour < 0 || hour > 23
                    ? l10n.invalidReminderHour
                    : null;
              },
            ),
            const SizedBox(height: 16),
            Text(l10n.notificationPrivacy),
            const SizedBox(height: 12),
            Text(l10n.reminderLimit),
            if (Platform.isLinux) ...[
              const SizedBox(height: 12),
              Text(l10n.linuxReminderHelp),
            ],
            SectionHeading(l10n.currency),
            TextFormField(
              key: const Key('settings-currency'),
              controller: _currency,
              enabled: !busy,
              maxLength: 3,
              textCapitalization: TextCapitalization.characters,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: l10n.currency,
                errorMaxLines: 5,
              ),
              validator: (value) =>
                  RegExp(r'^[A-Z]{3}$').hasMatch(value!.trim().toUpperCase())
                  ? null
                  : l10n.invalidCurrency,
            ),
            SectionHeading(l10n.categories),
            for (final category in _categories)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        categoryLabel(context, category),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ActionButton(
                            label: l10n.renameCategory,
                            icon: Icons.edit_outlined,
                            onPressed: busy
                                ? null
                                : () => _editCategory(category),
                          ),
                          ActionButton(
                            label: l10n.deleteCategory,
                            icon: Icons.delete_outline,
                            onPressed: busy || _categories.length == 1
                                ? null
                                : () => _deleteCategory(category),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ActionButton(
              key: const Key('settings-add-category'),
              label: l10n.addCategory,
              icon: Icons.add,
              onPressed: busy || _categories.length >= 200
                  ? null
                  : _editCategory,
            ),
            const SizedBox(height: 24),
            ActionButton(
              key: const Key('settings-save'),
              label: l10n.save,
              icon: Icons.save_outlined,
              primary: true,
              onPressed: busy ? null : _save,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog({required this.categories, this.current});
  final List<String> categories;
  final String? current;

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.current);
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    scrollable: true,
    title: Text(
      widget.current == null
          ? context.l10n.addCategory
          : context.l10n.renameCategory,
    ),
    content: Form(
      key: _form,
      child: TextFormField(
        key: const Key('category-name'),
        controller: _name,
        maxLength: 64,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: context.l10n.newCategory,
          errorMaxLines: 8,
        ),
        validator: (value) {
          final name = value!.trim();
          if (name.isEmpty) return context.l10n.fieldRequired;
          if (widget.categories.any(
            (entry) =>
                entry != widget.current &&
                entry.toLowerCase() == name.toLowerCase(),
          )) {
            return context.l10n.categoryExists;
          }
          return null;
        },
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(context.l10n.cancel),
      ),
      TextButton(
        onPressed: () {
          if (_form.currentState!.validate()) {
            Navigator.pop(context, _name.text.trim());
          }
        },
        child: Text(context.l10n.save),
      ),
    ],
  );
}
