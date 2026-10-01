import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/application/vault_controller.dart';
import 'package:kepli/app.dart';
import 'package:kepli/data/kepli_database.dart';
import 'package:kepli/data/vault_repository.dart';
import 'package:kepli/domain/models.dart';
import 'package:kepli/l10n/app_localizations.dart';
import 'package:kepli/services/backup_service.dart';
import 'package:kepli/services/document_scanner.dart';
import 'package:kepli/services/platform_files.dart';
import 'package:kepli/services/reminder_service.dart';
import 'package:kepli/services/report_service.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

WarrantyItem uiItem({
  String? id,
  String name = 'Kitchen refrigerator',
  String category = 'Appliances',
  String vendor = 'Neighbourhood store',
  CalendarDate? purchased,
  int months = 24,
  bool claimed = false,
  List<ItemContact> contacts = const [],
}) => WarrantyItem(
  id: id ?? const Uuid().v4(),
  name: name,
  category: category,
  purchaseDate: purchased ?? CalendarDate.fromDateTime(DateTime.now()),
  warrantyLengthMonths: months,
  price: '299.90',
  currency: 'USD',
  vendor: vendor,
  notes: 'Original warranty documents',
  createdAt: DateTime.utc(2026, 1, 1),
  updatedAt: DateTime.utc(2026, 1, 2),
  claimed: claimed,
  contacts: contacts,
);

class UiHarness {
  UiHarness._({
    required this.work,
    required this.repository,
    required this.files,
    required this.reminders,
    required this.scanner,
  });

  final Directory work;
  final VaultRepository repository;
  final UiFiles files;
  final UiReminders reminders;
  final UiScanner scanner;
  ProviderContainer? container;

  static Future<UiHarness> create() async {
    final work = Directory(
      p.join(
        Directory.current.path,
        '.dart_tool',
        'kepli-ui-tests',
        const Uuid().v4(),
      ),
    );
    final root = Directory(p.join(work.path, 'vault'));
    await root.create(recursive: true);
    final repository = VaultRepository(
      database: KepliDatabase(NativeDatabase.memory()),
      root: root,
    );
    await repository.load();
    return UiHarness._(
      work: work,
      repository: repository,
      files: UiFiles(work),
      reminders: UiReminders(),
      scanner: UiScanner(work),
    );
  }

  Future<File> source(List<int> bytes, {String suffix = 'png'}) async {
    final file = File(p.join(work.path, '${const Uuid().v4()}.$suffix'));
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> pump(
    WidgetTester tester,
    Widget home, {
    Size size = const Size(390, 844),
    double textScale = 1,
    String locale = 'en',
    bool rtl = false,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(() async {
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();
    });
    final snapshot = await tester.runAsync(() async {
      final current = await repository.load();
      await repository.saveSettings(
        current.settings.copyWith(languageCode: locale),
      );
      return repository.load();
    });
    final dependencies = AppDependencies(
      repository: repository,
      backups: BackupService(repository: repository, temporaryDirectory: work),
      reports: ReportService(repository: repository, temporaryDirectory: work),
      files: files,
      reminders: reminders,
      scanner: scanner,
      initialSnapshot: snapshot!,
      initialReminderStatus: reminders.status,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dependenciesProvider.overrideWithValue(dependencies)],
        child: Consumer(
          builder: (context, ref, child) {
            final settings = ref.watch(vaultProvider).snapshot.settings;
            container = ProviderScope.containerOf(context);
            return MaterialApp(
              locale: Locale(settings.languageCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: buildKepliTheme(
                Brightness.light,
                settings.highContrast,
                settings.reduceMotion,
              ),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(textScale),
                  disableAnimations: settings.reduceMotion,
                  highContrast: settings.highContrast,
                ),
                child: Directionality(
                  textDirection: rtl
                      ? TextDirection.rtl
                      : Directionality.of(context),
                  child: child!,
                ),
              ),
              home: home,
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> dispose() async {
    await repository.close();
    if (await work.exists()) await work.delete(recursive: true);
  }
}

class UiFiles extends PlatformFiles {
  UiFiles(Directory directory) : super(temporaryDirectory: directory);
  bool mobile = false;
  List<PendingAttachment> selections = [];
  String? backupPath;
  AttachmentRole? requestedRole;
  String? requestedContactId;
  final origins = <Rect?>[];
  final exported = <File>[];
  final opened = <File>[];

  @override
  bool get isDesktop => !mobile;

  @override
  bool get cameraAvailable => mobile;

  @override
  Future<List<PendingAttachment>> pickAttachments({
    required AttachmentRole role,
    String? contactId,
  }) async {
    requestedRole = role;
    requestedContactId = contactId;
    return [
      for (final source in selections)
        PendingAttachment(
          sourcePath: source.sourcePath,
          originalName: source.originalName,
          mimeType: source.mimeType,
          role: role,
          contactId: contactId,
        ),
    ];
  }

  @override
  Future<PendingAttachment?> takePhoto({
    AttachmentRole role = AttachmentRole.receipt,
    String? contactId,
  }) async =>
      (await pickAttachments(role: role, contactId: contactId)).firstOrNull;

  @override
  Future<List<PendingAttachment>> pickPhotos({
    AttachmentRole role = AttachmentRole.receipt,
    String? contactId,
  }) => pickAttachments(role: role, contactId: contactId);

  @override
  Future<String?> pickBackup() async => backupPath;

  @override
  Future<String?> saveOrShare(
    File file, {
    Rect? shareOrigin,
    String languageCode = 'en',
  }) async {
    exported.add(file);
    origins.add(shareOrigin);
    return 'Saved to ${file.path}';
  }

  @override
  Future<void> openAttachment(File file) async => opened.add(file);
}

class UiReminders implements ReminderGateway {
  int permissionRequests = 0;
  ReminderStatus status = const ReminderStatus(
    authorized: false,
    supported: true,
  );

  @override
  Future<ReminderStatus> initialize() async => status;

  @override
  Future<ReminderStatus> requestPermission() async {
    permissionRequests++;
    return status = const ReminderStatus(authorized: true, supported: true);
  }

  @override
  Future<ReminderStatus> reconcile(VaultSnapshot snapshot) async =>
      status = ReminderStatus(
        authorized: status.authorized,
        supported: true,
        scheduledCount: snapshot.settings.remindersEnabled ? 3 : 0,
      );

  @override
  Future<void> dispose() async {}
}

class UiScanner extends DocumentScanner {
  UiScanner(Directory directory) : super(temporaryDirectory: directory);
  List<ScanPage>? pages;
  String? name;
  AttachmentRole? role;
  String? contactId;

  @override
  Future<PendingAttachment> createPdf({
    required List<ScanPage> pages,
    required String name,
    required AttachmentRole role,
    String? contactId,
  }) async {
    this.pages = List.of(pages);
    this.name = name;
    this.role = role;
    this.contactId = contactId;
    final file = File(p.join(temporaryDirectory.path, 'scan.pdf'));
    await file.writeAsString('%PDF-1.4\n%%EOF\n');
    return PendingAttachment(
      sourcePath: file.path,
      originalName: '$name.pdf',
      mimeType: 'application/pdf',
      role: role,
      contactId: contactId,
    );
  }
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder.hitTestable());
  await tester.pump();
}

Future<void> settleIo(WidgetTester tester, bool Function() done) async {
  for (var attempt = 0; attempt < 200; attempt++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump(const Duration(milliseconds: 10));
    if (done() &&
        PaintingBinding.instance.imageCache.pendingImageCount == 0 &&
        !tester.binding.hasScheduledFrame) {
      return;
    }
  }
  fail(
    'The UI operation did not finish: condition=${done()}, '
    'pendingImages=${PaintingBinding.instance.imageCache.pendingImageCount}, '
    'scheduledFrame=${tester.binding.hasScheduledFrame}.',
  );
}
