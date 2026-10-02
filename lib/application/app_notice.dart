import '../services/platform_files.dart';

/// Outcomes the UI can describe without the controller choosing the wording.
enum NoticeKind {
  saved,
  deleted,
  settingsSaved,
  restored,
  exportCancelled,
  exportHandedOff,
}

/// A user-visible result of an operation. The UI renders it in the active
/// language; no layer parses or compares message text.
sealed class AppNotice {
  const AppNotice();
}

/// A fixed, fully localizable outcome.
final class KindNotice extends AppNotice {
  const KindNotice(this.kind);

  final NoticeKind kind;
}

/// An export was written to [destination], a path or document name.
final class SavedToNotice extends AppNotice {
  const SavedToNotice(this.destination);

  final String destination;
}

/// Something needs attention. [detail] is technical text shown beneath a
/// localized heading, not a sentence that is itself translated.
final class ProblemNotice extends AppNotice {
  const ProblemNotice(this.detail);

  final String detail;
}

/// Describes how an export finished.
AppNotice noticeForExport(ExportOutcome outcome) => switch (outcome.status) {
  ExportStatus.cancelled => const KindNotice(NoticeKind.exportCancelled),
  ExportStatus.saved => SavedToNotice(outcome.destination!),
  ExportStatus.handedOff => const KindNotice(NoticeKind.exportHandedOff),
  ExportStatus.unconfirmed => const ProblemNotice(
    'The share sheet closed without confirming an export. '
    'Check the destination.',
  ),
};
