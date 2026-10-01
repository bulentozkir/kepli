import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/vault_controller.dart';
import 'domain/models.dart';
import 'l10n/app_localizations.dart';
import 'services/reminder_service.dart';
import 'ui/home_screen.dart';

class KepliApp extends ConsumerStatefulWidget {
  const KepliApp({super.key});

  @override
  ConsumerState<KepliApp> createState() => _KepliAppState();
}

class _KepliAppState extends ConsumerState<KepliApp>
    with WidgetsBindingObserver {
  final _messenger = GlobalKey<ScaffoldMessengerState>();
  Timer? _dateTimer;
  CalendarDate _today = CalendarDate.fromDateTime(DateTime.now());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final reminders = ref.read(dependenciesProvider).reminders;
    if (reminders is ReminderService) {
      reminders.onItemSelected = (id) {
        if (mounted) ref.read(vaultProvider.notifier).selectItem(id);
      };
    }
    _dateTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = CalendarDate.fromDateTime(DateTime.now());
      if (now != _today) {
        _today = now;
        unawaited(_refresh());
      }
    });
  }

  Future<void> _refresh() async {
    try {
      await ref.read(vaultProvider.notifier).refresh();
    } on KepliException catch (error, stack) {
      debugPrintStack(label: error.toString(), stackTrace: stack);
      if (!mounted) return;
      final locale = Locale(
        ref.read(vaultProvider).snapshot.settings.languageCode,
      );
      final strings = lookupAppLocalizations(locale);
      _messenger.currentState?.showSnackBar(
        SnackBar(content: Text('${strings.operationFailed} ${error.message}')),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_refresh());
  }

  @override
  void dispose() {
    _dateTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(
      vaultProvider.select((value) => value.snapshot.settings),
    );
    final system = MediaQuery.of(context);
    final reducedMotion = settings.reduceMotion || system.disableAnimations;
    final contrast = settings.highContrast || system.highContrast;
    return MaterialApp(
      title: 'Kepli',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messenger,
      locale: Locale(settings.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildKepliTheme(Brightness.light, contrast, reducedMotion),
      darkTheme: buildKepliTheme(Brightness.dark, contrast, reducedMotion),
      highContrastTheme: buildKepliTheme(Brightness.light, true, reducedMotion),
      highContrastDarkTheme: buildKepliTheme(
        Brightness.dark,
        true,
        reducedMotion,
      ),
      themeAnimationDuration: reducedMotion
          ? Duration.zero
          : const Duration(milliseconds: 200),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(disableAnimations: reducedMotion, highContrast: contrast),
        child: child!,
      ),
      home: const HomeScreen(),
    );
  }
}

ThemeData buildKepliTheme(
  Brightness brightness,
  bool highContrast,
  bool reducedMotion,
) {
  final colors = ColorScheme.fromSeed(
    seedColor: const Color(0xff006b60),
    brightness: brightness,
    contrastLevel: highContrast ? 1 : 0,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colors,
    brightness: brightness,
    fontFamily: 'NotoSans',
    fontFamilyFallback: const [
      'NotoSansArabic',
      'NotoSansDevanagari',
      'NotoSansBengali',
      'NotoSansGurmukhi',
      'NotoSansGujarati',
      'NotoSansTamil',
      'NotoSansTelugu',
      'NotoSansKannada',
      'NotoSansMalayalam',
      'NotoSansThai',
      'NotoSansJP',
      'NotoSansKR',
      'NotoSansSC',
    ],
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: colors.surface,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    listTileTheme: const ListTileThemeData(
      minVerticalPadding: 12,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
    pageTransitionsTheme: reducedMotion
        ? PageTransitionsTheme(
            builders: {
              for (final platform in TargetPlatform.values)
                platform: const _NoPageTransitions(),
            },
          )
        : const PageTransitionsTheme(),
  );
}

class _NoPageTransitions extends PageTransitionsBuilder {
  const _NoPageTransitions();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}
