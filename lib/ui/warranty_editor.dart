import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../application/vault_controller.dart';
import '../domain/models.dart';
import 'contact_editor.dart';
import 'scan_document_screen.dart';
import 'ui_support.dart';

class WarrantyEditor extends ConsumerStatefulWidget {
  const WarrantyEditor({
    super.key,
    this.item,
    this.recoveredPhotos = const [],
    this.initialContacts = const [],
  });

  final WarrantyItem? item;
  final List<PendingAttachment> recoveredPhotos;
  final List<ItemContact> initialContacts;

  @override
  ConsumerState<WarrantyEditor> createState() => _WarrantyEditorState();
}

class _WarrantyEditorState extends ConsumerState<WarrantyEditor> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _duration;
  late final TextEditingController _price;
  late final TextEditingController _currency;
  late final TextEditingController _vendor;
  late final TextEditingController _notes;
  late final String _id;
  late final DateTime _createdAt;
  late CalendarDate _purchaseDate;
  late String _category;
  late List<WarrantyAttachment> _attachments;
  late List<PendingAttachment> _additions;
  late List<ItemContact> _contacts;
  AttachmentRole _attachmentRole = AttachmentRole.receipt;
  bool _years = false;
  bool _claimed = false;
  bool _dirty = false;
  bool _working = false;
  bool _leaving = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    final settings = ref.read(vaultProvider).snapshot.settings;
    _id = item?.id ?? const Uuid().v4();
    _createdAt = item?.createdAt ?? DateTime.now().toUtc();
    _name = TextEditingController(text: item?.name);
    _duration = TextEditingController(
      text: '${item?.warrantyLengthMonths ?? 12}',
    );
    _price = TextEditingController(text: item?.price);
    _currency = TextEditingController(
      text: item?.currency ?? settings.currency,
    );
    _vendor = TextEditingController(text: item?.vendor);
    _notes = TextEditingController(text: item?.notes);
    _purchaseDate =
        item?.purchaseDate ?? CalendarDate.fromDateTime(DateTime.now());
    _category = item?.category ?? settings.categories.first;
    _attachments = [...?item?.attachments];
    _contacts = [...?item?.contacts, ...widget.initialContacts];
    _additions = [...widget.recoveredPhotos];
    _dirty = _additions.isNotEmpty;
    _claimed = item?.claimed ?? false;
  }

  @override
  void dispose() {
    for (final field in [
      _name,
      _duration,
      _price,
      _currency,
      _vendor,
      _notes,
    ]) {
      field.dispose();
    }
    super.dispose();
  }

  int? get _months {
    final amount = int.tryParse(normalizedDigits(_duration.text.trim()));
    if (amount == null) return null;
    final months = amount * (_years ? 12 : 1);
    return months >= 1 && months <= 1200 ? months : null;
  }

  CalendarDate? get _expiry {
    final months = _months;
    if (months == null) return null;
    try {
      return _purchaseDate.addMonths(months);
    } on KepliException {
      return null;
    }
  }

  Future<void> _leave() async {
    if (_working || ref.read(vaultProvider).busy) return;
    if (_dirty &&
        !await confirmAction(
          context,
          title: context.l10n.discardChanges,
          message: context.l10n.discardChanges,
          confirmLabel: context.l10n.discard,
          cancelLabel: context.l10n.keepEditing,
        )) {
      return;
    }
    if (mounted) _finish(false);
  }

  void _finish(bool saved) {
    setState(() => _leaving = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.pop(context, saved);
    });
  }

  Future<void> _chooseDate() async {
    final date = await restoreFocusAfter(
      () => showDatePicker(
        context: context,
        initialDate: _purchaseDate.localDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(9999, 12, 31),
        helpText: context.l10n.chooseDate,
      ),
    );
    if (date != null && mounted) {
      setState(() {
        _purchaseDate = CalendarDate.fromDateTime(date);
        _dirty = true;
      });
    }
  }

  Future<void> _save() async {
    if (_working || ref.read(vaultProvider).busy) return;
    if (!_form.currentState!.validate()) return;
    setState(() {
      _working = true;
      _error = null;
    });
    try {
      final item = WarrantyItem(
        id: _id,
        name: _name.text.trim(),
        category: _category,
        purchaseDate: _purchaseDate,
        warrantyLengthMonths: _months!,
        price: optionalText(normalizedPrice(context, _price.text)),
        currency: _currency.text.trim().toUpperCase(),
        vendor: optionalText(_vendor.text),
        notes: optionalText(_notes.text),
        claimed: _claimed,
        createdAt: _createdAt,
        updatedAt: DateTime.now().toUtc(),
        attachments: _attachments,
        contacts: _contacts,
      );
      await ref
          .read(vaultProvider.notifier)
          .saveItem(item, additions: List.of(_additions));
      if (widget.recoveredPhotos.isNotEmpty) {
        ref.read(vaultProvider.notifier).clearRecoveredPhotos();
      }
      if (mounted) _finish(true);
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
        await showOperationError(context, error);
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _addAttachment({
    required AttachmentRole role,
    String? contactId,
    bool camera = false,
    bool photoLibrary = false,
    bool scan = false,
  }) async {
    if (_working || ref.read(vaultProvider).busy) return;
    setState(() => _working = true);
    try {
      final files = ref.read(dependenciesProvider).files;
      final List<PendingAttachment> selected;
      if (scan) {
        final result = await restoreFocusAfter(
          () => Navigator.of(context).push<PendingAttachment>(
            MaterialPageRoute(
              builder: (context) => ScanDocumentScreen(
                role: role == AttachmentRole.product
                    ? AttachmentRole.receipt
                    : role,
                contactId: contactId,
              ),
            ),
          ),
        );
        selected = result == null ? [] : [result];
      } else if (camera) {
        final result = await files.takePhoto(role: role, contactId: contactId);
        selected = result == null ? [] : [result];
      } else if (photoLibrary) {
        selected = await files.pickPhotos(role: role, contactId: contactId);
      } else {
        selected = await files.pickAttachments(
          role: role,
          contactId: contactId,
        );
      }
      for (final attachment in selected) {
        if (!mounted) return;
        if (!await confirmLargeFile(context, attachment.sourcePath)) continue;
        if (!mounted) return;
        setState(() {
          _additions.add(attachment);
          _dirty = true;
        });
      }
    } catch (error) {
      if (mounted) await showOperationError(context, error);
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _editContact([ItemContact? contact]) async {
    final updated = await editContact(context, contact: contact);
    if (updated == null || !mounted) return;
    setState(() {
      final index = _contacts.indexWhere((entry) => entry.id == updated.id);
      if (index == -1) {
        _contacts.add(updated);
      } else {
        _contacts[index] = updated;
      }
      _dirty = true;
    });
  }

  Future<void> _removeContact(ItemContact contact) async {
    if (!await confirmAction(
      context,
      title: context.l10n.removeContact,
      message: contact.name,
      confirmLabel: context.l10n.removeContact,
    )) {
      return;
    }
    if (!mounted) return;
    setState(() {
      _contacts.removeWhere((entry) => entry.id == contact.id);
      _attachments.removeWhere((entry) => entry.contactId == contact.id);
      _additions.removeWhere((entry) => entry.contactId == contact.id);
      _dirty = true;
    });
  }

  Iterable<Widget> _fileCards(String? contactId, bool busy) sync* {
    final notifier = ref.read(vaultProvider.notifier);
    for (final attachment in _attachments.where(
      (entry) => entry.contactId == contactId,
    )) {
      yield AttachmentCard(
        key: ValueKey(attachment.id),
        name: attachment.originalName,
        role: attachment.role,
        isImage: attachment.isImage,
        file: notifier.attachmentFile(attachment),
        onOpen: busy
            ? null
            : () => runUiAction(
                context,
                () => notifier.openAttachment(attachment),
              ),
        onRemove: busy
            ? null
            : () => setState(() {
                _attachments.remove(attachment);
                _dirty = true;
              }),
      );
    }
    for (final addition in _additions.where(
      (entry) => entry.contactId == contactId,
    )) {
      yield AttachmentCard(
        key: ObjectKey(addition),
        name: addition.originalName,
        role: addition.role,
        isImage: addition.mimeType.startsWith('image/'),
        file: File(addition.sourcePath),
        onOpen: busy
            ? null
            : () => runUiAction(
                context,
                () => ref
                    .read(dependenciesProvider)
                    .files
                    .openAttachment(File(addition.sourcePath)),
              ),
        onRemove: busy
            ? null
            : () => setState(() {
                _additions.remove(addition);
                _dirty = true;
              }),
      );
    }
  }

  Widget _attachmentActions({
    required bool busy,
    required AttachmentRole role,
    String? contactId,
  }) {
    final l10n = context.l10n;
    final files = ref.read(dependenciesProvider).files;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ActionButton(
          label: contactId == null ? l10n.addFiles : l10n.addBusinessCard,
          icon: Icons.attach_file,
          onPressed: busy
              ? null
              : () => _addAttachment(role: role, contactId: contactId),
        ),
        if (files.cameraAvailable)
          ActionButton(
            label: l10n.takePhoto,
            icon: Icons.add_a_photo_outlined,
            onPressed: busy
                ? null
                : () => _addAttachment(
                    role: role,
                    contactId: contactId,
                    camera: true,
                  ),
          ),
        if (files.cameraAvailable)
          ActionButton(
            label: l10n.choosePhoto,
            icon: Icons.photo_library_outlined,
            onPressed: busy
                ? null
                : () => _addAttachment(
                    role: role,
                    contactId: contactId,
                    photoLibrary: true,
                  ),
          ),
        if (role != AttachmentRole.product)
          ActionButton(
            label: contactId == null
                ? l10n.scanDocument
                : l10n.scanBusinessCard,
            icon: Icons.document_scanner_outlined,
            onPressed: busy
                ? null
                : () => _addAttachment(
                    role: role,
                    contactId: contactId,
                    scan: true,
                  ),
          ),
      ],
    );
  }

  Widget _contactCard(ItemContact contact, bool busy) {
    final l10n = context.l10n;
    return Card(
      key: ValueKey(contact.id),
      margin: const EdgeInsetsDirectional.only(bottom: 16),
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
            if (contact.organization != null) Text(contact.organization!),
            if (contact.phone != null)
              LabeledValue(label: l10n.phone, value: contact.phone!),
            if (contact.email != null)
              LabeledValue(label: l10n.email, value: contact.email!),
            if (contact.notes != null)
              LabeledValue(label: l10n.contactNotes, value: contact.notes!),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ActionButton(
                  label: l10n.editContact,
                  icon: Icons.edit_outlined,
                  onPressed: busy ? null : () => _editContact(contact),
                ),
                ActionButton(
                  label: l10n.removeContact,
                  icon: Icons.person_remove_outlined,
                  onPressed: busy ? null : () => _removeContact(contact),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(l10n.businessCardHelp),
            const SizedBox(height: 12),
            ..._fileCards(contact.id, busy),
            _attachmentActions(
              busy: busy,
              role: AttachmentRole.businessCard,
              contactId: contact.id,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(vaultProvider);
    final busy = state.busy || _working;
    final categories = {...state.snapshot.settings.categories, _category};
    final expiry = _expiry;
    return PopScope<bool>(
      canPop: _leaving,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _leave();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AccessibleIconButton(
            label: l10n.cancel,
            icon: Icons.close,
            onPressed: busy ? null : _leave,
          ),
          title: Text(
            widget.item == null ? l10n.addWarranty : l10n.editWarranty,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: PageBody(
            child: Form(
              key: _form,
              onChanged: () => _dirty = true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.requiredFields),
                  if (busy) const BusyIndicator(),
                  if (_error != null) ErrorPanel(error: _error!),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('warranty-name'),
                    controller: _name,
                    enabled: !busy,
                    autofocus: widget.item == null,
                    maxLength: 200,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.name,
                      hintText: l10n.nameHint,
                    ),
                    validator: (value) =>
                        value!.trim().isEmpty ? l10n.fieldRequired : null,
                  ),
                  ChoiceField<String>(
                    key: const Key('warranty-category'),
                    label: l10n.category,
                    value: _category,
                    choices: [
                      for (final category in categories)
                        Choice(category, categoryLabel(context, category)),
                    ],
                    onChanged: busy
                        ? null
                        : (value) => setState(() {
                            _category = value;
                            _dirty = true;
                          }),
                  ),
                  const SizedBox(height: 16),
                  ActionButton(
                    key: const Key('purchase-date'),
                    label:
                        '${l10n.purchaseDate}: ${dateLabel(context, _purchaseDate)}',
                    icon: Icons.calendar_today_outlined,
                    onPressed: busy ? null : _chooseDate,
                  ),
                  SectionHeading(l10n.warrantyLength),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final months in [6, 12, 24, 36, 60])
                        ActionButton(
                          label: months < 12
                              ? '${numberLabel(context, months)} ${l10n.months}'
                              : '${numberLabel(context, months ~/ 12)} ${l10n.years}',
                          icon: Icons.date_range_outlined,
                          onPressed: busy
                              ? null
                              : () => setState(() {
                                  _years = false;
                                  _duration.text = '$months';
                                  _dirty = true;
                                }),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('warranty-duration'),
                    controller: _duration,
                    enabled: !busy,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n.warrantyLength),
                    validator: (value) => _months == null || _expiry == null
                        ? l10n.invalidDuration
                        : null,
                    onChanged: (value) => setState(() => _dirty = true),
                  ),
                  const SizedBox(height: 12),
                  ChoiceField<bool>(
                    label: l10n.warrantyLength,
                    value: _years,
                    choices: [
                      Choice(false, l10n.months),
                      Choice(true, l10n.years),
                    ],
                    onChanged: busy
                        ? null
                        : (value) => setState(() {
                            final months = _months;
                            _years = value;
                            if (months != null &&
                                (!value || months % 12 == 0)) {
                              _duration.text =
                                  '${value ? months ~/ 12 : months}';
                            }
                            _dirty = true;
                          }),
                  ),
                  const SizedBox(height: 12),
                  Semantics(
                    liveRegion: true,
                    child: LabeledValue(
                      label: l10n.expiryDate,
                      value: expiry == null
                          ? l10n.notSet
                          : dateLabel(context, expiry),
                    ),
                  ),
                  TextFormField(
                    key: const Key('warranty-price'),
                    controller: _price,
                    enabled: !busy,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.price),
                    validator: (value) {
                      final price = normalizedPrice(context, value!);
                      return price.isEmpty ||
                              RegExp(r'^\d{1,12}(\.\d{1,2})?$').hasMatch(price)
                          ? null
                          : l10n.invalidPrice;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('warranty-currency'),
                    controller: _currency,
                    enabled: !busy,
                    maxLength: 3,
                    textCapitalization: TextCapitalization.characters,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: l10n.currency),
                    validator: (value) =>
                        RegExp(r'^[A-Z]{3}$')
                            .hasMatch(value!.trim().toUpperCase())
                        ? null
                        : l10n.invalidCurrency,
                  ),
                  TextFormField(
                    key: const Key('warranty-vendor'),
                    controller: _vendor,
                    enabled: !busy,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: l10n.vendor),
                  ),
                  TextFormField(
                    key: const Key('warranty-notes'),
                    controller: _notes,
                    enabled: !busy,
                    minLines: 3,
                    maxLines: 8,
                    maxLength: 20000,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(labelText: l10n.notes),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.claimed),
                    value: _claimed,
                    onChanged: busy
                        ? null
                        : (value) => setState(() {
                            _claimed = value;
                            _dirty = true;
                          }),
                  ),
                  SectionHeading(l10n.attachments),
                  ChoiceField<AttachmentRole>(
                    label: l10n.attachmentType,
                    value: _attachmentRole,
                    choices: [
                      for (final role in [
                        AttachmentRole.receipt,
                        AttachmentRole.warranty,
                        AttachmentRole.product,
                      ])
                        Choice(role, attachmentRoleLabel(context, role)),
                    ],
                    onChanged: busy
                        ? null
                        : (value) => setState(() => _attachmentRole = value),
                  ),
                  const SizedBox(height: 12),
                  ..._fileCards(null, busy),
                  _attachmentActions(busy: busy, role: _attachmentRole),
                  SectionHeading(l10n.contacts),
                  if (_contacts.isEmpty)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 12),
                      child: Text(l10n.noContacts),
                    ),
                  for (final contact in _contacts) _contactCard(contact, busy),
                  ActionButton(
                    key: const Key('add-contact'),
                    label: l10n.addContact,
                    icon: Icons.person_add_alt_1_outlined,
                    onPressed: busy ? null : () => _editContact(),
                  ),
                  const SizedBox(height: 32),
                  ActionButton(
                    key: const Key('warranty-save'),
                    label: l10n.save,
                    icon: Icons.save_outlined,
                    primary: true,
                    onPressed: busy ? null : _save,
                  ),
                  const SizedBox(height: 8),
                  ActionButton(
                    label: l10n.cancel,
                    icon: Icons.close,
                    onPressed: busy ? null : _leave,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
