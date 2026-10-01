import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/services/reminder_plan.dart';
import 'package:timezone/data/latest_all.dart' as timezone_data;
import 'package:timezone/timezone.dart' as tz;

WarrantyItem _item({
  int number = 1,
  CalendarDate? purchaseDate,
  int months = 12,
  bool claimed = false,
}) => WarrantyItem(
  id: '00000000-0000-4000-8000-${number.toString().padLeft(12, '0')}',
  name: 'Item $number',
  category: 'Other',
  purchaseDate: purchaseDate ?? CalendarDate(2026, 1, 1),
  warrantyLengthMonths: months,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
  claimed: claimed,
);

VaultSnapshot _snapshot(
  List<WarrantyItem> items, {
  List<int> days = const [30, 7, 1],
  int hour = 9,
  bool enabled = true,
}) => VaultSnapshot(
  items: items,
  settings: AppSettings(
    reminderDays: days,
    reminderHour: hour,
    remindersEnabled: enabled,
  ),
);

void main() {
  setUpAll(timezone_data.initializeTimeZones);

  test('disabled reminders produce no pending notifications', () {
    final plan = buildReminderPlan(
      snapshot: _snapshot([_item()], enabled: false),
      location: tz.UTC,
      now: DateTime.utc(2026),
    );
    expect(plan.reminders, isEmpty);
    expect(plan.totalCount, 0);
  });

  test('all configured thresholds, including zero and 3650, are honored', () {
    final item = _item(purchaseDate: CalendarDate(2036, 8, 31));
    final location = tz.getLocation('Asia/Kolkata');
    final plan = buildReminderPlan(
      snapshot: _snapshot([item], days: [0, 1, 7, 30, 3650], hour: 21),
      location: location,
      now: DateTime.utc(2020),
    );
    expect(plan.reminders.length, 5);
    expect(plan.reminders.map((value) => value.daysBeforeExpiry), [
      3650,
      30,
      7,
      1,
      0,
    ]);
    for (final reminder in plan.reminders) {
      final expectedDate = item.expiryDate.utcDate.subtract(
        Duration(days: reminder.daysBeforeExpiry),
      );
      expect(
        CalendarDate.fromDateTime(reminder.scheduledAt),
        CalendarDate.fromDateTime(expectedDate),
      );
      expect(reminder.scheduledAt.hour, 21);
      expect(reminder.scheduledAt.minute, 0);
      expect(
        reminder.scheduledAt.timeZoneOffset,
        const Duration(hours: 5, minutes: 30),
      );
    }
  });

  for (final days in [
    [-1],
    [3651],
    [7, 7],
  ]) {
    test(
      'invalid thresholds $days are rejected rather than silently changed',
      () {
        expect(
          () => buildReminderPlan(
            snapshot: _snapshot([_item()], days: days),
            location: tz.UTC,
            now: DateTime.utc(2026),
          ),
          throwsA(isA<KepliException>()),
        );
      },
    );
  }

  test('claimed and calendar-expired warranties are skipped', () {
    final valid = _item(number: 3);
    final plan = buildReminderPlan(
      snapshot: _snapshot([
        _item(number: 1, claimed: true),
        _item(number: 2, purchaseDate: CalendarDate(2024, 1, 1)),
        valid,
      ]),
      location: tz.UTC,
      now: DateTime.utc(2026),
    );
    expect(plan.reminders.length, 3);
    expect(plan.reminders.every((value) => value.itemId == valid.id), isTrue);
  });

  test(
    'a zero-day reminder is allowed on expiry day before its local hour',
    () {
      final snapshot = _snapshot(
        [_item(purchaseDate: CalendarDate(2025, 1, 1))],
        days: [0, 1],
      );
      final before = buildReminderPlan(
        snapshot: snapshot,
        location: tz.UTC,
        now: DateTime.utc(2026, 1, 1, 8, 59),
      );
      expect(before.reminders.single.daysBeforeExpiry, 0);
      final atHour = buildReminderPlan(
        snapshot: snapshot,
        location: tz.UTC,
        now: DateTime.utc(2026, 1, 1, 9),
      );
      expect(atHour.reminders, isEmpty);
    },
  );

  test(
    'expiry status uses the requested local date, not the machine UTC date',
    () {
      final plan = buildReminderPlan(
        snapshot: _snapshot(
          [_item(purchaseDate: CalendarDate(2025, 12, 31), months: 1)],
          days: [0],
          hour: 18,
        ),
        location: tz.getLocation('America/Los_Angeles'),
        now: DateTime.utc(2026, 2, 1, 0, 30),
      );
      expect(
        plan.reminders.single.scheduledAt.toUtc(),
        DateTime.utc(2026, 2, 1, 2),
      );
    },
  );

  test('the queue contains only the nearest 60, in deterministic order', () {
    final items = List.generate(80, (index) => _item(number: index + 1));
    final plan = buildReminderPlan(
      snapshot: _snapshot(items.reversed.toList()),
      location: tz.UTC,
      now: DateTime.utc(2026),
    );
    expect(plan.reminders.length, reminderQueueLimit);
    expect(plan.totalCount, 240);
    expect(plan.isTruncated, isTrue);
    expect(plan.reminders.map((value) => value.daysBeforeExpiry).toSet(), {30});
    expect(plan.reminders.first.itemId, items.first.id);
    expect(plan.reminders.last.itemId, items[59].id);
    expect(plan.reminders.map((value) => value.id).toSet().length, 60);

    final smaller = buildReminderPlan(
      snapshot: _snapshot(items, days: [1, 30, 7]),
      location: tz.UTC,
      now: DateTime.utc(2026),
      limit: 5,
    );
    expect(
      smaller.reminders.map((value) => value.id),
      plan.reminders.take(5).map((value) => value.id),
    );
  });

  test('queue size cannot exceed the native safety bound', () {
    for (final limit in [-1, reminderQueueLimit + 1]) {
      expect(
        () => buildReminderPlan(
          snapshot: _snapshot([_item()]),
          location: tz.UTC,
          now: DateTime.utc(2026),
          limit: limit,
        ),
        throwsRangeError,
      );
    }
  });

  test('stable IDs match a fixed SHA-256 golden, not Dart hashCode', () {
    expect(
      stableReminderId('12345678-1234-4234-8234-123456789012:30'),
      1527146479,
    );
  });

  test(
    'collision resolution is unique, ordered, positive and wraps safely',
    () {
      final ids = allocateReminderIds([
        'c',
        'a',
        'b',
        'a',
      ], idHash: (_) => 0x7fffffff);
      expect(ids, {'a': 0x7fffffff, 'b': 1, 'c': 2});
      expect(
        allocateReminderIds(['b', 'c', 'a'], idHash: (_) => 0x7fffffff),
        ids,
      );
      expect(allocateReminderIds(['b', 'a'], idHash: (_) => 0), {
        'a': 1,
        'b': 2,
      });
    },
  );

  test('ID assignments survive elapsed reminders and changed local hours', () {
    final item = _item();
    final initial = buildReminderPlan(
      snapshot: _snapshot([item]),
      location: tz.UTC,
      now: DateTime.utc(2026),
    );
    final later = buildReminderPlan(
      snapshot: _snapshot([item], hour: 22),
      location: tz.getLocation('Europe/Berlin'),
      now: DateTime.utc(2026, 12, 20),
    );
    final initialIds = {
      for (final value in initial.reminders) value.key: value.id,
    };
    expect(later.reminders.length, 2);
    for (final value in later.reminders) {
      expect(value.id, initialIds[value.key]);
    }
  });

  test(
    'spring DST keeps local hours while calendar days can span 23 hours',
    () {
      final plan = buildReminderPlan(
        snapshot: _snapshot(
          [_item(purchaseDate: CalendarDate(2025, 3, 9))],
          days: [0, 1, 2],
        ),
        location: tz.getLocation('America/New_York'),
        now: DateTime.utc(2026, 3, 6),
      );
      expect(plan.reminders.map((value) => value.scheduledAt.day), [7, 8, 9]);
      expect(plan.reminders.map((value) => value.scheduledAt.hour), [9, 9, 9]);
      expect(
        plan.reminders[1].scheduledAt.difference(plan.reminders[0].scheduledAt),
        const Duration(hours: 23),
      );
    },
  );

  test(
    'autumn DST keeps local hours while calendar days can span 25 hours',
    () {
      final plan = buildReminderPlan(
        snapshot: _snapshot(
          [_item(purchaseDate: CalendarDate(2025, 11, 2))],
          days: [0, 1, 2],
        ),
        location: tz.getLocation('America/New_York'),
        now: DateTime.utc(2026, 10, 30),
      );
      expect(plan.reminders.map((value) => value.scheduledAt.hour), [9, 9, 9]);
      expect(
        plan.reminders[1].scheduledAt.difference(plan.reminders[0].scheduledAt),
        const Duration(hours: 25),
      );
    },
  );

  test('a nonexistent spring hour shifts forward instead of back a day', () {
    final plan = buildReminderPlan(
      snapshot: _snapshot(
        [_item(purchaseDate: CalendarDate(2025, 3, 8))],
        days: [0],
        hour: 2,
      ),
      location: tz.getLocation('America/New_York'),
      now: DateTime.utc(2026, 3, 7),
    );
    expect(plan.reminders.single.scheduledAt.day, 8);
    expect(plan.reminders.single.scheduledAt.hour, 3);
  });

  test('a repeated autumn hour produces only one notification', () {
    final snapshot = _snapshot(
      [_item(purchaseDate: CalendarDate(2025, 11, 1))],
      days: [0],
      hour: 1,
    );
    final location = tz.getLocation('America/New_York');
    final plan = buildReminderPlan(
      snapshot: snapshot,
      location: location,
      now: DateTime.utc(2026, 10, 31),
    );
    expect(plan.reminders, hasLength(1));
    expect(plan.reminders.single.scheduledAt.hour, 1);
    final afterFirstOccurrence = buildReminderPlan(
      snapshot: snapshot,
      location: location,
      now: plan.reminders.single.scheduledAt.add(const Duration(minutes: 30)),
    );
    expect(afterFirstOccurrence.reminders, isEmpty);
  });

  test(
    'half-hour DST transitions use timezone rules, not fixed UTC offsets',
    () {
      final plan = buildReminderPlan(
        snapshot: _snapshot(
          [_item(purchaseDate: CalendarDate(2025, 10, 4))],
          days: [0],
          hour: 2,
        ),
        location: tz.getLocation('Australia/Lord_Howe'),
        now: DateTime.utc(2026, 10, 2),
      );
      expect(plan.reminders.single.scheduledAt.hour, 2);
      expect(plan.reminders.single.scheduledAt.minute, 30);
      expect(plan.reminders.single.scheduledAt.day, 4);
    },
  );

  test(
    'leap-year month-end expiry is calculated before applying thresholds',
    () {
      final plan = buildReminderPlan(
        snapshot: _snapshot(
          [_item(purchaseDate: CalendarDate(2024, 1, 31), months: 1)],
          days: [0, 1],
        ),
        location: tz.UTC,
        now: DateTime.utc(2024, 2, 1),
      );
      expect(plan.reminders.map((value) => value.scheduledAt.day), [28, 29]);
      expect(plan.reminders.first.expiryDate, CalendarDate(2024, 2, 29));
    },
  );
}
