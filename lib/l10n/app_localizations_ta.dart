// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline =>
      'உங்கள் உத்தரவாதங்கள். உங்கள் ரசீதுகள். உங்களுக்கே சொந்தம்.';

  @override
  String get warranties => 'உத்தரவாதங்கள்';

  @override
  String get backups => 'காப்புப்பிரதிகள்';

  @override
  String get settings => 'அமைப்புகள்';

  @override
  String get addWarranty => 'உத்தரவாதத்தைச் சேர்க்கவும்';

  @override
  String get editWarranty => 'உத்தரவாதத்தைத் திருத்தவும்';

  @override
  String get save => 'சேமிக்கவும்';

  @override
  String get cancel => 'ரத்துசெய்யவும்';

  @override
  String get delete => 'நீக்கவும்';

  @override
  String get close => 'மூடவும்';

  @override
  String get edit => 'திருத்தவும்';

  @override
  String get searchHint => 'பெயர், கடை அல்லது வகையைத் தேடவும்';

  @override
  String get all => 'அனைத்தும்';

  @override
  String get active => 'செல்லுபடியாகும்';

  @override
  String get expiringSoon => 'விரைவில் காலாவதியாகும்';

  @override
  String get expired => 'காலாவதியானது';

  @override
  String get claimed => 'கோரிக்கை விடுக்கப்பட்டது';

  @override
  String get status => 'நிலை';

  @override
  String get noWarranties => 'இன்னும் உத்தரவாதங்கள் இல்லை';

  @override
  String get getStarted =>
      'ஒரு கொள்முதலைச் சேர்த்து, அதன் ரசீது, உத்தரவாத ஆவணங்கள் மற்றும் தொடர்புகளை ஒன்றாக வைத்திருக்கவும்.';

  @override
  String get noMatches => 'பொருந்தும் உத்தரவாதங்கள் இல்லை';

  @override
  String get clearFilters => 'வடிப்பான்களை அகற்றவும்';

  @override
  String get purchaseDate => 'வாங்கிய தேதி';

  @override
  String get expiryDate => 'காலாவதித் தேதி';

  @override
  String get warrantyLength => 'உத்தரவாதக் காலம்';

  @override
  String get months => 'மாதங்கள்';

  @override
  String get years => 'ஆண்டுகள்';

  @override
  String get customDuration => 'விருப்பக் கால அளவு';

  @override
  String get name => 'பெயர்';

  @override
  String get nameHint => 'எடுத்துக்காட்டாக, சமையலறைக் குளிர்சாதனப் பெட்டி';

  @override
  String get category => 'வகை';

  @override
  String get vendor => 'கடை அல்லது விற்பனையாளர்';

  @override
  String get price => 'விலை (விருப்பத்திற்குரியது)';

  @override
  String get currency => 'நாணயக் குறியீடு';

  @override
  String get notes => 'குறிப்புகள்';

  @override
  String get productPhoto => 'பொருளின் புகைப்படம்';

  @override
  String get receipt => 'ரசீது';

  @override
  String get warrantyPaper => 'உத்தரவாத ஆவணம்';

  @override
  String get attachments => 'இணைப்புகள்';

  @override
  String get addFiles => 'கோப்புகளைச் சேர்க்கவும்';

  @override
  String get takePhoto => 'புகைப்படம் எடுக்கவும்';

  @override
  String get choosePhoto => 'புகைப்படங்களைத் தேர்ந்தெடுக்கவும்';

  @override
  String get removeAttachment => 'இணைப்பை அகற்றவும்';

  @override
  String get openAttachment => 'இணைப்பைத் திறக்கவும்';

  @override
  String get markClaimed => 'கோரிக்கை விடுக்கப்பட்டதாகக் குறிக்கவும்';

  @override
  String get markActive => 'கோரிக்கை விடுக்கப்பட்ட நிலையைக் களையவும்';

  @override
  String get exportPdf => 'உத்தரவாத PDF-ஐ ஏற்றுமதி செய்யவும்';

  @override
  String get deleteWarranty => 'உத்தரவாதத்தை நீக்கவா?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'இந்தச் சாதனத்திலிருந்து $name மற்றும் அதன் அனைத்து இணைப்புகளையும் நீக்கவா? இதைச் செயல்தவிர்க்க முடியாது.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'இன்னும் $count நாட்கள் உள்ளன',
      one: 'இன்னும் 1 நாள் உள்ளது',
      zero: 'இன்று காலாவதியாகிறது',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count உத்தரவாதங்கள்',
      one: '1 உத்தரவாதம்',
      zero: 'உத்தரவாதங்கள் இல்லை',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'இந்தப் புலம் கட்டாயமானது.';

  @override
  String get invalidDuration => '1 முதல் 1,200 மாதங்கள் வரை உள்ளிடவும்.';

  @override
  String get invalidPrice =>
      'தசமப் புள்ளிக்குப் பிறகு அதிகபட்சம் இரண்டு இலக்கங்களுடன் தொகையை உள்ளிடவும்.';

  @override
  String get invalidCurrency =>
      'USD போன்ற மூன்று எழுத்து நாணயக் குறியீட்டை உள்ளிடவும்.';

  @override
  String get invalidEmail => 'செல்லுபடியாகும் மின்னஞ்சல் முகவரியை உள்ளிடவும்.';

  @override
  String get discardChanges => 'சேமிக்காத மாற்றங்களைக் கைவிடவா?';

  @override
  String get discard => 'கைவிடவும்';

  @override
  String get keepEditing => 'திருத்துவதைத் தொடரவும்';

  @override
  String get restoreBackup => 'காப்புப்பிரதியை மீட்டமைக்கவும்';

  @override
  String get exportBackup => 'காப்புப்பிரதியை ஏற்றுமதி செய்யவும்';

  @override
  String get exportCsv => 'CSV-ஐ ஏற்றுமதி செய்யவும்';

  @override
  String get backupExplanation =>
      'ஒரே ZIP கோப்பில் உங்கள் உத்தரவாதங்கள், தொடர்புகள், விருப்பங்கள் மற்றும் அசல் இணைப்புகள் இருக்கும். அதை மற்றொரு சாதனத்திற்கு மாற்றி அங்கே மீட்டமைக்கவும். இது கைமுறையான பரிமாற்றம்; தானியங்கு ஒத்திசைவு அல்ல.';

  @override
  String get backupPrivacy =>
      'காப்புப்பிரதிகள் குறியாக்கம் செய்யப்படுவதில்லை. அவற்றைப் பாதுகாப்பான இடத்தில் வைத்திருக்கவும். Kepli-க்கு மேகச் சேவை இல்லை; கணினியின் பகிர்வுப் பலகையில் நீங்கள் தேர்ந்தெடுக்கும் இடங்கள் உங்கள் கட்டுப்பாட்டில் உள்ளன.';

  @override
  String get chooseBackup => 'காப்புப்பிரதிக் கோப்பைத் தேர்ந்தெடுக்கவும்';

  @override
  String get backupPreview => 'காப்புப்பிரதியை மதிப்பாய்வு செய்யவும்';

  @override
  String get newWarranties => 'புதிய உத்தரவாதங்கள்';

  @override
  String backupSummary(int items, int files) {
    return '$items உத்தரவாதங்கள் மற்றும் $files இணைப்புகள்';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date அன்று $platform-இல் ஏற்றுமதி செய்யப்பட்டது';
  }

  @override
  String get merge => 'ஒன்றிணைக்கவும்';

  @override
  String get mergeHelp =>
      'புதிய உத்தரவாதங்களைச் சேர்த்து, பொருந்தும் உத்தரவாதங்களில் புதிய பதிப்பை வைத்திருக்கவும். தற்போதைய விருப்பங்கள் தக்கவைக்கப்படும்.';

  @override
  String get replaceAll => 'அனைத்தையும் மாற்றவும்';

  @override
  String get replaceHelp =>
      'இந்தச் சாதனத்தின் உத்தரவாதங்கள் மற்றும் விருப்பங்களைக் காப்புப்பிரதியிலுள்ளவற்றால் மாற்றவும்.';

  @override
  String replaceConfirmation(int count) {
    return 'இந்தச் சாதனத்தில் உள்ள $count உத்தரவாதங்களையும் நிரந்தரமாக மாற்றவா? அவற்றை வைத்திருக்க விரும்பினால் முதலில் காப்புப்பிரதியை ஏற்றுமதி செய்யவும்.';
  }

  @override
  String get confirmReplace => 'அனைத்து உத்தரவாதங்களையும் மாற்றவும்';

  @override
  String get conflicts => 'பொருந்தும் உத்தரவாதங்கள்';

  @override
  String get keepLocal => 'இந்தச் சாதனத்தின் பதிப்பை வைத்திருக்கவும்';

  @override
  String get useBackup => 'காப்புப்பிரதியின் புதிய பதிப்பைப் பயன்படுத்தவும்';

  @override
  String get newerWinsHelp =>
      'பொதுவாக அண்மையில் புதுப்பிக்கப்பட்ட பதிப்பே தக்கவைக்கப்படும். நேர முத்திரைகள் சமமாக இருந்தால் இந்தச் சாதனத்தின் பதிப்பு தக்கவைக்கப்படும். அதற்குப் பதிலாக உள்ளூர் பதிப்பை வைத்திருக்க விரும்பும் உத்தரவாதங்களைக் கீழே தேர்ந்தெடுக்கவும்.';

  @override
  String get restore => 'மீட்டமைக்கவும்';

  @override
  String get notifications => 'நினைவூட்டல்கள்';

  @override
  String get enableReminders => 'காலாவதி நினைவூட்டல்களை இயக்கவும்';

  @override
  String get reminderDays => 'காலாவதிக்கு முந்தைய நாட்கள்';

  @override
  String get reminderDaysHelp =>
      'மதிப்புகளை காற்புள்ளிகளால் பிரிக்கவும், எடுத்துக்காட்டாக 30, 7, 1. காலாவதித் தேதிக்கு 0 பயன்படுத்தவும்.';

  @override
  String get invalidReminderDays =>
      '1 முதல் 12 வெவ்வேறு மதிப்புகளை உள்ளிடவும். ஒவ்வொன்றும் 0 முதல் 3,650 நாட்களுக்குள் இருக்க வேண்டும்.';

  @override
  String get reminderHour => 'நினைவூட்டும் மணி (0–23)';

  @override
  String get invalidReminderHour => '0 முதல் 23 வரையிலான மணியை உள்ளிடவும்.';

  @override
  String get reminderLimit =>
      'இயக்க முறைமையின் வரிசையில் மிக அண்மைய நினைவூட்டல்களுக்கு மட்டுமே இடமுள்ளது. அடுத்த நினைவூட்டல்களைச் சேர்க்க Kepli-ஐத் தவறாமல் திறக்கவும்.';

  @override
  String get notificationPrivacy =>
      'நினைவூட்டல்கள் சாதனத்திலேயே திட்டமிடப்படுகின்றன. அனுமதிகள், மின்கல அமைப்புகள் மற்றும் இயக்க முறைமை அவற்றைத் தாமதப்படுத்தலாம் அல்லது தடுக்கலாம். விரைவில் காலாவதியாகும் பட்டியல் எப்போதும் கிடைக்கும்.';

  @override
  String get permissionRequired => 'அறிவிப்பு அனுமதி தேவை.';

  @override
  String get requestPermission => 'அனுமதி கோரவும்';

  @override
  String get remindersOff => 'நினைவூட்டல்கள் முடக்கப்பட்டுள்ளன.';

  @override
  String get remindersUnavailable =>
      'கணினி நினைவூட்டல்கள் கிடைக்கவில்லை. விரைவில் காலாவதியாகும் பட்டியலைப் பயன்படுத்தவும்.';

  @override
  String remindersScheduled(int count) {
    return '$count நினைவூட்டல்கள் திட்டமிடப்பட்டுள்ளன.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux-இல், Kepli திறந்திருக்கும் போதும் அறிவிப்புச் சேவை கிடைக்கும் போதும் மட்டுமே நினைவூட்டல்கள் செயல்படும்.';

  @override
  String get accessibility => 'அணுகல்தன்மை';

  @override
  String get highContrast => 'நிற வேறுபாட்டை அதிகரிக்கவும்';

  @override
  String get reduceMotion => 'அசைவைக் குறைக்கவும்';

  @override
  String get accessibilityHelp =>
      'Kepli உங்கள் கணினியின் எழுத்தளவு, திரை வாசிப்பான், நிற வேறுபாடு மற்றும் குறைந்த அசைவு அமைப்புகளையும் பின்பற்றுகிறது. ஒவ்வொரு செயலையும் சைகைகள் இல்லாமல் செய்யலாம்.';

  @override
  String get language => 'மொழி';

  @override
  String get languageHelp =>
      'இடைமுக மொழியைத் தேர்ந்தெடுக்கவும். இயல்புநிலை மொழி ஆங்கிலம். நீங்கள் சேமித்த பதிவுகளின் உரை மொழிபெயர்க்கப்படாது.';

  @override
  String get categories => 'வகைகள்';

  @override
  String get addCategory => 'வகையைச் சேர்க்கவும்';

  @override
  String get renameCategory => 'வகையின் பெயரை மாற்றவும்';

  @override
  String get deleteCategory => 'வகையை நீக்கவும்';

  @override
  String get categoryInUse =>
      'ஒரு உத்தரவாதம் இந்த வகையைப் பயன்படுத்துகிறது. முதலில் அந்த உத்தரவாதத்தின் வகையை மாற்றவும்.';

  @override
  String get newCategory => 'வகையின் பெயர்';

  @override
  String get categoryExists => 'அந்த வகை ஏற்கனவே உள்ளது.';

  @override
  String get categoryElectronics => 'மின்னணுப் பொருட்கள்';

  @override
  String get categoryAppliances => 'வீட்டு உபகரணங்கள்';

  @override
  String get categoryTools => 'கருவிகள்';

  @override
  String get categoryOther => 'பிற';

  @override
  String get exportReports => 'அறிக்கைகள்';

  @override
  String get about => 'Kepli பற்றி';

  @override
  String get privacyTitle => 'உள்ளூரில். தனிப்பட்டது. உங்களுடையது.';

  @override
  String get privacyBody =>
      'கணக்கு, சந்தா, பயன்பாட்டுப் பகுப்பாய்வு அல்லது Kepli மேகம் எதுவும் இல்லை. நீங்கள் ஏற்றுமதி செய்யும் அல்லது பகிரும் வரை உங்கள் பதிவுகள் இந்தச் செயலியின் சேமிப்பகத்திலேயே இருக்கும். தவறாமல் காப்புப்பிரதிகளை ஏற்றுமதி செய்யவும்: செயலியை நிறுவல் நீக்குவது அல்லது சாதனத்தை இழப்பது உங்கள் தரவை அழிக்கக்கூடும்.';

  @override
  String get appVersion => 'பதிப்பு';

  @override
  String get operationFailed => 'செயலை முடிக்க முடியவில்லை.';

  @override
  String get technicalDetails => 'தொழில்நுட்ப விவரங்கள்';

  @override
  String get saved => 'உத்தரவாதம் இந்தச் சாதனத்தில் சேமிக்கப்பட்டது.';

  @override
  String get deleted => 'உத்தரவாதமும் அதன் இணைப்புகளும் நீக்கப்பட்டன.';

  @override
  String get restored =>
      'காப்புப்பிரதி மீட்டமைக்கப்பட்டது. குறிப்பிடப்பட்ட அனைத்து இணைப்புகளும் சரிபார்க்கப்பட்டன.';

  @override
  String get settingsSaved => 'அமைப்புகள் சேமிக்கப்பட்டன.';

  @override
  String get exportReady => 'ஏற்றுமதி தயாராக உள்ளது.';

  @override
  String get exportCancelled => 'ஏற்றுமதி ரத்துசெய்யப்பட்டது.';

  @override
  String fileSavedTo(String path) {
    return 'கோப்பு $path-இல் சேமிக்கப்பட்டது';
  }

  @override
  String get shareOpened =>
      'பகிர்வுப் பலகையில் கோப்பை எங்கே சேமிக்க அல்லது அனுப்ப வேண்டும் என்பதைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get loading => 'ஏற்றுகிறது';

  @override
  String get retry => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get startupError =>
      'Kepli உங்கள் உள்ளூர் தரவைத் திறக்க முடியவில்லை. ஏற்கனவே உள்ள உங்கள் கோப்புகள் மீட்டமைக்கப்படவில்லை.';

  @override
  String get unavailableImage =>
      'படத்தின் முன்னோட்டம் கிடைக்கவில்லை. அசல் கோப்பை நீங்கள் இன்னும் திறக்கலாம்.';

  @override
  String get largeAttachmentTitle => 'பெரிய இணைப்பு';

  @override
  String largeAttachmentWarning(String size) {
    return 'இந்தக் கோப்பின் அளவு $size MB. பெரிய இணைப்புகளால் காப்புப்பிரதிகள் மெதுவாக உருவாகும்; அதிக சேமிப்பிடமும் தேவைப்படும்.';
  }

  @override
  String get continueAction => 'தொடரவும்';

  @override
  String get recoverPhoto => 'மீட்கப்பட்ட புகைப்படத்தைப் பயன்படுத்தவும்';

  @override
  String get recoveredPhotoHelp =>
      'கேமரா காரணமாகச் செயலி மறுதொடக்கம் செய்யப்பட்ட பிறகு ஒரு புகைப்படம் மீட்கப்பட்டது. அதை இழக்காமல் இருக்க ஓர் உத்தரவாதத்தில் சேர்க்கவும்.';

  @override
  String get dismiss => 'புறக்கணிக்கவும்';

  @override
  String get busy => 'செயல் நடைபெற்றுக் கொண்டிருக்கிறது. காத்திருக்கவும்.';

  @override
  String get menu => 'பட்டி';

  @override
  String get sortHint => 'முதலில் காலாவதியாகும் வரிசையில்';

  @override
  String get requiredFields =>
      'பெயர், வகை, வாங்கிய தேதி மற்றும் உத்தரவாதக் காலம் கட்டாயமானவை.';

  @override
  String get chooseDate => 'வாங்கிய தேதியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get selected => 'தேர்ந்தெடுக்கப்பட்டது';

  @override
  String get notSet => 'அமைக்கப்படவில்லை';

  @override
  String get reportTitle => 'உத்தரவாத அறிக்கை';

  @override
  String get pdfReferences =>
      'PDF ரசீதுகளும் உத்தரவாத ஆவணங்களும் கோப்புப் பெயரால் பட்டியலிடப்பட்டுள்ளன. தேவைப்படும்போது அவற்றின் அசல் கோப்புகளைத் தனியாகப் பகிரவும்.';

  @override
  String get documentFooter =>
      'Kepli மூலம் சாதனத்திலேயே உருவாக்கப்பட்டது. இந்த அறிக்கை மீட்டமைக்கக்கூடிய காப்புப்பிரதி அல்ல.';

  @override
  String get notificationTitle => 'உத்தரவாதம் காலாவதியாகிறது';

  @override
  String notificationBody(String name, String date) {
    return '$name: உத்தரவாதம் $date அன்று காலாவதியாகிறது.';
  }

  @override
  String get contacts => 'விற்பனை மற்றும் சேவைத் தொடர்புகள்';

  @override
  String get addContact => 'தொடர்பைச் சேர்க்கவும்';

  @override
  String get editContact => 'தொடர்பைத் திருத்தவும்';

  @override
  String get removeContact => 'தொடர்பை அகற்றவும்';

  @override
  String get salesContact => 'விற்பனை';

  @override
  String get serviceContact => 'சேவை';

  @override
  String get contactName => 'தொடர்புகொள்ள வேண்டிய நபர்';

  @override
  String get organization => 'நிறுவனம் அல்லது அமைப்பு';

  @override
  String get phone => 'தொலைபேசி';

  @override
  String get email => 'மின்னஞ்சல்';

  @override
  String get contactNotes => 'தொடர்புக் குறிப்புகள்';

  @override
  String get noContacts => 'தொடர்புகள் சேர்க்கப்படவில்லை';

  @override
  String get businessCard => 'வணிக அட்டை';

  @override
  String get scanBusinessCard => 'வணிக அட்டையை ஸ்கேன் செய்யவும்';

  @override
  String get addBusinessCard => 'வணிக அட்டையைச் சேர்க்கவும்';

  @override
  String get businessCardHelp =>
      'அட்டையைப் புகைப்படம் எடுக்கவும் அல்லது இறக்குமதி செய்து இந்தத் தொடர்புடன் இணைக்கவும். நபரின் விவரங்களைக் கீழே உள்ளிடவும்; Kepli மேக அடிப்படையிலான எழுத்துணர்வைப் பயன்படுத்துவதில்லை.';

  @override
  String get businessCardNeedsContact =>
      'வணிக அட்டையை இணைக்கும் முன் தொடர்பின் பெயரைச் சேமிக்கவும்.';

  @override
  String get scanDocument => 'ஆவணத்தை ஸ்கேன் செய்யவும்';

  @override
  String get scanHelp =>
      'பக்கங்களைப் புகைப்படம் எடுக்கவும் அல்லது படங்களைத் தேர்ந்தெடுக்கவும். பின்னர் வெட்டி, சுழற்றி, ஒரே PDF ஆகச் சேமிக்கவும். செயலாக்கம் இந்தச் சாதனத்திலேயே நடைபெறும்; உரை தானாகப் பிரித்தெடுக்கப்படாது.';

  @override
  String get addPage => 'பக்கத்தைச் சேர்க்கவும்';

  @override
  String get removePage => 'பக்கத்தை அகற்றவும்';

  @override
  String get rotatePage => 'பக்கத்தைச் சுழற்றவும்';

  @override
  String pageNumber(int number) {
    return 'பக்கம் $number';
  }

  @override
  String get cropTop => 'மேலிருந்து வெட்டவும்';

  @override
  String get cropBottom => 'கீழிருந்து வெட்டவும்';

  @override
  String get cropLeft => 'இடப்புறத்திலிருந்து வெட்டவும்';

  @override
  String get cropRight => 'வலப்புறத்திலிருந்து வெட்டவும்';

  @override
  String get enhanceDocument => 'ஆவணத்தின் நிற வேறுபாட்டை மேம்படுத்தவும்';

  @override
  String get saveScan => 'ஸ்கேனை PDF ஆகச் சேமிக்கவும்';

  @override
  String get scanName => 'ஆவணத்தின் பெயர்';

  @override
  String get noPages => 'குறைந்தது ஒரு பக்கத்தையாவது சேர்க்கவும்.';

  @override
  String get desktopScanHelp =>
      'உங்கள் ஸ்கேனர் அல்லது கேமரா சேமித்த படங்களைத் தேர்ந்தெடுக்கவும். ஸ்கேனர் வன்பொருளை நேரடியாகக் கட்டுப்படுத்த வேண்டியதில்லை.';

  @override
  String get attachmentType => 'இணைப்பின் வகை';

  @override
  String get previousPage => 'முந்தைய பக்கம்';

  @override
  String get nextPage => 'அடுத்த பக்கம்';

  @override
  String get processingDocument => 'இந்தச் சாதனத்தில் ஆவணம் செயலாக்கப்படுகிறது';

  @override
  String get readOnlyDetails => 'உத்தரவாத விவரங்கள்';

  @override
  String get selectWarranty =>
      'விவரங்களைப் பார்க்க ஓர் உத்தரவாதத்தைத் தேர்ந்தெடுக்கவும்.';
}
