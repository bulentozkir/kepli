import 'package:flutter_test/flutter_test.dart';
import 'package:kepli/application/app_notice.dart';
import 'package:kepli/services/platform_files.dart';

void main() {
  group('noticeForExport', () {
    test('a saved export reports its destination', () {
      final notice = noticeForExport(
        const ExportOutcome.saved('C:/Users/me/backup.zip'),
      );
      expect(notice, isA<SavedToNotice>());
      expect((notice as SavedToNotice).destination, 'C:/Users/me/backup.zip');
    });

    test('cancelling and handing off map to fixed localizable kinds', () {
      expect(
        (noticeForExport(ExportOutcome.cancelled) as KindNotice).kind,
        NoticeKind.exportCancelled,
      );
      expect(
        (noticeForExport(ExportOutcome.handedOff) as KindNotice).kind,
        NoticeKind.exportHandedOff,
      );
    });

    test('an unconfirmed share is a problem with technical detail', () {
      final notice = noticeForExport(ExportOutcome.unconfirmed);
      expect(notice, isA<ProblemNotice>());
      expect((notice as ProblemNotice).detail, contains('confirming'));
    });
  });
}
