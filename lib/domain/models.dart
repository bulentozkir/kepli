import 'dart:math' as math;

class KepliException implements Exception {
  const KepliException(this.message);

  final String message;

  @override
  String toString() => message;
}

class CalendarDate implements Comparable<CalendarDate> {
  CalendarDate(this.year, this.month, this.day) {
    final value = DateTime.utc(year, month, day);
    if (year < 1900 ||
        year > 9999 ||
        value.year != year ||
        value.month != month ||
        value.day != day) {
      throw const KepliException('Enter a valid calendar date.');
    }
  }

  factory CalendarDate.fromDateTime(DateTime value) =>
      CalendarDate(value.year, value.month, value.day);

  factory CalendarDate.parse(String value) {
    final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(value);
    if (match == null) {
      throw const KepliException('Dates must use YYYY-MM-DD.');
    }
    return CalendarDate(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
  }

  final int year;
  final int month;
  final int day;

  DateTime get localDate => DateTime(year, month, day);
  DateTime get utcDate => DateTime.utc(year, month, day);

  CalendarDate addMonths(int months) {
    final first = DateTime.utc(year, month + months);
    final lastDay = DateTime.utc(first.year, first.month + 1, 0).day;
    return CalendarDate(first.year, first.month, math.min(day, lastDay));
  }

  int differenceInDays(CalendarDate other) =>
      utcDate.difference(other.utcDate).inDays;

  @override
  int compareTo(CalendarDate other) => utcDate.compareTo(other.utcDate);

  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) =>
      other is CalendarDate &&
      year == other.year &&
      month == other.month &&
      day == other.day;

  @override
  int get hashCode => Object.hash(year, month, day);
}

enum ItemStatus { active, expired, claimed }

enum AttachmentRole { receipt, warranty, product, businessCard }

enum ContactRole { sales, service }

enum RestoreMode { merge, replace }

const supportedLanguageCodes = [
  'en',
  'zh',
  'hi',
  'es',
  'fr',
  'ar',
  'bn',
  'pt',
  'ru',
  'id',
  'ur',
  'de',
  'ja',
  'mr',
  'vi',
  'te',
  'tr',
  'pa',
  'ta',
  'ko',
  'fa',
  'sw',
  'it',
  'gu',
  'th',
  'kn',
  'pl',
  'uk',
  'ml',
  'nl',
];

bool isUuid(String value) => RegExp(
  r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-'
  r'[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
).hasMatch(value);

Map<String, dynamic> jsonObject(Object? value, String label) {
  if (value is! Map<String, dynamic>) {
    throw KepliException('$label must be a JSON object.');
  }
  return value;
}

String jsonString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String) {
    throw KepliException('The backup field "$key" must be text.');
  }
  return value;
}

String? jsonOptionalString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) return null;
  return jsonString(json, key);
}

int jsonInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! int) {
    throw KepliException('The backup field "$key" must be an integer.');
  }
  return value;
}

DateTime jsonTimestamp(Map<String, dynamic> json, String key) {
  final text = jsonString(json, key);
  final match = RegExp(
    r'^(\d{4}-\d{2}-\d{2})T(\d{2}):(\d{2}):(\d{2})'
    r'(?:\.\d{1,6})?(Z|[+-](\d{2}):(\d{2}))$',
  ).firstMatch(text);
  final parsed = DateTime.tryParse(text);
  if (match == null ||
      parsed == null ||
      int.parse(match.group(2)!) > 23 ||
      int.parse(match.group(3)!) > 59 ||
      int.parse(match.group(4)!) > 59 ||
      (match.group(6) != null && int.parse(match.group(6)!) > 23) ||
      (match.group(7) != null && int.parse(match.group(7)!) > 59)) {
    throw KepliException(
      'The backup field "$key" needs a valid timestamp and time zone.',
    );
  }
  CalendarDate.parse(match.group(1)!);
  return parsed.toUtc();
}

class WarrantyAttachment {
  const WarrantyAttachment({
    required this.id,
    required this.relativePath,
    required this.originalName,
    required this.mimeType,
    required this.role,
    required this.size,
    required this.sha256,
    required this.addedAt,
    this.contactId,
  });

  factory WarrantyAttachment.fromJson(Map<String, dynamic> json) {
    final roleName = json['role'] ?? 'receipt';
    if (!AttachmentRole.values.any((role) => role.name == roleName)) {
      throw const KepliException('Unknown attachment type.');
    }
    return WarrantyAttachment(
      id: jsonString(json, 'id'),
      relativePath: jsonString(json, 'filename'),
      originalName: jsonString(json, 'original_name'),
      mimeType: jsonString(json, 'mime_type'),
      role: AttachmentRole.values.firstWhere((role) => role.name == roleName),
      size: jsonInt(json, 'size'),
      sha256: jsonString(json, 'sha256'),
      addedAt: jsonTimestamp(json, 'added_at'),
      contactId: jsonOptionalString(json, 'contact_id'),
    );
  }

  final String id;
  final String relativePath;
  final String originalName;
  final String mimeType;
  final AttachmentRole role;
  final int size;
  final String sha256;
  final DateTime addedAt;
  final String? contactId;

  bool get isImage => mimeType.startsWith('image/');
  bool get isPdf => mimeType == 'application/pdf';

  void validate(String itemId) {
    if (!isUuid(id) ||
        !RegExp(
          '^attachments/${RegExp.escape(itemId)}/'
          r'[a-fA-F0-9-]{36}\.[a-zA-Z0-9]{1,10}$',
        ).hasMatch(relativePath) ||
        originalName.trim().isEmpty ||
        originalName.length > 255 ||
        size < 0 ||
        !RegExp(r'^[a-f0-9]{64}$').hasMatch(sha256) ||
        (!isImage && !isPdf)) {
      throw const KepliException('An attachment has invalid metadata.');
    }
    if ((role == AttachmentRole.businessCard &&
            (contactId == null || !isUuid(contactId!))) ||
        (role != AttachmentRole.businessCard && contactId != null)) {
      throw const KepliException(
        'A business card must be linked to a contact.',
      );
    }
  }

  WarrantyAttachment withPath(String path) => WarrantyAttachment(
    id: id,
    relativePath: path,
    originalName: originalName,
    mimeType: mimeType,
    role: role,
    size: size,
    sha256: sha256,
    addedAt: addedAt,
    contactId: contactId,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'filename': relativePath,
    'original_name': originalName,
    'mime_type': mimeType,
    'role': role.name,
    'size': size,
    'sha256': sha256,
    'added_at': addedAt.toUtc().toIso8601String(),
    'contact_id': contactId,
  };
}

class ItemContact {
  const ItemContact({
    required this.id,
    required this.role,
    required this.name,
    this.organization,
    this.phone,
    this.email,
    this.notes,
  });

  factory ItemContact.fromJson(Map<String, dynamic> json) {
    final role = jsonString(json, 'role');
    if (!ContactRole.values.any((value) => value.name == role)) {
      throw const KepliException('Unknown contact type.');
    }
    final contact = ItemContact(
      id: jsonString(json, 'id'),
      role: ContactRole.values.firstWhere((value) => value.name == role),
      name: jsonString(json, 'name'),
      organization: jsonOptionalString(json, 'organization'),
      phone: jsonOptionalString(json, 'phone'),
      email: jsonOptionalString(json, 'email'),
      notes: jsonOptionalString(json, 'notes'),
    );
    contact.validate();
    return contact;
  }

  final String id;
  final ContactRole role;
  final String name;
  final String? organization;
  final String? phone;
  final String? email;
  final String? notes;

  void validate() {
    if (!isUuid(id) || name.trim().isEmpty || name.length > 200) {
      throw const KepliException(
        'A contact needs a name of 1 to 200 characters.',
      );
    }
    if ((organization?.length ?? 0) > 200 ||
        (phone?.length ?? 0) > 80 ||
        (email?.length ?? 0) > 254 ||
        (notes?.length ?? 0) > 2000) {
      throw const KepliException('The contact details are too long.');
    }
    if (email != null &&
        email!.isNotEmpty &&
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email!)) {
      throw const KepliException('Enter a valid contact email address.');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role.name,
    'name': name,
    'organization': organization,
    'phone': phone,
    'email': email,
    'notes': notes,
  };
}

class WarrantyItem {
  WarrantyItem({
    required this.id,
    required this.name,
    required this.category,
    required this.purchaseDate,
    required this.warrantyLengthMonths,
    required this.createdAt,
    required this.updatedAt,
    this.price,
    this.currency = 'USD',
    this.vendor,
    this.notes,
    this.claimed = false,
    List<WarrantyAttachment> attachments = const [],
    List<ItemContact> contacts = const [],
  }) : attachments = List.unmodifiable(attachments),
       contacts = List.unmodifiable(contacts);

  factory WarrantyItem.fromJson(Map<String, dynamic> json) {
    final rawAttachments = json['attachments'];
    if (rawAttachments is! List) {
      throw const KepliException('Item attachments must be a list.');
    }
    final rawContacts = json['contacts'] ?? const <Object?>[];
    if (rawContacts is! List) {
      throw const KepliException('Item contacts must be a list.');
    }
    final status = jsonString(json, 'status');
    if (!ItemStatus.values.any((value) => value.name == status)) {
      throw const KepliException('Unknown warranty status.');
    }
    final item = WarrantyItem(
      id: jsonString(json, 'id'),
      name: jsonString(json, 'name'),
      category: jsonString(json, 'category'),
      purchaseDate: CalendarDate.parse(jsonString(json, 'purchase_date')),
      warrantyLengthMonths: jsonInt(json, 'warranty_length_months'),
      price: jsonOptionalString(json, 'price'),
      currency: json['currency'] == null ? 'USD' : jsonString(json, 'currency'),
      vendor: jsonOptionalString(json, 'vendor'),
      notes: jsonOptionalString(json, 'notes'),
      claimed: status == 'claimed',
      createdAt: jsonTimestamp(json, 'created_at'),
      updatedAt: jsonTimestamp(json, 'updated_at'),
      attachments: rawAttachments
          .map(
            (entry) =>
                WarrantyAttachment.fromJson(jsonObject(entry, 'Attachment')),
          )
          .toList(),
      contacts: rawContacts
          .map((entry) => ItemContact.fromJson(jsonObject(entry, 'Contact')))
          .toList(),
    );
    item.validate();
    return item;
  }

  final String id;
  final String name;
  final String category;
  final CalendarDate purchaseDate;
  final int warrantyLengthMonths;
  final String? price;
  final String currency;
  final String? vendor;
  final String? notes;
  final bool claimed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<WarrantyAttachment> attachments;
  final List<ItemContact> contacts;

  CalendarDate get expiryDate => purchaseDate.addMonths(warrantyLengthMonths);

  ItemStatus statusAt(CalendarDate today) {
    if (claimed) return ItemStatus.claimed;
    return expiryDate.compareTo(today) < 0
        ? ItemStatus.expired
        : ItemStatus.active;
  }

  void validate() {
    if (!isUuid(id)) {
      throw const KepliException('A warranty needs a valid unique identifier.');
    }
    if (name.trim().isEmpty || name.length > 200) {
      throw const KepliException('Enter an item name of 1 to 200 characters.');
    }
    if (category.trim().isEmpty || category.length > 64) {
      throw const KepliException('Enter a category of 1 to 64 characters.');
    }
    if (warrantyLengthMonths < 1 || warrantyLengthMonths > 1200) {
      throw const KepliException('Warranty length must be 1 to 1,200 months.');
    }
    if (price != null && !RegExp(r'^\d{1,12}(\.\d{1,2})?$').hasMatch(price!)) {
      throw const KepliException(
        'Enter a positive price with up to two decimals.',
      );
    }
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(currency)) {
      throw const KepliException(
        'Currency must be a three-letter code, such as USD.',
      );
    }
    if ((vendor?.length ?? 0) > 500 || (notes?.length ?? 0) > 20000) {
      throw const KepliException('The store name or notes are too long.');
    }
    expiryDate;
    final ids = <String>{};
    final paths = <String>{};
    for (final attachment in attachments) {
      attachment.validate(id);
      if (!ids.add(attachment.id) || !paths.add(attachment.relativePath)) {
        throw const KepliException('An item contains duplicate attachments.');
      }
    }
    final contactIds = <String>{};
    for (final contact in contacts) {
      contact.validate();
      if (!contactIds.add(contact.id)) {
        throw const KepliException('An item contains duplicate contacts.');
      }
    }
    for (final attachment in attachments) {
      if (attachment.contactId != null &&
          !contactIds.contains(attachment.contactId)) {
        throw const KepliException(
          'A business card refers to a missing contact.',
        );
      }
    }
  }

  WarrantyItem copyWith({
    String? category,
    bool? claimed,
    DateTime? updatedAt,
    List<WarrantyAttachment>? attachments,
    List<ItemContact>? contacts,
  }) => WarrantyItem(
    id: id,
    name: name,
    category: category ?? this.category,
    purchaseDate: purchaseDate,
    warrantyLengthMonths: warrantyLengthMonths,
    price: price,
    currency: currency,
    vendor: vendor,
    notes: notes,
    claimed: claimed ?? this.claimed,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    attachments: attachments ?? this.attachments,
    contacts: contacts ?? this.contacts,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'purchase_date': purchaseDate.toString(),
    'warranty_length_months': warrantyLengthMonths,
    'price': price,
    'currency': currency,
    'vendor': vendor,
    'notes': notes,
    'status': claimed ? 'claimed' : 'active',
    'created_at': createdAt.toUtc().toIso8601String(),
    'updated_at': updatedAt.toUtc().toIso8601String(),
    'attachments': attachments
        .map((attachment) => attachment.toJson())
        .toList(),
    'contacts': contacts.map((contact) => contact.toJson()).toList(),
  };
}

class AppSettings {
  AppSettings({
    List<String> categories = const [
      'Electronics',
      'Appliances',
      'Tools',
      'Other',
    ],
    List<int> reminderDays = const [30, 7, 1],
    this.remindersEnabled = false,
    this.reminderHour = 9,
    this.currency = 'USD',
    this.highContrast = false,
    this.reduceMotion = false,
    this.languageCode = 'en',
  }) : categories = List.unmodifiable(categories),
       reminderDays = List.unmodifiable(reminderDays);

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'];
    final days = json['reminder_days'];
    if (categories is! List ||
        categories.any((value) => value is! String) ||
        days is! List ||
        days.any((value) => value is! int) ||
        json['reminders_enabled'] is! bool ||
        (json['high_contrast'] != null && json['high_contrast'] is! bool) ||
        (json['reduce_motion'] != null && json['reduce_motion'] is! bool)) {
      throw const KepliException('The backup contains invalid settings.');
    }
    final settings = AppSettings(
      categories: categories.cast<String>(),
      reminderDays: days.cast<int>(),
      remindersEnabled: json['reminders_enabled'] as bool,
      reminderHour: jsonInt(json, 'reminder_hour'),
      currency: jsonString(json, 'currency'),
      highContrast: json['high_contrast'] as bool? ?? false,
      reduceMotion: json['reduce_motion'] as bool? ?? false,
      languageCode: json['language_code'] == null
          ? 'en'
          : jsonString(json, 'language_code'),
    );
    settings.validate();
    return settings;
  }

  final List<String> categories;
  final List<int> reminderDays;
  final bool remindersEnabled;
  final int reminderHour;
  final String currency;
  final bool highContrast;
  final bool reduceMotion;
  final String languageCode;

  void validate() {
    if (categories.isEmpty ||
        categories.length > 200 ||
        categories.any((value) => value.trim().isEmpty || value.length > 64) ||
        categories.map((value) => value.toLowerCase().trim()).toSet().length !=
            categories.length) {
      throw const KepliException(
        'Use unique categories of 1 to 64 characters.',
      );
    }
    if (reminderDays.isEmpty ||
        reminderDays.length > 12 ||
        reminderDays.any((value) => value < 0 || value > 3650) ||
        reminderDays.toSet().length != reminderDays.length) {
      throw const KepliException(
        'Use 1 to 12 unique reminder thresholds, from 0 to 3,650 days.',
      );
    }
    if (reminderHour < 0 ||
        reminderHour > 23 ||
        !RegExp(r'^[A-Z]{3}$').hasMatch(currency)) {
      throw const KepliException('The reminder hour or currency is invalid.');
    }
    if (!supportedLanguageCodes.contains(languageCode)) {
      throw const KepliException(
        'Choose one of the supported interface languages.',
      );
    }
  }

  AppSettings copyWith({
    List<String>? categories,
    List<int>? reminderDays,
    bool? remindersEnabled,
    int? reminderHour,
    String? currency,
    bool? highContrast,
    bool? reduceMotion,
    String? languageCode,
  }) => AppSettings(
    categories: categories ?? this.categories,
    reminderDays: reminderDays ?? this.reminderDays,
    remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    reminderHour: reminderHour ?? this.reminderHour,
    currency: currency ?? this.currency,
    highContrast: highContrast ?? this.highContrast,
    reduceMotion: reduceMotion ?? this.reduceMotion,
    languageCode: languageCode ?? this.languageCode,
  );

  Map<String, dynamic> toJson() => {
    'categories': categories,
    'reminder_days': reminderDays,
    'reminders_enabled': remindersEnabled,
    'reminder_hour': reminderHour,
    'currency': currency,
    'high_contrast': highContrast,
    'reduce_motion': reduceMotion,
    'language_code': languageCode,
  };
}

class VaultSnapshot {
  VaultSnapshot({required List<WarrantyItem> items, required this.settings})
    : items = List.unmodifiable(items);

  final List<WarrantyItem> items;
  final AppSettings settings;

  void validate() {
    settings.validate();
    final ids = <String>{};
    final attachmentIds = <String>{};
    for (final item in items) {
      item.validate();
      if (!ids.add(item.id)) {
        throw const KepliException('The backup contains duplicate item IDs.');
      }
      if (!settings.categories.contains(item.category)) {
        throw const KepliException('An item refers to a missing category.');
      }
      for (final attachment in item.attachments) {
        if (!attachmentIds.add(attachment.id)) {
          throw const KepliException(
            'The backup contains duplicate attachment IDs.',
          );
        }
      }
    }
  }
}

class PendingAttachment {
  const PendingAttachment({
    required this.sourcePath,
    required this.originalName,
    required this.mimeType,
    this.role = AttachmentRole.receipt,
    this.contactId,
  });

  final String sourcePath;
  final String originalName;
  final String mimeType;
  final AttachmentRole role;
  final String? contactId;
}
