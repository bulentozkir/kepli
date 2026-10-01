import 'dart:async';

import 'package:drift/drift.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Restore tests intentionally open independent vaults with separate executors.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  await testMain();
}
