// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => '내 보증. 내 영수증. 모두 내 것.';

  @override
  String get warranties => '보증';

  @override
  String get backups => '백업';

  @override
  String get settings => '설정';

  @override
  String get addWarranty => '보증 추가';

  @override
  String get editWarranty => '보증 수정';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get close => '닫기';

  @override
  String get edit => '수정';

  @override
  String get searchHint => '이름, 매장 또는 카테고리 검색';

  @override
  String get all => '전체';

  @override
  String get active => '유효';

  @override
  String get expiringSoon => '만료 예정';

  @override
  String get expired => '만료됨';

  @override
  String get claimed => '보증 청구됨';

  @override
  String get status => '상태';

  @override
  String get noWarranties => '아직 보증이 없습니다';

  @override
  String get getStarted => '구매 내역을 추가하고 영수증, 보증서, 연락처를 한곳에 보관하세요.';

  @override
  String get noMatches => '일치하는 보증이 없습니다';

  @override
  String get clearFilters => '필터 지우기';

  @override
  String get purchaseDate => '구매일';

  @override
  String get expiryDate => '만료일';

  @override
  String get warrantyLength => '보증 기간';

  @override
  String get months => '개월';

  @override
  String get years => '년';

  @override
  String get customDuration => '사용자 지정 기간';

  @override
  String get name => '이름';

  @override
  String get nameHint => '예: 주방 냉장고';

  @override
  String get category => '카테고리';

  @override
  String get vendor => '매장 또는 판매자';

  @override
  String get price => '가격(선택 사항)';

  @override
  String get currency => '통화 코드';

  @override
  String get notes => '메모';

  @override
  String get productPhoto => '제품 사진';

  @override
  String get receipt => '영수증';

  @override
  String get warrantyPaper => '보증서';

  @override
  String get attachments => '첨부 파일';

  @override
  String get addFiles => '파일 추가';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get choosePhoto => '사진 선택';

  @override
  String get removeAttachment => '첨부 파일 제거';

  @override
  String get openAttachment => '첨부 파일 열기';

  @override
  String get markClaimed => '보증 청구됨으로 표시';

  @override
  String get markActive => '보증 청구 상태 해제';

  @override
  String get exportPdf => '보증을 PDF로 내보내기';

  @override
  String get deleteWarranty => '보증을 삭제할까요?';

  @override
  String deleteWarrantyWarning(String name) {
    return '이 기기에서 $name 및 모든 첨부 파일을 삭제할까요? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일 남음',
      one: '1일 남음',
      zero: '오늘 만료',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '보증 $count개',
      one: '보증 1개',
      zero: '보증 없음',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => '필수 입력 항목입니다.';

  @override
  String get invalidDuration => '1~1,200개월을 입력하세요.';

  @override
  String get invalidPrice => '소수점 이하 두 자리까지의 금액을 입력하세요.';

  @override
  String get invalidCurrency => 'USD와 같은 영문 세 글자의 통화 코드를 입력하세요.';

  @override
  String get invalidEmail => '유효한 이메일 주소를 입력하세요.';

  @override
  String get discardChanges => '저장하지 않은 변경 사항을 버릴까요?';

  @override
  String get discard => '버리기';

  @override
  String get keepEditing => '계속 수정';

  @override
  String get restoreBackup => '백업 복원';

  @override
  String get exportBackup => '백업 내보내기';

  @override
  String get exportCsv => 'CSV 내보내기';

  @override
  String get backupExplanation =>
      '하나의 ZIP 파일에 보증, 연락처, 환경설정, 원본 첨부 파일이 모두 포함됩니다. 다른 기기로 옮긴 후 그 기기에서 복원하세요. 자동 동기화가 아닌 수동 전송입니다.';

  @override
  String get backupPrivacy =>
      '백업은 암호화되지 않습니다. 안전한 곳에 보관하세요. Kepli에는 클라우드 서비스가 없으며, 시스템 공유 패널에서 선택하는 대상은 사용자가 직접 관리합니다.';

  @override
  String get chooseBackup => '백업 파일 선택';

  @override
  String get backupPreview => '백업 검토';

  @override
  String get newWarranties => '새 보증';

  @override
  String backupSummary(int items, int files) {
    return '보증 $items개 및 첨부 파일 $files개';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date에 $platform에서 내보냄';
  }

  @override
  String get merge => '병합';

  @override
  String get mergeHelp => '새 보증을 추가하고 일치하는 보증은 더 최신 버전을 유지합니다. 현재 환경설정은 유지됩니다.';

  @override
  String get replaceAll => '모두 교체';

  @override
  String get replaceHelp => '이 기기의 보증과 환경설정을 백업의 내용으로 교체합니다.';

  @override
  String replaceConfirmation(int count) {
    return '이 기기의 보증 $count개를 모두 영구적으로 교체할까요? 기존 내용을 보관하려면 먼저 백업을 내보내세요.';
  }

  @override
  String get confirmReplace => '모든 보증 교체';

  @override
  String get conflicts => '일치하는 보증';

  @override
  String get keepLocal => '이 기기의 버전 유지';

  @override
  String get useBackup => '더 최신인 백업 버전 사용';

  @override
  String get newerWinsHelp =>
      '일반적으로 더 최근에 수정된 버전이 적용됩니다. 수정 시각이 같으면 이 기기의 버전을 유지합니다. 대신 로컬 버전을 유지하려면 아래에서 해당 보증을 선택하세요.';

  @override
  String get restore => '복원';

  @override
  String get notifications => '미리 알림';

  @override
  String get enableReminders => '만료 미리 알림 활성화';

  @override
  String get reminderDays => '만료 며칠 전';

  @override
  String get reminderDaysHelp => '30, 7, 1과 같이 값을 쉼표로 구분하세요. 만료일 당일은 0을 사용하세요.';

  @override
  String get invalidReminderDays => '0~3,650일 사이의 중복되지 않는 값을 1~12개 입력하세요.';

  @override
  String get reminderHour => '알림 시각(0~23시)';

  @override
  String get invalidReminderHour => '0~23 사이의 시간을 입력하세요.';

  @override
  String get reminderLimit =>
      '운영체제의 대기열에는 가장 가까운 미리 알림만 들어갑니다. Kepli를 정기적으로 열어 나머지 미리 알림을 추가하세요.';

  @override
  String get notificationPrivacy =>
      '미리 알림은 기기에서 예약됩니다. 권한, 배터리 설정, 운영체제에 따라 지연되거나 표시되지 않을 수 있습니다. 만료 예정 목록은 언제든지 확인할 수 있습니다.';

  @override
  String get permissionRequired => '알림 권한이 필요합니다.';

  @override
  String get requestPermission => '권한 요청';

  @override
  String get remindersOff => '미리 알림이 꺼져 있습니다.';

  @override
  String get remindersUnavailable => '시스템 미리 알림을 사용할 수 없습니다. 만료 예정 목록을 이용하세요.';

  @override
  String remindersScheduled(int count) {
    return '미리 알림 $count개가 예약되었습니다.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux에서는 Kepli가 열려 있고 알림 서비스를 사용할 수 있을 때만 미리 알림이 작동합니다.';

  @override
  String get accessibility => '접근성';

  @override
  String get highContrast => '대비 높이기';

  @override
  String get reduceMotion => '동작 줄이기';

  @override
  String get accessibilityHelp =>
      'Kepli는 시스템의 텍스트 크기, 화면 읽기, 대비, 동작 줄이기 설정도 따릅니다. 모든 작업은 제스처 없이 사용할 수 있습니다.';

  @override
  String get language => '언어';

  @override
  String get languageHelp =>
      '인터페이스 언어를 선택하세요. 기본 언어는 영어입니다. 저장한 항목의 텍스트는 번역되지 않습니다.';

  @override
  String get categories => '카테고리';

  @override
  String get addCategory => '카테고리 추가';

  @override
  String get renameCategory => '카테고리 이름 변경';

  @override
  String get deleteCategory => '카테고리 삭제';

  @override
  String get categoryInUse => '이 카테고리를 사용하는 보증이 있습니다. 먼저 해당 보증의 카테고리를 변경하세요.';

  @override
  String get newCategory => '카테고리 이름';

  @override
  String get categoryExists => '이미 존재하는 카테고리입니다.';

  @override
  String get categoryElectronics => '전자제품';

  @override
  String get categoryAppliances => '가전제품';

  @override
  String get categoryTools => '공구';

  @override
  String get categoryOther => '기타';

  @override
  String get exportReports => '보고서';

  @override
  String get about => 'Kepli 정보';

  @override
  String get privacyTitle => '내 기기에. 비공개로. 내 것으로.';

  @override
  String get privacyBody =>
      '계정, 구독, 사용 분석, Kepli 클라우드가 없습니다. 기록은 사용자가 내보내거나 공유하기 전까지 이 앱의 저장 공간에 보관됩니다. 백업을 정기적으로 내보내세요. 앱을 삭제하거나 기기를 분실하면 데이터가 사라질 수 있습니다.';

  @override
  String get appVersion => '버전';

  @override
  String get operationFailed => '작업을 완료하지 못했습니다.';

  @override
  String get technicalDetails => '기술 세부 정보';

  @override
  String get saved => '이 기기에 보증을 저장했습니다.';

  @override
  String get deleted => '보증과 첨부 파일을 삭제했습니다.';

  @override
  String get restored => '백업을 복원했습니다. 참조된 모든 첨부 파일을 검증했습니다.';

  @override
  String get settingsSaved => '설정을 저장했습니다.';

  @override
  String get exportReady => '내보내기가 준비되었습니다.';

  @override
  String get exportCancelled => '내보내기를 취소했습니다.';

  @override
  String fileSavedTo(String path) {
    return '$path에 파일을 저장했습니다';
  }

  @override
  String get shareOpened => '공유 패널에서 파일을 저장하거나 보낼 위치를 선택하세요.';

  @override
  String get loading => '불러오는 중';

  @override
  String get retry => '다시 시도';

  @override
  String get startupError => 'Kepli가 로컬 데이터를 열지 못했습니다. 기존 파일은 초기화되지 않았습니다.';

  @override
  String get unavailableImage => '이미지 미리보기를 사용할 수 없습니다. 원본 파일은 여전히 열 수 있습니다.';

  @override
  String get largeAttachmentTitle => '용량이 큰 첨부 파일';

  @override
  String largeAttachmentWarning(String size) {
    return '이 파일의 크기는 $size MB입니다. 용량이 큰 첨부 파일은 백업 속도를 늦추고 저장 공간을 더 많이 사용합니다.';
  }

  @override
  String get continueAction => '계속';

  @override
  String get recoverPhoto => '복구된 사진 사용';

  @override
  String get recoveredPhotoHelp =>
      '카메라로 인해 앱이 다시 시작된 후 사진을 복구했습니다. 사진이 사라지지 않도록 보증에 추가하세요.';

  @override
  String get dismiss => '무시';

  @override
  String get busy => '작업이 진행 중입니다. 잠시 기다려 주세요.';

  @override
  String get menu => '메뉴';

  @override
  String get sortHint => '만료일이 가까운 순으로 정렬됨';

  @override
  String get requiredFields => '이름, 카테고리, 구매일, 보증 기간은 필수 항목입니다.';

  @override
  String get chooseDate => '구매일 선택';

  @override
  String get selected => '선택됨';

  @override
  String get notSet => '설정되지 않음';

  @override
  String get reportTitle => '보증 보고서';

  @override
  String get pdfReferences =>
      'PDF 영수증과 보증서는 파일 이름으로 표시됩니다. 필요하면 원본 파일을 별도로 공유하세요.';

  @override
  String get documentFooter => 'Kepli가 기기에서 생성했습니다. 이 보고서는 복원 가능한 백업이 아닙니다.';

  @override
  String get notificationTitle => '보증 만료 예정';

  @override
  String notificationBody(String name, String date) {
    return '$name: 보증이 $date에 만료됩니다.';
  }

  @override
  String get contacts => '판매 및 서비스 연락처';

  @override
  String get addContact => '연락처 추가';

  @override
  String get editContact => '연락처 수정';

  @override
  String get removeContact => '연락처 제거';

  @override
  String get salesContact => '판매';

  @override
  String get serviceContact => '서비스';

  @override
  String get contactName => '담당자';

  @override
  String get organization => '회사 또는 조직';

  @override
  String get phone => '전화번호';

  @override
  String get email => '이메일';

  @override
  String get contactNotes => '연락처 메모';

  @override
  String get noContacts => '추가된 연락처가 없습니다';

  @override
  String get businessCard => '명함';

  @override
  String get scanBusinessCard => '명함 스캔';

  @override
  String get addBusinessCard => '명함 추가';

  @override
  String get businessCardHelp =>
      '명함을 촬영하거나 가져와 이 연락처에 첨부하세요. 아래에 담당자 정보를 입력하세요. Kepli는 클라우드 문자 인식을 사용하지 않습니다.';

  @override
  String get businessCardNeedsContact => '명함을 첨부하기 전에 연락처 이름을 저장하세요.';

  @override
  String get scanDocument => '문서 스캔';

  @override
  String get scanHelp =>
      '페이지를 촬영하거나 이미지를 선택한 다음 자르고 회전하여 하나의 PDF로 저장하세요. 처리는 이 기기에서 이루어지며 텍스트는 자동으로 추출되지 않습니다.';

  @override
  String get addPage => '페이지 추가';

  @override
  String get removePage => '페이지 제거';

  @override
  String get rotatePage => '페이지 회전';

  @override
  String pageNumber(int number) {
    return '$number페이지';
  }

  @override
  String get cropTop => '위쪽 자르기';

  @override
  String get cropBottom => '아래쪽 자르기';

  @override
  String get cropLeft => '왼쪽 자르기';

  @override
  String get cropRight => '오른쪽 자르기';

  @override
  String get enhanceDocument => '문서 대비 향상';

  @override
  String get saveScan => '스캔을 PDF로 저장';

  @override
  String get scanName => '문서 이름';

  @override
  String get noPages => '페이지를 한 개 이상 추가하세요.';

  @override
  String get desktopScanHelp =>
      '스캐너나 카메라로 저장한 이미지를 선택하세요. 스캐너 하드웨어를 직접 제어할 필요는 없습니다.';

  @override
  String get attachmentType => '첨부 파일 유형';

  @override
  String get previousPage => '이전 페이지';

  @override
  String get nextPage => '다음 페이지';

  @override
  String get processingDocument => '이 기기에서 문서 처리 중';

  @override
  String get readOnlyDetails => '보증 세부 정보';

  @override
  String get selectWarranty => '보증을 선택하면 세부 정보를 볼 수 있습니다.';
}
