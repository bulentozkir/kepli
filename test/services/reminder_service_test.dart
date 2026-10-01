import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/l10n/app_localizations.dart';
import 'package:kepli/services/reminder_service.dart';

const _notifications = MethodChannel(
  'dexterous.com/flutter/local_notifications',
);
const _timezone = MethodChannel('flutter_timezone');

VaultSnapshot _snapshot({
  int items = 1,
  bool enabled = true,
  bool claimed = false,
  String language = 'en',
}) => VaultSnapshot(
  items: [
    for (var i = 1; i <= items; i++)
      WarrantyItem(
        id: '00000000-0000-4000-8000-${i.toString().padLeft(12, '0')}',
        name: 'Warranty $i',
        category: 'Other',
        purchaseDate: CalendarDate(DateTime.now().year + 1, 1, 1),
        warrantyLengthMonths: 12,
        createdAt: DateTime.utc(2026),
        updatedAt: DateTime.utc(2026),
        claimed: claimed,
      ),
  ],
  settings: AppSettings(remindersEnabled: enabled, languageCode: language),
);

class _LinuxNotifications extends FlutterLocalNotificationsPlatform
    implements LinuxFlutterLocalNotificationsPlugin {
  bool available = true;
  bool initialized = false;

  @override
  Future<bool?> initialize({
    required LinuxInitializationSettings settings,
    DidReceiveNotificationResponseCallback? onDidReceiveNotificationResponse,
  }) async {
    initialized = true;
    return true;
  }

  @override
  Future<LinuxServerCapabilities> getCapabilities() async {
    if (!available) throw StateError('No desktop notification daemon.');
    return const LinuxServerCapabilities(
      otherCapabilities: {},
      body: true,
      bodyHyperlinks: false,
      bodyImages: false,
      bodyMarkup: false,
      iconMulti: false,
      iconStatic: false,
      persistence: false,
      sound: false,
      actions: false,
      actionIcons: false,
    );
  }

  @override
  Future<Map<int, int>> getSystemIdMap() async => {};

  @override
  Future<void> show({
    required int id,
    String? title,
    String? body,
    LinuxNotificationDetails? notificationDetails,
    String? payload,
  }) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  late ReminderService service;
  late List<MethodCall> calls;
  late Map<int, Map<String, Object?>> pending;
  late bool authorized;
  late bool cancelWorks;
  late int failScheduleAt;
  var scheduleAttempts = 0;
  String zone = 'Europe/Berlin';
  Map<String, Object?>? launch;

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    FlutterLocalNotificationsPlatform.instance =
        AndroidFlutterLocalNotificationsPlugin();
    calls = [];
    pending = {};
    authorized = true;
    cancelWorks = true;
    failScheduleAt = -1;
    scheduleAttempts = 0;
    zone = 'Europe/Berlin';
    launch = null;
    messenger.setMockMethodCallHandler(_timezone, (_) async => zone);
    messenger.setMockMethodCallHandler(_notifications, (call) async {
      calls.add(call);
      switch (call.method) {
        case 'initialize':
          return defaultTargetPlatform != TargetPlatform.iOS;
        case 'areNotificationsEnabled':
          return authorized;
        case 'checkPermissions':
          return {
            'isEnabled': authorized,
            'isAlertEnabled': authorized,
            'isSoundEnabled': authorized,
            'isBadgeEnabled': false,
            'isProvisionalEnabled': false,
          };
        case 'requestNotificationsPermission':
        case 'requestPermissions':
          authorized = true;
          return true;
        case 'getNotificationAppLaunchDetails':
          return launch ?? {'notificationLaunchedApp': false};
        case 'cancelAllPendingNotifications':
          if (cancelWorks) pending.clear();
          return null;
        case 'pendingNotificationRequests':
          return pending.values.toList();
        case 'zonedSchedule':
          scheduleAttempts++;
          if (scheduleAttempts == failScheduleAt) {
            throw PlatformException(
              code: 'schedule_failed',
              message: 'Operating system rejected this reminder.',
            );
          }
          final args = Map<String, Object?>.from(call.arguments as Map);
          pending[args['id']! as int] = {
            'id': args['id'],
            'title': args['title'],
            'body': args['body'],
            'payload': args['payload'],
          };
          return null;
        default:
          throw StateError('Unexpected notification method: ${call.method}');
      }
    });
    service = ReminderService();
  });

  tearDown(() async {
    await service.dispose();
    messenger.setMockMethodCallHandler(_notifications, null);
    messenger.setMockMethodCallHandler(_timezone, null);
    debugDefaultTargetPlatformOverride = null;
  });

  test(
    'startup checks Android authorization without requesting permissions',
    () async {
      authorized = false;
      final status = await service.initialize();
      expect(status.supported, isTrue);
      expect(status.authorized, isFalse);
      expect(
        calls.map((call) => call.method),
        isNot(contains('requestNotificationsPermission')),
      );
      expect(
        calls.map((call) => call.method),
        isNot(contains('requestExactAlarmsPermission')),
      );
    },
  );

  test(
    'Darwin initialization returning false is not treated as failure',
    () async {
      await service.dispose();
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      FlutterLocalNotificationsPlatform.instance =
          IOSFlutterLocalNotificationsPlugin();
      service = ReminderService();
      authorized = false;
      final status = await service.initialize();
      expect(status.supported, isTrue);
      expect(status.authorized, isFalse);
      expect(status.message, isNot(contains('could not initialize')));
      final arguments =
          calls.firstWhere((call) => call.method == 'initialize').arguments
              as Map;
      expect(arguments['requestAlertPermission'], isFalse);
      expect(arguments['requestSoundPermission'], isFalse);
      expect(arguments['requestBadgePermission'], isFalse);
      expect(
        calls.map((call) => call.method),
        isNot(contains('requestPermissions')),
      );
    },
  );

  test(
    'authorization is requested only by explicit settings permission action',
    () async {
      authorized = false;
      await service.initialize();
      expect((await service.reconcile(_snapshot())).scheduledCount, 0);
      expect(
        calls.any((call) => call.method == 'requestNotificationsPermission'),
        isFalse,
      );
      final status = await service.requestPermission();
      expect(status.authorized, isTrue);
      expect(
        calls.where((call) => call.method == 'requestNotificationsPermission'),
        hasLength(1),
      );
      expect((await service.reconcile(_snapshot())).scheduledCount, 3);
    },
  );

  test(
    'reconciliation is bounded, idempotent and uses inexact idle-safe alarms',
    () async {
      final snapshot = _snapshot(items: 30);
      final first = await service.reconcile(snapshot);
      expect(first.authorized, isTrue);
      expect(first.supported, isTrue);
      expect(first.scheduledCount, 60);
      expect(first.message, contains('nearest 60 of 90'));
      final initialIds = pending.keys.toSet();
      final scheduleCalls = calls.where(
        (call) => call.method == 'zonedSchedule',
      );
      for (final call in scheduleCalls) {
        final args = call.arguments as Map;
        expect(
          (args['platformSpecifics'] as Map)['scheduleMode'],
          'inexactAllowWhileIdle',
        );
        expect(args['timeZoneName'], zone);
        expect(args['payload'], isA<String>());
      }
      final second = await service.reconcile(snapshot);
      expect(second.scheduledCount, 60);
      expect(pending.keys.toSet(), initialIds);
      expect(
        calls.any((call) => call.method == 'requestExactAlarmsPermission'),
        isFalse,
      );
    },
  );

  test(
    'disabling reminders and claiming warranties cancel their pending queue',
    () async {
      await service.reconcile(_snapshot());
      expect(pending, hasLength(3));
      var status = await service.reconcile(_snapshot(claimed: true));
      expect(status.scheduledCount, 0);
      expect(pending, isEmpty);
      await service.reconcile(_snapshot());
      status = await service.reconcile(_snapshot(enabled: false));
      expect(status.scheduledCount, 0);
      expect(pending, isEmpty);
      expect(status.message, contains('turned off'));
    },
  );

  test(
    'notification titles and bodies use the selected generated localization',
    () async {
      final snapshot = _snapshot(language: 'es');
      await service.reconcile(snapshot);
      final l10n = lookupAppLocalizations(const Locale('es'));
      final notification = pending.values.first;
      expect(notification['title'], l10n.notificationTitle);
      expect(notification['body'], contains('Warranty 1'));
      expect(notification['body'], isNot(contains('warranty expires on')));
      expect(notification['payload'], snapshot.items.single.id);
    },
  );

  test(
    'unknown timezone is surfaced without scheduling a UTC fallback',
    () async {
      zone = 'Not/A-Timezone';
      final status = await service.reconcile(_snapshot());
      expect(status.scheduledCount, 0);
      expect(status.message, contains('Update reminders failed'));
      expect(status.message, contains(zone));
      expect(pending, isEmpty);
      expect(scheduleAttempts, 0);
    },
  );

  test(
    'native schedule errors are visible with an accurate partial count',
    () async {
      failScheduleAt = 2;
      final status = await service.reconcile(_snapshot());
      expect(status.scheduledCount, 1);
      expect(status.message, contains('schedule_failed'));
      expect(pending, hasLength(1));
    },
  );

  test('uncancelled old reminders prevent adding a duplicate queue', () async {
    await service.reconcile(_snapshot());
    final oldAttempts = scheduleAttempts;
    cancelWorks = false;
    final status = await service.reconcile(_snapshot());
    expect(status.message, contains('could not be cancelled'));
    expect(status.scheduledCount, 3);
    expect(scheduleAttempts, oldAttempts);
  });

  test('cold launch notification selects its warranty once', () async {
    final itemId = _snapshot().items.single.id;
    launch = {
      'notificationLaunchedApp': true,
      'notificationResponse': {
        'notificationId': 1,
        'notificationResponseType': 0,
        'payload': itemId,
      },
    };
    await service.dispose();
    final selected = <String>[];
    service = ReminderService(onItemSelected: selected.add);
    await service.initialize();
    await service.initialize();
    expect(selected, [itemId]);
  });

  test('a cold-start tap waits until the UI attaches its callback', () async {
    final itemId = _snapshot().items.single.id;
    launch = {
      'notificationLaunchedApp': true,
      'notificationResponse': {
        'notificationId': 1,
        'notificationResponseType': 0,
        'payload': itemId,
      },
    };
    await service.dispose();
    service = ReminderService();
    await service.initialize();
    final selected = <String>[];
    service.onItemSelected = selected.add;
    await Future<void>.delayed(Duration.zero);
    expect(selected, [itemId]);
    service.onItemSelected = selected.add;
    await Future<void>.delayed(Duration.zero);
    expect(selected, [itemId]);
  });

  test(
    'Linux reports app-open-only capability and uses no native scheduling API',
    () async {
      await service.dispose();
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      final linux = _LinuxNotifications();
      FlutterLocalNotificationsPlatform.instance = linux;
      service = ReminderService();
      final status = await service.reconcile(_snapshot());
      expect(linux.initialized, isTrue);
      expect(status.supported, isTrue);
      expect(status.authorized, isTrue);
      expect(status.scheduledCount, 3);
      expect(status.message, contains('only work while Kepli is open'));
      expect(calls, isEmpty);
      expect(
        (await service.reconcile(_snapshot(enabled: false))).scheduledCount,
        0,
      );
    },
  );

  test(
    'Linux daemon failures are visible and do not start a timer queue',
    () async {
      await service.dispose();
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      FlutterLocalNotificationsPlatform.instance = _LinuxNotifications()
        ..available = false;
      service = ReminderService();
      final status = await service.reconcile(_snapshot());
      expect(status.supported, isFalse);
      expect(status.authorized, isFalse);
      expect(status.scheduledCount, 0);
      expect(status.message, contains('No desktop notification daemon'));
    },
  );

  test(
    'disposing does not cancel native reminders needed after app exit',
    () async {
      await service.reconcile(_snapshot());
      final queued = pending.keys.toSet();
      await service.dispose();
      expect(pending.keys.toSet(), queued);
    },
  );
}
