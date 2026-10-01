import 'dart:async';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'application/vault_controller.dart';
import 'data/kepli_database.dart';
import 'data/vault_repository.dart';
import 'domain/models.dart';
import 'l10n/app_localizations.dart';
import 'services/backup_service.dart';
import 'services/document_scanner.dart';
import 'services/platform_files.dart';
import 'services/reminder_service.dart';
import 'services/report_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    for (final license in [
      'OFL-Noto.txt',
      'OFL-NotoSansSC.txt',
      'OFL-NotoSansJP.txt',
      'OFL-NotoSansKR.txt',
    ]) {
      yield LicenseEntryWithLineBreaks(const [
        'Noto fonts',
      ], await rootBundle.loadString('assets/fonts/$license'));
    }
  });
  runApp(const KepliBootstrap());
}

Future<AppDependencies> initializeKepli() async {
  final support = await getApplicationSupportDirectory();
  final temporary = await getTemporaryDirectory();
  final root = Directory(p.join(support.path, 'vault'));
  final staging = Directory(p.join(temporary.path, 'kepli'));
  await root.create(recursive: true);
  await staging.create(recursive: true);
  final files = PlatformFiles(temporaryDirectory: staging);
  await files.protectLocalStorage(root);
  final database = KepliDatabase(
    NativeDatabase.createInBackground(
      File(p.join(root.path, 'kepli.db')),
      setup: (database) => database.execute('PRAGMA temp_store = MEMORY'),
    ),
  );
  final repository = VaultRepository(database: database, root: root);
  var initialized = false;
  try {
    final snapshot = await repository.load();
    final reminders = ReminderService();
    final initialStatus = await reminders.initialize();
    final status = initialStatus.supported
        ? await reminders.reconcile(snapshot)
        : initialStatus;
    var recovered = <PendingAttachment>[];
    String? notice;
    try {
      recovered = await files.recoverLostPhotos();
    } on PlatformException catch (error, stack) {
      debugPrintStack(label: error.toString(), stackTrace: stack);
      notice = error.message ?? error.code;
    } on KepliException catch (error, stack) {
      debugPrintStack(label: error.toString(), stackTrace: stack);
      notice = error.message;
    }
    final dependencies = AppDependencies(
      repository: repository,
      backups: BackupService(
        repository: repository,
        temporaryDirectory: staging,
      ),
      reports: ReportService(
        repository: repository,
        temporaryDirectory: staging,
      ),
      files: files,
      reminders: reminders,
      scanner: DocumentScanner(temporaryDirectory: staging),
      initialSnapshot: snapshot,
      initialReminderStatus: status,
      recoveredPhotos: recovered,
      startupNotice: notice,
    );
    initialized = true;
    return dependencies;
  } finally {
    if (!initialized) await repository.close();
  }
}

class KepliBootstrap extends StatefulWidget {
  const KepliBootstrap({super.key});

  @override
  State<KepliBootstrap> createState() => _KepliBootstrapState();
}

class _KepliBootstrapState extends State<KepliBootstrap> {
  late Future<AppDependencies> _initialization = initializeKepli();
  AppDependencies? _dependencies;

  @override
  void dispose() {
    final dependencies = _dependencies;
    if (dependencies != null) {
      unawaited(dependencies.reminders.dispose());
      unawaited(dependencies.repository.close());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<AppDependencies>(
    future: _initialization,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _dependencies = snapshot.requireData;
        return ProviderScope(
          overrides: [
            dependenciesProvider.overrideWithValue(snapshot.requireData),
          ],
          child: const KepliApp(),
        );
      }
      return MaterialApp(
        title: 'Kepli',
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: buildKepliTheme(Brightness.light, false, true),
        darkTheme: buildKepliTheme(Brightness.dark, false, true),
        home: Builder(
          builder: (context) {
            final strings = AppLocalizations.of(context);
            return Scaffold(
              appBar: AppBar(title: const Text('Kepli')),
              body: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: snapshot.hasError
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Semantics(
                                  liveRegion: true,
                                  child: Text(strings.startupError),
                                ),
                                const SizedBox(height: 16),
                                SelectableText(
                                  '${strings.technicalDetails}: ${snapshot.error}',
                                ),
                                const SizedBox(height: 24),
                                FilledButton.icon(
                                  onPressed: () => setState(
                                    () => _initialization = initializeKepli(),
                                  ),
                                  icon: const Icon(Icons.refresh),
                                  label: Text(strings.retry),
                                ),
                              ],
                            )
                          : Semantics(
                              label: strings.loading,
                              liveRegion: true,
                              child: const CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
