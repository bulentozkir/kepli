import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../domain/models.dart';
import 'ui_support.dart';

Future<ItemContact?> editContact(
  BuildContext context, {
  ItemContact? contact,
}) => restoreFocusAfter(
  () => showDialog<ItemContact>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _ContactEditor(contact: contact),
  ),
);

class _ContactEditor extends StatefulWidget {
  const _ContactEditor({this.contact});
  final ItemContact? contact;

  @override
  State<_ContactEditor> createState() => _ContactEditorState();
}

class _ContactEditorState extends State<_ContactEditor> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _organization;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _notes;
  late ContactRole _role;
  bool _dirty = false;
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    final contact = widget.contact;
    _name = TextEditingController(text: contact?.name);
    _organization = TextEditingController(text: contact?.organization);
    _phone = TextEditingController(text: contact?.phone);
    _email = TextEditingController(text: contact?.email);
    _notes = TextEditingController(text: contact?.notes);
    _role = contact?.role ?? ContactRole.sales;
  }

  @override
  void dispose() {
    for (final field in [_name, _organization, _phone, _email, _notes]) {
      field.dispose();
    }
    super.dispose();
  }

  void _finish(ItemContact? contact) {
    setState(() => _leaving = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.pop(context, contact);
    });
  }

  Future<void> _cancel() async {
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
    if (mounted) _finish(null);
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    _finish(
      ItemContact(
        id: widget.contact?.id ?? const Uuid().v4(),
        role: _role,
        name: _name.text.trim(),
        organization: optionalText(_organization.text),
        phone: optionalText(_phone.text),
        email: optionalText(_email.text),
        notes: optionalText(_notes.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopScope<ItemContact>(
      canPop: _leaving,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _cancel();
      },
      child: AlertDialog(
        scrollable: true,
        title: Text(
          widget.contact == null ? l10n.addContact : l10n.editContact,
        ),
        content: SizedBox(
          width: 560,
          child: Form(
            key: _form,
            onChanged: () => _dirty = true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.businessCardHelp),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('contact-name'),
                  controller: _name,
                  autofocus: true,
                  maxLength: 200,
                  decoration: InputDecoration(labelText: l10n.contactName),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) =>
                      value!.trim().isEmpty ? l10n.fieldRequired : null,
                ),
                ChoiceField<ContactRole>(
                  label: l10n.contacts,
                  value: _role,
                  choices: [
                    for (final role in ContactRole.values)
                      Choice(role, contactRoleLabel(context, role)),
                  ],
                  onChanged: (value) => setState(() {
                    _role = value;
                    _dirty = true;
                  }),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _organization,
                  maxLength: 200,
                  decoration: InputDecoration(labelText: l10n.organization),
                  textCapitalization: TextCapitalization.words,
                ),
                TextFormField(
                  key: const Key('contact-phone'),
                  controller: _phone,
                  maxLength: 80,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: l10n.phone),
                ),
                TextFormField(
                  key: const Key('contact-email'),
                  controller: _email,
                  maxLength: 254,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: l10n.email),
                  validator: (value) {
                    final email = value!.trim();
                    return email.isNotEmpty &&
                            !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                                .hasMatch(email)
                        ? l10n.invalidEmail
                        : null;
                  },
                ),
                TextFormField(
                  controller: _notes,
                  maxLength: 2000,
                  minLines: 2,
                  maxLines: 6,
                  decoration: InputDecoration(labelText: l10n.contactNotes),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: _cancel, child: Text(l10n.cancel)),
          TextButton(
            key: const Key('contact-save'),
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
