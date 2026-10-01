import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:timezone/timezone.dart' as tz;

import '../domain/models.dart';

const reminderQueueLimit = 60;
const _maximumNotificationId = 0x7fffffff;

class PlannedReminder {
  const PlannedReminder({
    required this.id,
    required this.itemId,
    required this.itemName,
    required this.expiryDate,
    required this.daysBeforeExpiry,
    required this.scheduledAt,
  });

  final int id;
  final String itemId;
  final String itemName;
  final CalendarDate expiryDate;
  final int daysBeforeExpiry;
  final tz.TZDateTime scheduledAt;

  String get key => reminderKey(itemId, daysBeforeExpiry);
}

class ReminderPlan {
  ReminderPlan({
    required List<PlannedReminder> reminders,
    required this.totalCount,
  }) : reminders = List.unmodifiable(reminders);

  final List<PlannedReminder> reminders;
  final int totalCount;

  bool get isTruncated => totalCount > reminders.length;
}

String reminderKey(String itemId, int daysBeforeExpiry) =>
    '$itemId:$daysBeforeExpiry';

int stableReminderId(String key) {
  final bytes = sha256.convert(utf8.encode('kepli:reminder:$key')).bytes;
  final id =
      ((bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3]) &
      _maximumNotificationId;
  return id == 0 ? 1 : id;
}

Map<String, int> allocateReminderIds(
  Iterable<String> keys, {
  int Function(String key) idHash = stableReminderId,
}) {
  final sortedKeys = keys.toSet().toList()..sort();
  final result = <String, int>{};
  final used = <int>{};
  // Resolve even rare 31-bit collisions deterministically, before truncating
  // the queue. Neither input order nor the queue size changes an assignment.
  for (final key in sortedKeys) {
    var id = idHash(key) & _maximumNotificationId;
    if (id == 0) id = 1;
    while (!used.add(id)) {
      id = id == _maximumNotificationId ? 1 : id + 1;
    }
    result[key] = id;
  }
  return result;
}

ReminderPlan buildReminderPlan({
  required VaultSnapshot snapshot,
  required tz.Location location,
  required DateTime now,
  int limit = reminderQueueLimit,
}) {
  if (limit < 0 || limit > reminderQueueLimit) {
    throw RangeError.range(limit, 0, reminderQueueLimit, 'limit');
  }
  snapshot.settings.validate();
  if (!snapshot.settings.remindersEnabled || limit == 0) {
    return ReminderPlan(reminders: const [], totalCount: 0);
  }

  final settings = snapshot.settings;
  final today = CalendarDate.fromDateTime(tz.TZDateTime.from(now, location));
  final itemIds = <String>{};
  final keys = <String>[];
  for (final item in snapshot.items) {
    if (!itemIds.add(item.id)) {
      throw const KepliException('Duplicate warranty IDs in reminder data.');
    }
    for (final days in settings.reminderDays) {
      keys.add(reminderKey(item.id, days));
    }
  }
  final ids = allocateReminderIds(keys);
  final reminders = <PlannedReminder>[];
  for (final item in snapshot.items) {
    if (item.statusAt(today) != ItemStatus.active) continue;
    final expiry = item.expiryDate;
    for (final days in settings.reminderDays) {
      // Subtract calendar days before constructing the local clock time:
      // subtracting a 24-hour Duration in a time zone is wrong across DST.
      final date = DateTime.utc(expiry.year, expiry.month, expiry.day - days);
      final scheduledAt = tz.TZDateTime(
        location,
        date.year,
        date.month,
        date.day,
        settings.reminderHour,
      );
      // TZDateTime moves nonexistent spring-forward hours past the gap and
      // selects one occurrence of repeated autumn hours, never two reminders.
      if (!scheduledAt.isAfter(now)) continue;
      reminders.add(
        PlannedReminder(
          id: ids[reminderKey(item.id, days)]!,
          itemId: item.id,
          itemName: item.name,
          expiryDate: expiry,
          daysBeforeExpiry: days,
          scheduledAt: scheduledAt,
        ),
      );
    }
  }
  reminders.sort((a, b) {
    final byTime = a.scheduledAt.compareTo(b.scheduledAt);
    if (byTime != 0) return byTime;
    return a.key.compareTo(b.key);
  });
  return ReminderPlan(
    reminders: reminders.take(limit).toList(),
    totalCount: reminders.length,
  );
}
