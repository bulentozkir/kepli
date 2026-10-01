import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:synchronized/synchronized.dart';
import 'package:timezone/data/latest_all.dart' as timezone_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/models.dart';
import '../l10n/app_localizations.dart';
import 'reminder_plan.dart';

class ReminderStatus {
  const ReminderStatus({
    required this.authorized,
    required this.supported,
    this.scheduledCount = 0,
    this.message,
  });

  final bool authorized;
  final bool supported;
  final int scheduledCount;
  final String? message;
}

abstract interface class ReminderGateway {
  Future<ReminderStatus> initialize();
  Future<ReminderStatus> requestPermission();
  Future<ReminderStatus> reconcile(VaultSnapshot snapshot);
  Future<void> dispose();
}

class ReminderService with WidgetsBindingObserver implements ReminderGateway {
  ReminderService({this._onItemSelected, this.onStatusChanged});

  void Function(String itemId)? _onItemSelected;
  void Function(ReminderStatus status)? onStatusChanged;
  String? _pendingSelection;
  final _plugin = FlutterLocalNotificationsPlugin();
  final _lock = Lock();
  final _platform = defaultTargetPlatform;
  bool _ready = false;
  bool _disposed = false;
  bool _authorized = false;
  bool _windowsPackaged = false;
  bool _observing = false;
  int _scheduledCount = 0;
  String? _unavailableReason;
  String? _lastError;
  tz.Location? _location;
  VaultSnapshot? _lastSnapshot;
  Timer? _linuxTimer;
  List<PlannedReminder> _linuxQueue = const [];
  ReminderStatus _status = const ReminderStatus(
    authorized: false,
    supported: false,
  );

  ReminderStatus get status => _status;

  void Function(String itemId)? get onItemSelected => _onItemSelected;

  set onItemSelected(void Function(String itemId)? callback) {
    _onItemSelected = callback;
    final pending = _pendingSelection;
    if (callback != null && pending != null) {
      _pendingSelection = null;
      scheduleMicrotask(() {
        if (!_disposed) _onItemSelected?.call(pending);
      });
    }
  }

  bool get _nativeScheduling => switch (_platform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.macOS => true,
    TargetPlatform.windows => _windowsPackaged,
    _ => false,
  };

  bool get _darwin =>
      _platform == TargetPlatform.iOS || _platform == TargetPlatform.macOS;

  @override
  Future<ReminderStatus> initialize() => _run('Initialize reminders', () async {
    await _ensureReady();
    if (_ready) await _readAuthorization();
    return _report();
  });

  Future<void> _ensureReady() async {
    if (_ready) return;
    if (_platform == TargetPlatform.fuchsia || kIsWeb) {
      _unavailableReason = 'Native reminders are unavailable on this platform.';
      return;
    }
    if (_platform == TargetPlatform.windows) {
      _windowsPackaged = MsixUtils.hasPackageIdentity();
      if (!_windowsPackaged) {
        _unavailableReason =
            'Native Windows reminders are unavailable in this unpackaged build. '
            'An installed MSIX build with notification identity is required; '
            'unpackaged notification cancellation is not reliable.';
        return;
      }
    }
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentBadge: false,
    );
    final initialized = await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_kepli'),
        iOS: darwin,
        macOS: darwin,
        linux: LinuxInitializationSettings(defaultActionName: 'Open Kepli'),
        windows: WindowsInitializationSettings(
          appName: 'Kepli',
          appUserModelId: 'io.github.bulentozkir.Kepli',
          guid: 'd70649ac-cc42-4bca-a69e-6e6d9f6c679a',
        ),
      ),
      onDidReceiveNotificationResponse: _onResponse,
    );
    // Darwin returns false when every permission request flag is false. This
    // means "no authorization requested", not that initialization failed.
    if (initialized == null || (!_darwin && !initialized)) {
      throw const KepliException(
        'The notification service could not initialize.',
      );
    }
    _ready = true;
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    if (_platform != TargetPlatform.linux) {
      final launch = await _plugin.getNotificationAppLaunchDetails();
      if (launch?.didNotificationLaunchApp ?? false) {
        final response = launch?.notificationResponse;
        if (response != null) _onResponse(response);
      }
    }
  }

  @override
  Future<ReminderStatus> requestPermission() =>
      _run('Request notification permission', () async {
        await _ensureReady();
        if (!_ready) return _report();
        switch (_platform) {
          case TargetPlatform.android:
            await _plugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >()!
                .requestNotificationsPermission();
          case TargetPlatform.iOS:
            await _plugin
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >()!
                .requestPermissions(alert: true, sound: true);
          case TargetPlatform.macOS:
            await _plugin
                .resolvePlatformSpecificImplementation<
                  MacOSFlutterLocalNotificationsPlugin
                >()!
                .requestPermissions(alert: true, sound: true);
          default:
            // Linux and Windows use system notification settings, not a
            // runtime authorization dialog.
            break;
        }
        await _readAuthorization();
        _lastError = null;
        return _report();
      });

  Future<void> _readAuthorization() async {
    switch (_platform) {
      case TargetPlatform.android:
        final enabled = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .areNotificationsEnabled();
        if (enabled == null) {
          throw const KepliException(
            'Notification authorization could not be checked.',
          );
        }
        _authorized = enabled;
      case TargetPlatform.iOS:
        final permissions = await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()!
            .checkPermissions();
        if (permissions == null) {
          throw const KepliException(
            'Notification authorization could not be checked.',
          );
        }
        _authorized = permissions.isEnabled || permissions.isProvisionalEnabled;
      case TargetPlatform.macOS:
        final permissions = await _plugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()!
            .checkPermissions();
        if (permissions == null) {
          throw const KepliException(
            'Notification authorization could not be checked.',
          );
        }
        _authorized = permissions.isEnabled || permissions.isProvisionalEnabled;
      case TargetPlatform.linux:
        _authorized = false;
        await _plugin
            .resolvePlatformSpecificImplementation<
              LinuxFlutterLocalNotificationsPlugin
            >()!
            .getCapabilities()
            .timeout(const Duration(seconds: 5));
        _authorized = true;
      case TargetPlatform.windows:
        _authorized = _windowsPackaged;
      default:
        _authorized = false;
    }
  }

  Future<void> _refreshTimeZone() async {
    // This bundled database contains the full IANA history and future rules.
    // No network request or fixed-offset/UTC fallback is used.
    timezone_data.initializeTimeZones();
    final zone = await FlutterTimezone.getLocalTimezone();
    _location = tz.getLocation(zone.identifier);
  }

  @override
  Future<ReminderStatus> reconcile(
    VaultSnapshot snapshot,
  ) => _run('Update reminders', () async {
    _lastSnapshot = snapshot;
    _linuxTimer?.cancel();
    _linuxQueue = const [];
    await _ensureReady();
    if (!_ready) return _report();
    await _cancelPending();
    await _readAuthorization();
    if (!snapshot.settings.remindersEnabled || !_authorized) {
      _lastError = null;
      return _report(
        detail: snapshot.settings.remindersEnabled
            ? null
            : 'Reminders are turned off.',
      );
    }
    await _refreshTimeZone();
    await initializeDateFormatting(snapshot.settings.languageCode);
    final plan = buildReminderPlan(
      snapshot: snapshot,
      location: _location!,
      now: DateTime.now(),
    );
    if (_platform == TargetPlatform.linux) {
      _linuxQueue = plan.reminders;
      _scheduledCount = _linuxQueue.length;
      _armLinuxTimer();
    } else {
      for (final reminder in plan.reminders) {
        final (title, body) = _notificationText(reminder, snapshot.settings);
        await _plugin.zonedSchedule(
          id: reminder.id,
          title: title,
          body: body,
          scheduledDate: reminder.scheduledAt,
          notificationDetails: _details(title),
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          payload: reminder.itemId,
        );
        _scheduledCount++;
      }
      final installed = await _plugin.pendingNotificationRequests();
      _scheduledCount = installed.length;
      final installedIds = installed.map((value) => value.id).toSet();
      if (plan.reminders.any((value) => !installedIds.contains(value.id))) {
        throw const KepliException(
          'The operating system did not retain every scheduled reminder.',
        );
      }
    }
    _lastError = null;
    return _report(
      detail: plan.isTruncated
          ? 'The nearest ${plan.reminders.length} of ${plan.totalCount} '
                'reminders are queued. Open Kepli regularly to refresh the queue.'
          : null,
    );
  });

  Future<void> _cancelPending() async {
    if (_platform == TargetPlatform.linux) {
      _scheduledCount = 0;
      return;
    }
    if (_platform == TargetPlatform.windows) {
      final pending = await _plugin.pendingNotificationRequests();
      for (final notification in pending) {
        await _plugin.cancel(id: notification.id);
      }
    } else {
      await _plugin.cancelAllPendingNotifications();
    }
    final remaining = await _plugin.pendingNotificationRequests();
    _scheduledCount = remaining.length;
    if (remaining.isNotEmpty) {
      throw const KepliException(
        'Previously scheduled reminders could not be cancelled. No new reminders were added.',
      );
    }
  }

  (String, String) _notificationText(
    PlannedReminder reminder,
    AppSettings settings,
  ) {
    final l10n = lookupAppLocalizations(Locale(settings.languageCode));
    final date = DateFormat.yMMMd(
      settings.languageCode,
    ).format(reminder.expiryDate.utcDate);
    return (
      l10n.notificationTitle,
      l10n.notificationBody(reminder.itemName, date),
    );
  }

  NotificationDetails _details(String channelName) => NotificationDetails(
    android: AndroidNotificationDetails(
      'kepli_warranty_reminders',
      channelName,
      icon: 'ic_stat_kepli',
      category: AndroidNotificationCategory.reminder,
      visibility: NotificationVisibility.private,
    ),
    iOS: const DarwinNotificationDetails(presentBadge: false),
    macOS: const DarwinNotificationDetails(presentBadge: false),
    linux: const LinuxNotificationDetails(),
    windows: const WindowsNotificationDetails(),
  );

  void _armLinuxTimer() {
    _linuxTimer?.cancel();
    if (_disposed || _linuxQueue.isEmpty) return;
    final untilNext = _linuxQueue.first.scheduledAt.difference(DateTime.now());
    final delay = untilNext.isNegative
        ? Duration.zero
        : untilNext > const Duration(hours: 1)
        ? const Duration(hours: 1)
        : untilNext;
    _linuxTimer = Timer(delay, () {
      unawaited(_run('Deliver Linux reminder', _deliverLinuxReminders));
    });
  }

  Future<ReminderStatus> _deliverLinuxReminders() async {
    final snapshot = _lastSnapshot;
    if (snapshot == null || !snapshot.settings.remindersEnabled) {
      return _report();
    }
    final previousZone = _location?.name;
    await _refreshTimeZone();
    final now = tz.TZDateTime.now(_location!);
    final today = CalendarDate.fromDateTime(now);
    if (_location!.name == previousZone) {
      for (final reminder in _linuxQueue) {
        if (reminder.scheduledAt.isAfter(now)) break;
        // A suspended computer must not emit a backlog of old reminders.
        if (CalendarDate.fromDateTime(reminder.scheduledAt) != today ||
            reminder.expiryDate.compareTo(today) < 0) {
          continue;
        }
        final (title, body) = _notificationText(reminder, snapshot.settings);
        await _plugin.show(
          id: reminder.id,
          title: title,
          body: body,
          notificationDetails: _details(title),
          payload: reminder.itemId,
        );
      }
    }
    final plan = buildReminderPlan(
      snapshot: snapshot,
      location: _location!,
      now: now,
    );
    _linuxQueue = plan.reminders;
    _scheduledCount = _linuxQueue.length;
    _lastError = null;
    _armLinuxTimer();
    return _report();
  }

  void _onResponse(NotificationResponse response) {
    final id = response.payload;
    if (_disposed || id == null || !isUuid(id)) return;
    if (_onItemSelected == null) {
      _pendingSelection = id;
      return;
    }
    try {
      _onItemSelected?.call(id);
    } catch (error, stack) {
      _recordError('Open warranty from reminder', error, stack);
      _report();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final snapshot = _lastSnapshot;
    if (!_disposed && state == AppLifecycleState.resumed && snapshot != null) {
      unawaited(reconcile(snapshot));
    }
  }

  ReminderStatus _report({String? detail}) {
    final messages = <String>[
      ?_unavailableReason,
      if (_platform == TargetPlatform.linux)
        'Linux has no native reminder scheduler. Reminders only work while '
            'Kepli is open and a desktop notification service is available.',
      if (_platform == TargetPlatform.windows && _windowsPackaged)
        'Delivery also depends on Windows notification settings and Do Not Disturb.',
      if (_ready && !_authorized)
        'Notification permission is not granted. Enable it in system settings.',
      if (_platform == TargetPlatform.android && _authorized)
        'Android reminders are approximate and may be delayed by battery saving.',
      ?detail,
      ?_lastError,
    ];
    _status = ReminderStatus(
      authorized: _authorized,
      supported:
          _nativeScheduling ||
          (_platform == TargetPlatform.linux && _ready && _authorized),
      scheduledCount: _scheduledCount,
      message: messages.isEmpty ? null : messages.join(' '),
    );
    try {
      onStatusChanged?.call(_status);
    } catch (error, stack) {
      developer.log(
        'Reminder status listener failed',
        name: 'kepli.reminders',
        error: error,
        stackTrace: stack,
      );
    }
    return _status;
  }

  Future<ReminderStatus> _run(
    String operation,
    Future<ReminderStatus> Function() action,
  ) => _lock.synchronized(() async {
    if (_disposed) return _status;
    try {
      return await action();
    } catch (error, stack) {
      if (_platform == TargetPlatform.linux) {
        _linuxTimer?.cancel();
        _linuxQueue = const [];
        _scheduledCount = 0;
      }
      _recordError(operation, error, stack);
      return _report();
    }
  });

  void _recordError(String operation, Object error, StackTrace stack) {
    developer.log(
      '$operation failed',
      name: 'kepli.reminders',
      error: error,
      stackTrace: stack,
    );
    _lastError = '$operation failed: $error';
  }

  @override
  Future<void> dispose() => _lock.synchronized(() async {
    if (_disposed) return;
    _disposed = true;
    _linuxTimer?.cancel();
    _linuxQueue = const [];
    if (_observing) {
      WidgetsBinding.instance.removeObserver(this);
      _observing = false;
    }
    try {
      if (_platform == TargetPlatform.windows && _ready) {
        _plugin
            .resolvePlatformSpecificImplementation<
              FlutterLocalNotificationsWindows
            >()
            ?.dispose();
      }
    } catch (error, stack) {
      _recordError('Dispose reminders', error, stack);
      _report();
    }
    // Native scheduled notifications intentionally survive application exit.
  });
}
