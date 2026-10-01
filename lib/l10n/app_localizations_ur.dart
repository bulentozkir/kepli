// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'آپ کی وارنٹیاں۔ آپ کی رسیدیں۔ صرف آپ کی۔';

  @override
  String get warranties => 'وارنٹیاں';

  @override
  String get backups => 'بیک اپ';

  @override
  String get settings => 'ترتیبات';

  @override
  String get addWarranty => 'وارنٹی شامل کریں';

  @override
  String get editWarranty => 'وارنٹی میں ترمیم کریں';

  @override
  String get save => 'محفوظ کریں';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get close => 'بند کریں';

  @override
  String get edit => 'ترمیم کریں';

  @override
  String get searchHint => 'نام، دکان یا زمرہ تلاش کریں';

  @override
  String get all => 'سب';

  @override
  String get active => 'مؤثر';

  @override
  String get expiringSoon => 'جلد ختم ہونے والی';

  @override
  String get expired => 'میعاد ختم';

  @override
  String get claimed => 'دعویٰ کیا گیا';

  @override
  String get status => 'حالت';

  @override
  String get noWarranties => 'ابھی کوئی وارنٹی نہیں';

  @override
  String get getStarted =>
      'ایک خریداری شامل کریں اور اس کی رسید، وارنٹی کے کاغذات اور رابطے ایک جگہ رکھیں۔';

  @override
  String get noMatches => 'کوئی مماثل وارنٹی نہیں';

  @override
  String get clearFilters => 'فلٹر ہٹائیں';

  @override
  String get purchaseDate => 'خریداری کی تاریخ';

  @override
  String get expiryDate => 'میعاد ختم ہونے کی تاریخ';

  @override
  String get warrantyLength => 'وارنٹی کی مدت';

  @override
  String get months => 'مہینے';

  @override
  String get years => 'سال';

  @override
  String get customDuration => 'اپنی مرضی کی مدت';

  @override
  String get name => 'نام';

  @override
  String get nameHint => 'مثلاً، باورچی خانے کا فریج';

  @override
  String get category => 'زمرہ';

  @override
  String get vendor => 'دکان یا فروخت کنندہ';

  @override
  String get price => 'قیمت (اختیاری)';

  @override
  String get currency => 'کرنسی کا کوڈ';

  @override
  String get notes => 'نوٹس';

  @override
  String get productPhoto => 'مصنوعات کی تصویر';

  @override
  String get receipt => 'رسید';

  @override
  String get warrantyPaper => 'وارنٹی کی دستاویز';

  @override
  String get attachments => 'منسلکات';

  @override
  String get addFiles => 'فائلیں شامل کریں';

  @override
  String get takePhoto => 'تصویر لیں';

  @override
  String get choosePhoto => 'تصاویر منتخب کریں';

  @override
  String get removeAttachment => 'منسلکہ ہٹائیں';

  @override
  String get openAttachment => 'منسلکہ کھولیں';

  @override
  String get markClaimed => 'دعویٰ کیا گیا کا نشان لگائیں';

  @override
  String get markActive => 'دعویٰ کیے جانے کا نشان ہٹائیں';

  @override
  String get exportPdf => 'وارنٹی کی PDF برآمد کریں';

  @override
  String get deleteWarranty => 'وارنٹی حذف کریں؟';

  @override
  String deleteWarrantyWarning(String name) {
    return 'کیا اس آلے سے $name اور اس کے تمام منسلکات حذف کر دیں؟ یہ عمل واپس نہیں کیا جا سکتا۔';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دن باقی',
      one: '1 دن باقی',
      zero: 'آج میعاد ختم ہو رہی ہے',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count وارنٹیاں',
      one: '1 وارنٹی',
      zero: 'کوئی وارنٹی نہیں',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'یہ خانہ بھرنا ضروری ہے۔';

  @override
  String get invalidDuration => '1 سے 1,200 ماہ درج کریں۔';

  @override
  String get invalidPrice =>
      'اعشاریے کے بعد زیادہ سے زیادہ دو ہندسوں والی رقم درج کریں۔';

  @override
  String get invalidCurrency => 'تین حروف کا کرنسی کوڈ درج کریں، مثلاً USD۔';

  @override
  String get invalidEmail => 'درست ای میل پتہ درج کریں۔';

  @override
  String get discardChanges => 'غیر محفوظ تبدیلیاں ترک کر دیں؟';

  @override
  String get discard => 'ترک کریں';

  @override
  String get keepEditing => 'ترمیم جاری رکھیں';

  @override
  String get restoreBackup => 'بیک اپ بحال کریں';

  @override
  String get exportBackup => 'بیک اپ برآمد کریں';

  @override
  String get exportCsv => 'CSV برآمد کریں';

  @override
  String get backupExplanation =>
      'ایک ZIP فائل میں آپ کی وارنٹیاں، رابطے، ترجیحات اور اصل منسلکات ہوتے ہیں۔ اسے دوسرے آلے پر منتقل کر کے وہاں بحال کریں۔ یہ دستی منتقلی ہے، خودکار ہم وقت سازی نہیں۔';

  @override
  String get backupPrivacy =>
      'بیک اپ رمز بند نہیں ہوتے۔ انہیں محفوظ جگہ رکھیں۔ Kepli کی کوئی کلاؤڈ سروس نہیں؛ سسٹم کے شیئر پینل میں منتخب کردہ منزلیں آپ کے اختیار میں ہیں۔';

  @override
  String get chooseBackup => 'بیک اپ فائل منتخب کریں';

  @override
  String get backupPreview => 'بیک اپ کا جائزہ لیں';

  @override
  String get newWarranties => 'نئی وارنٹیاں';

  @override
  String backupSummary(int items, int files) {
    return '$items وارنٹیاں اور $files منسلکات';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date کو $platform پر برآمد کیا گیا';
  }

  @override
  String get merge => 'ضم کریں';

  @override
  String get mergeHelp =>
      'نئی وارنٹیاں شامل کریں اور مماثل وارنٹیوں کا زیادہ نیا نسخہ رکھیں۔ موجودہ ترجیحات برقرار رہیں گی۔';

  @override
  String get replaceAll => 'سب بدلیں';

  @override
  String get replaceHelp => 'اس آلے کی وارنٹیاں اور ترجیحات بیک اپ سے بدل دیں۔';

  @override
  String replaceConfirmation(int count) {
    return 'کیا اس آلے کی تمام $count وارنٹیاں مستقل طور پر بدل دیں؟ انہیں رکھنا ہو تو پہلے بیک اپ برآمد کریں۔';
  }

  @override
  String get confirmReplace => 'تمام وارنٹیاں بدلیں';

  @override
  String get conflicts => 'مماثل وارنٹیاں';

  @override
  String get keepLocal => 'اس آلے کا نسخہ رکھیں';

  @override
  String get useBackup => 'بیک اپ کا زیادہ نیا نسخہ استعمال کریں';

  @override
  String get newerWinsHelp =>
      'عموماً زیادہ حالیہ تبدیلی والا نسخہ رکھا جاتا ہے۔ وقت کے نشانات برابر ہوں تو اس آلے کا نسخہ رہتا ہے۔ اس کے بجائے مقامی نسخہ رکھنے کے لیے نیچے وارنٹیاں منتخب کریں۔';

  @override
  String get restore => 'بحال کریں';

  @override
  String get notifications => 'یاددہانیاں';

  @override
  String get enableReminders => 'میعاد ختم ہونے کی یاددہانیاں فعال کریں';

  @override
  String get reminderDays => 'میعاد ختم ہونے سے پہلے کے دن';

  @override
  String get reminderDaysHelp =>
      'اعداد کو کوما سے الگ کریں، مثلاً 30, 7, 1۔ میعاد ختم ہونے کی تاریخ کے لیے 0 استعمال کریں۔';

  @override
  String get invalidReminderDays =>
      '1 سے 12 مختلف اعداد درج کریں، ہر عدد 0 سے 3,650 دنوں کے درمیان ہو۔';

  @override
  String get reminderHour => 'یاددہانی کا گھنٹہ (0–23)';

  @override
  String get invalidReminderHour => '0 سے 23 کے درمیان گھنٹہ درج کریں۔';

  @override
  String get reminderLimit =>
      'آپریٹنگ سسٹم کی قطار میں صرف قریب ترین یاددہانیاں سما سکتی ہیں۔ اگلی یاددہانیاں شامل کرنے کے لیے Kepli باقاعدگی سے کھولیں۔';

  @override
  String get notificationPrivacy =>
      'یاددہانیاں مقامی طور پر مقرر ہوتی ہیں۔ اجازتیں، بیٹری کی ترتیبات اور آپریٹنگ سسٹم انہیں مؤخر یا بند کر سکتے ہیں۔ جلد ختم ہونے والی وارنٹیوں کی فہرست ہمیشہ دستیاب ہے۔';

  @override
  String get permissionRequired => 'اطلاعات کی اجازت درکار ہے۔';

  @override
  String get requestPermission => 'اجازت طلب کریں';

  @override
  String get remindersOff => 'یاددہانیاں بند ہیں۔';

  @override
  String get remindersUnavailable =>
      'سسٹم کی یاددہانیاں دستیاب نہیں۔ جلد ختم ہونے والی وارنٹیوں کی فہرست استعمال کریں۔';

  @override
  String remindersScheduled(int count) {
    return '$count یاددہانیاں مقرر کر دی گئیں۔';
  }

  @override
  String get linuxReminderHelp =>
      'Linux پر یاددہانیاں صرف اسی وقت کام کرتی ہیں جب Kepli کھلا ہو اور اطلاعات کی سروس دستیاب ہو۔';

  @override
  String get accessibility => 'رسائی پذیری';

  @override
  String get highContrast => 'رنگوں کا تضاد بڑھائیں';

  @override
  String get reduceMotion => 'حرکت کم کریں';

  @override
  String get accessibilityHelp =>
      'Kepli آپ کے سسٹم کے متن کے سائز، اسکرین ریڈر، رنگوں کے تضاد اور کم حرکت کی ترتیبات کا بھی لحاظ رکھتا ہے۔ ہر کام اشاروں کے بغیر کیا جا سکتا ہے۔';

  @override
  String get language => 'زبان';

  @override
  String get languageHelp =>
      'انٹرفیس کی زبان منتخب کریں۔ طے شدہ زبان انگریزی ہے۔ آپ کے محفوظ کردہ ریکارڈ کے متن کا ترجمہ نہیں کیا جاتا۔';

  @override
  String get categories => 'زمرے';

  @override
  String get addCategory => 'زمرہ شامل کریں';

  @override
  String get renameCategory => 'زمرے کا نام بدلیں';

  @override
  String get deleteCategory => 'زمرہ حذف کریں';

  @override
  String get categoryInUse =>
      'ایک وارنٹی میں یہ زمرہ استعمال ہو رہا ہے۔ پہلے اس وارنٹی کا زمرہ بدلیں۔';

  @override
  String get newCategory => 'زمرے کا نام';

  @override
  String get categoryExists => 'یہ زمرہ پہلے سے موجود ہے۔';

  @override
  String get categoryElectronics => 'الیکٹرانک اشیا';

  @override
  String get categoryAppliances => 'گھریلو آلات';

  @override
  String get categoryTools => 'اوزار';

  @override
  String get categoryOther => 'دیگر';

  @override
  String get exportReports => 'رپورٹیں';

  @override
  String get about => 'Kepli کے بارے میں';

  @override
  String get privacyTitle => 'مقامی۔ نجی۔ آپ کا۔';

  @override
  String get privacyBody =>
      'نہ اکاؤنٹ، نہ رکنیت، نہ استعمال کا تجزیہ، نہ Kepli کلاؤڈ۔ آپ کے ریکارڈ اس ایپ کے ذخیرے میں رہتے ہیں جب تک آپ انہیں برآمد یا شیئر نہ کریں۔ باقاعدگی سے بیک اپ برآمد کریں: ایپ اَن انسٹال کرنے یا آلہ کھو جانے سے آپ کا ڈیٹا مٹ سکتا ہے۔';

  @override
  String get appVersion => 'نسخہ';

  @override
  String get operationFailed => 'عمل مکمل نہیں ہو سکا۔';

  @override
  String get technicalDetails => 'تکنیکی تفصیلات';

  @override
  String get saved => 'وارنٹی اس آلے پر محفوظ ہو گئی۔';

  @override
  String get deleted => 'وارنٹی اور اس کے منسلکات حذف کر دیے گئے۔';

  @override
  String get restored =>
      'بیک اپ بحال ہو گیا۔ تمام حوالہ دیے گئے منسلکات کی تصدیق ہو گئی۔';

  @override
  String get settingsSaved => 'ترتیبات محفوظ ہو گئیں۔';

  @override
  String get exportReady => 'برآمد تیار ہے۔';

  @override
  String get exportCancelled => 'برآمد منسوخ کر دی گئی۔';

  @override
  String fileSavedTo(String path) {
    return 'فائل $path میں محفوظ ہو گئی';
  }

  @override
  String get shareOpened =>
      'شیئر پینل میں منتخب کریں کہ فائل کہاں محفوظ کرنی یا بھیجنی ہے۔';

  @override
  String get loading => 'لوڈ ہو رہا ہے';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get startupError =>
      'Kepli آپ کا مقامی ڈیٹا نہیں کھول سکا۔ آپ کی موجودہ فائلیں ری سیٹ نہیں کی گئیں۔';

  @override
  String get unavailableImage =>
      'تصویر کا پیش منظر دستیاب نہیں۔ آپ اب بھی اصل فائل کھول سکتے ہیں۔';

  @override
  String get largeAttachmentTitle => 'بڑا منسلکہ';

  @override
  String largeAttachmentWarning(String size) {
    return 'اس فائل کا حجم $size میگابائٹ ہے۔ بڑے منسلکات بیک اپ کو سست کرتے ہیں اور زیادہ جگہ لیتے ہیں۔';
  }

  @override
  String get continueAction => 'جاری رکھیں';

  @override
  String get recoverPhoto => 'بازیافت شدہ تصویر استعمال کریں';

  @override
  String get recoveredPhotoHelp =>
      'کیمرے کی وجہ سے ایپ دوبارہ شروع ہونے کے بعد ایک تصویر بازیافت ہوئی۔ اسے کسی وارنٹی میں شامل کریں تاکہ یہ ضائع نہ ہو۔';

  @override
  String get dismiss => 'نظر انداز کریں';

  @override
  String get busy => 'عمل جاری ہے۔ براہ کرم انتظار کریں۔';

  @override
  String get menu => 'مینو';

  @override
  String get sortHint => 'سب سے جلد ختم ہونے کی ترتیب سے';

  @override
  String get requiredFields =>
      'نام، زمرہ، خریداری کی تاریخ اور وارنٹی کی مدت درکار ہیں۔';

  @override
  String get chooseDate => 'خریداری کی تاریخ منتخب کریں';

  @override
  String get selected => 'منتخب';

  @override
  String get notSet => 'مقرر نہیں';

  @override
  String get reportTitle => 'وارنٹی رپورٹ';

  @override
  String get pdfReferences =>
      'PDF رسیدیں اور وارنٹی کے کاغذات فائل کے نام سے درج ہیں۔ ضرورت پڑنے پر ان کی اصل فائلیں الگ سے شیئر کریں۔';

  @override
  String get documentFooter =>
      'Kepli نے مقامی طور پر تیار کیا۔ یہ رپورٹ بحال کیا جا سکنے والا بیک اپ نہیں ہے۔';

  @override
  String get notificationTitle => 'وارنٹی کی میعاد ختم ہو رہی ہے';

  @override
  String notificationBody(String name, String date) {
    return '$name: وارنٹی کی میعاد $date کو ختم ہو گی۔';
  }

  @override
  String get contacts => 'فروخت اور سروس کے رابطے';

  @override
  String get addContact => 'رابطہ شامل کریں';

  @override
  String get editContact => 'رابطے میں ترمیم کریں';

  @override
  String get removeContact => 'رابطہ ہٹائیں';

  @override
  String get salesContact => 'فروخت';

  @override
  String get serviceContact => 'سروس';

  @override
  String get contactName => 'رابطے کا شخص';

  @override
  String get organization => 'کمپنی یا ادارہ';

  @override
  String get phone => 'فون';

  @override
  String get email => 'ای میل';

  @override
  String get contactNotes => 'رابطے کے نوٹس';

  @override
  String get noContacts => 'کوئی رابطہ شامل نہیں کیا گیا';

  @override
  String get businessCard => 'کاروباری کارڈ';

  @override
  String get scanBusinessCard => 'کاروباری کارڈ اسکین کریں';

  @override
  String get addBusinessCard => 'کاروباری کارڈ شامل کریں';

  @override
  String get businessCardHelp =>
      'کارڈ کی تصویر لیں یا درآمد کریں اور اسے اس رابطے کے ساتھ منسلک کریں۔ نیچے شخص کی تفصیلات درج کریں؛ Kepli کلاؤڈ کے ذریعے متن کی شناخت استعمال نہیں کرتا۔';

  @override
  String get businessCardNeedsContact =>
      'کاروباری کارڈ منسلک کرنے سے پہلے رابطے کا نام محفوظ کریں۔';

  @override
  String get scanDocument => 'دستاویز اسکین کریں';

  @override
  String get scanHelp =>
      'صفحات کی تصاویر لیں یا تصاویر منتخب کریں، پھر تراشیں، گھمائیں اور ایک PDF میں محفوظ کریں۔ پراسیسنگ اسی آلے پر ہوتی ہے؛ متن خودکار طور پر اخذ نہیں کیا جاتا۔';

  @override
  String get addPage => 'صفحہ شامل کریں';

  @override
  String get removePage => 'صفحہ ہٹائیں';

  @override
  String get rotatePage => 'صفحہ گھمائیں';

  @override
  String pageNumber(int number) {
    return 'صفحہ $number';
  }

  @override
  String get cropTop => 'اوپر سے تراشیں';

  @override
  String get cropBottom => 'نیچے سے تراشیں';

  @override
  String get cropLeft => 'بائیں سے تراشیں';

  @override
  String get cropRight => 'دائیں سے تراشیں';

  @override
  String get enhanceDocument => 'دستاویز کا تضاد بڑھائیں';

  @override
  String get saveScan => 'اسکین PDF کے طور پر محفوظ کریں';

  @override
  String get scanName => 'دستاویز کا نام';

  @override
  String get noPages => 'کم از کم ایک صفحہ شامل کریں۔';

  @override
  String get desktopScanHelp =>
      'اسکینر یا کیمرے سے محفوظ کردہ تصاویر منتخب کریں۔ اسکینر کے ہارڈویئر کو براہ راست کنٹرول کرنا ضروری نہیں۔';

  @override
  String get attachmentType => 'منسلکے کی قسم';

  @override
  String get previousPage => 'پچھلا صفحہ';

  @override
  String get nextPage => 'اگلا صفحہ';

  @override
  String get processingDocument => 'اس آلے پر دستاویز کی پراسیسنگ جاری ہے';

  @override
  String get readOnlyDetails => 'وارنٹی کی تفصیلات';

  @override
  String get selectWarranty => 'تفصیلات دیکھنے کے لیے وارنٹی منتخب کریں۔';
}
