import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

String _read(List<String> path) => File(p.joinAll(path)).readAsStringSync();

void main() {
  test('Android disables cloud backup and device-to-device extraction', () {
    final manifest = _read([
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    ]);
    expect(manifest, contains('android:allowBackup="false"'));
    expect(manifest, contains('android:fullBackupContent="@xml/backup_rules"'));
    expect(
      manifest,
      contains('android:dataExtractionRules="@xml/data_extraction_rules"'),
    );
    final rules = _read([
      'android',
      'app',
      'src',
      'main',
      'res',
      'xml',
      'data_extraction_rules.xml',
    ]);
    expect(rules, contains('<cloud-backup'));
    expect(rules, contains('<device-transfer>'));
    for (final domain in [
      'root',
      'file',
      'database',
      'sharedpref',
      'external',
      'device_root',
      'device_file',
      'device_database',
      'device_sharedpref',
    ]) {
      expect(
        '<exclude domain="$domain" path="." />'.allMatches(rules),
        hasLength(2),
      );
    }
  });

  test(
    'Android notifications have boot restoration and no exact-alarm request',
    () {
      final manifest = _read([
        'android',
        'app',
        'src',
        'main',
        'AndroidManifest.xml',
      ]);
      expect(manifest, contains('android.permission.POST_NOTIFICATIONS'));
      expect(manifest, contains('android.permission.RECEIVE_BOOT_COMPLETED'));
      expect(manifest, contains('ScheduledNotificationReceiver'));
      expect(manifest, contains('ScheduledNotificationBootReceiver'));
      expect(manifest, contains('android.intent.action.BOOT_COMPLETED'));
      for (final permission in [
        'SCHEDULE_EXACT_ALARM',
        'USE_EXACT_ALARM',
        'READ_EXTERNAL_STORAGE',
        'WRITE_EXTERNAL_STORAGE',
        'MANAGE_EXTERNAL_STORAGE',
        'READ_MEDIA_IMAGES',
        'READ_MEDIA_VIDEO',
        'READ_MEDIA_AUDIO',
      ]) {
        expect(
          manifest,
          contains('android.permission.$permission" tools:node="remove"'),
        );
      }
      final release = _read([
        'android',
        'app',
        'src',
        'release',
        'AndroidManifest.xml',
      ]);
      expect(
        release,
        contains('android.permission.INTERNET" tools:node="remove"'),
      );
      expect(
        _read(['android', 'app', 'build.gradle.kts']),
        contains('isCoreLibraryDesugaringEnabled = true'),
      );
      expect(
        _read(['android', 'app', 'build.gradle.kts']),
        isNot(contains('signingConfigs.getByName("debug")')),
      );
      expect(
        _read(['android', 'app', 'src', 'main', 'res', 'raw', 'keep.xml']),
        contains('@drawable/ic_stat_kepli'),
      );
    },
  );

  test('phone and tablet orientations are not locked', () {
    final manifest = _read([
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    ]);
    expect(manifest, isNot(contains('android:screenOrientation')));
    final plist = _read(['ios', 'Runner', 'Info.plist']);
    for (final orientation in [
      'Portrait',
      'PortraitUpsideDown',
      'LandscapeLeft',
      'LandscapeRight',
    ]) {
      expect(
        '<string>UIInterfaceOrientation$orientation</string>'.allMatches(plist),
        hasLength(2),
      );
    }
    expect(plist, contains('NSCameraUsageDescription'));
    expect(plist, contains('NSPhotoLibraryUsageDescription'));
    expect(
      _read(['ios', 'Runner.xcodeproj', 'project.pbxproj']),
      contains('TARGETED_DEVICE_FAMILY = "1,2";'),
    );
  });

  test(
    'Apple storage protection has matching, verified native channel handlers',
    () {
      for (final source in [
        ['ios', 'Runner', 'AppDelegate.swift'],
        ['macos', 'Runner', 'MainFlutterWindow.swift'],
      ]) {
        final code = _read(source);
        expect(code, contains('name: "kepli/storage"'));
        expect(code, contains('"excludeFromBackup"'));
        expect(code, contains('values.isExcludedFromBackup = true'));
        expect(code, contains('stored.isExcludedFromBackup == true'));
        expect(code, contains('"backup_exclusion_failed"'));
      }
    },
  );

  test(
    'macOS sandbox allows user-selected imports and exports, not networking',
    () {
      for (final name in [
        'DebugProfile.entitlements',
        'Release.entitlements',
      ]) {
        final entitlements = _read(['macos', 'Runner', name]);
        expect(entitlements, contains('com.apple.security.app-sandbox'));
        expect(
          entitlements,
          contains('com.apple.security.files.user-selected.read-write'),
        );
      }
      final release = _read(['macos', 'Runner', 'Release.entitlements']);
      expect(release, isNot(contains('com.apple.security.network')));
    },
  );

  test('all desktop runner window titles display Kepli', () {
    expect(
      _read(['windows', 'runner', 'main.cpp']),
      contains('window.Create(L"Kepli"'),
    );
    expect(
      _read(['linux', 'runner', 'my_application.cc']),
      contains('gtk_window_set_title(window, "Kepli")'),
    );
    expect(
      _read(['macos', 'Runner', 'MainFlutterWindow.swift']),
      contains('self.title = "Kepli"'),
    );
  });
}
