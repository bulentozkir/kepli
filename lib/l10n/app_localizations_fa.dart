// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'گارانتی‌های شما. رسیدهای شما. متعلق به شما.';

  @override
  String get warranties => 'گارانتی‌ها';

  @override
  String get backups => 'نسخه‌های پشتیبان';

  @override
  String get settings => 'تنظیمات';

  @override
  String get addWarranty => 'افزودن گارانتی';

  @override
  String get editWarranty => 'ویرایش گارانتی';

  @override
  String get save => 'ذخیره';

  @override
  String get cancel => 'لغو';

  @override
  String get delete => 'حذف';

  @override
  String get close => 'بستن';

  @override
  String get edit => 'ویرایش';

  @override
  String get searchHint => 'جستجوی نام، فروشگاه یا دسته';

  @override
  String get all => 'همه';

  @override
  String get active => 'معتبر';

  @override
  String get expiringSoon => 'رو به انقضا';

  @override
  String get expired => 'منقضی‌شده';

  @override
  String get claimed => 'درخواست ثبت‌شده';

  @override
  String get status => 'وضعیت';

  @override
  String get noWarranties => 'هنوز گارانتی‌ای ندارید';

  @override
  String get getStarted =>
      'یک خرید اضافه کنید و رسید، مدارک گارانتی و مخاطبان آن را کنار هم نگه دارید.';

  @override
  String get noMatches => 'گارانتی مطابقی پیدا نشد';

  @override
  String get clearFilters => 'پاک کردن فیلترها';

  @override
  String get purchaseDate => 'تاریخ خرید';

  @override
  String get expiryDate => 'تاریخ انقضا';

  @override
  String get warrantyLength => 'مدت گارانتی';

  @override
  String get months => 'ماه';

  @override
  String get years => 'سال';

  @override
  String get customDuration => 'مدت دلخواه';

  @override
  String get name => 'نام';

  @override
  String get nameHint => 'برای مثال، یخچال آشپزخانه';

  @override
  String get category => 'دسته';

  @override
  String get vendor => 'فروشگاه یا فروشنده';

  @override
  String get price => 'قیمت (اختیاری)';

  @override
  String get currency => 'کد ارز';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get productPhoto => 'عکس محصول';

  @override
  String get receipt => 'رسید';

  @override
  String get warrantyPaper => 'برگه گارانتی';

  @override
  String get attachments => 'پیوست‌ها';

  @override
  String get addFiles => 'افزودن فایل';

  @override
  String get takePhoto => 'گرفتن عکس';

  @override
  String get choosePhoto => 'انتخاب عکس‌ها';

  @override
  String get removeAttachment => 'برداشتن پیوست';

  @override
  String get openAttachment => 'باز کردن پیوست';

  @override
  String get markClaimed => 'علامت‌گذاری به‌عنوان درخواست ثبت‌شده';

  @override
  String get markActive => 'پاک کردن وضعیت درخواست گارانتی';

  @override
  String get exportPdf => 'خروجی PDF گارانتی';

  @override
  String get deleteWarranty => 'گارانتی حذف شود؟';

  @override
  String deleteWarrantyWarning(String name) {
    return 'آیا $name و همه پیوست‌های آن از این دستگاه حذف شوند؟ این کار قابل بازگشت نیست.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count روز باقی مانده',
      one: '1 روز باقی مانده',
      zero: 'امروز منقضی می‌شود',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count گارانتی',
      one: '1 گارانتی',
      zero: 'بدون گارانتی',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'پر کردن این فیلد الزامی است.';

  @override
  String get invalidDuration => 'مدتی بین 1 تا 1,200 ماه وارد کنید.';

  @override
  String get invalidPrice => 'مبلغی با حداکثر دو رقم اعشار وارد کنید.';

  @override
  String get invalidCurrency => 'کد سه‌حرفی ارز را وارد کنید، مانند USD.';

  @override
  String get invalidEmail => 'یک نشانی ایمیل معتبر وارد کنید.';

  @override
  String get discardChanges => 'تغییرات ذخیره‌نشده کنار گذاشته شوند؟';

  @override
  String get discard => 'کنار گذاشتن';

  @override
  String get keepEditing => 'ادامه ویرایش';

  @override
  String get restoreBackup => 'بازیابی نسخه پشتیبان';

  @override
  String get exportBackup => 'خروجی گرفتن از نسخه پشتیبان';

  @override
  String get exportCsv => 'خروجی CSV';

  @override
  String get backupExplanation =>
      'یک فایل ZIP شامل گارانتی‌ها، مخاطبان، ترجیحات و پیوست‌های اصلی شماست. آن را به دستگاه دیگری منتقل و در آنجا بازیابی کنید. این انتقال دستی است، نه همگام‌سازی خودکار.';

  @override
  String get backupPrivacy =>
      'نسخه‌های پشتیبان رمزگذاری نمی‌شوند. آن‌ها را در جای امنی نگه دارید. Kepli سرویس ابری ندارد؛ مقصدهایی که در پنل اشتراک‌گذاری سیستم انتخاب می‌کنید در اختیار شما هستند.';

  @override
  String get chooseBackup => 'انتخاب فایل پشتیبان';

  @override
  String get backupPreview => 'بررسی نسخه پشتیبان';

  @override
  String get newWarranties => 'گارانتی‌های جدید';

  @override
  String backupSummary(int items, int files) {
    return '$items گارانتی و $files پیوست';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'خروجی گرفته‌شده در $date روی $platform';
  }

  @override
  String get merge => 'ادغام';

  @override
  String get mergeHelp =>
      'گارانتی‌های جدید را اضافه کنید و برای گارانتی‌های منطبق، نسخه جدیدتر را نگه دارید. ترجیحات فعلی حفظ می‌شوند.';

  @override
  String get replaceAll => 'جایگزینی همه';

  @override
  String get replaceHelp =>
      'گارانتی‌ها و ترجیحات این دستگاه را با نسخه پشتیبان جایگزین کنید.';

  @override
  String replaceConfirmation(int count) {
    return 'آیا همه $count گارانتی این دستگاه برای همیشه جایگزین شوند؟ اگر می‌خواهید آن‌ها را نگه دارید، ابتدا از آن‌ها نسخه پشتیبان بگیرید.';
  }

  @override
  String get confirmReplace => 'جایگزینی همه گارانتی‌ها';

  @override
  String get conflicts => 'گارانتی‌های منطبق';

  @override
  String get keepLocal => 'نگه داشتن نسخه این دستگاه';

  @override
  String get useBackup => 'استفاده از نسخه جدیدتر پشتیبان';

  @override
  String get newerWinsHelp =>
      'معمولاً نسخه‌ای که دیرتر به‌روز شده است حفظ می‌شود. اگر زمان‌ها یکسان باشند، نسخه این دستگاه باقی می‌ماند. برای نگه داشتن نسخه محلی به‌جای آن، گارانتی‌های موردنظر را در پایین انتخاب کنید.';

  @override
  String get restore => 'بازیابی';

  @override
  String get notifications => 'یادآورها';

  @override
  String get enableReminders => 'فعال کردن یادآورهای انقضا';

  @override
  String get reminderDays => 'روزهای پیش از انقضا';

  @override
  String get reminderDaysHelp =>
      'مقادیر را با ویرگول جدا کنید، برای مثال 30, 7, 1. برای خود تاریخ انقضا از 0 استفاده کنید.';

  @override
  String get invalidReminderDays =>
      'بین 1 تا 12 مقدار متفاوت وارد کنید؛ هر مقدار باید بین 0 تا 3,650 روز باشد.';

  @override
  String get reminderHour => 'ساعت یادآوری (0–23)';

  @override
  String get invalidReminderHour => 'ساعتی بین 0 تا 23 وارد کنید.';

  @override
  String get reminderLimit =>
      'فقط نزدیک‌ترین یادآورها در صف سیستم‌عامل جا می‌گیرند. Kepli را مرتب باز کنید تا یادآورهای بعدی به صف اضافه شوند.';

  @override
  String get notificationPrivacy =>
      'یادآورها روی دستگاه زمان‌بندی می‌شوند. مجوزها، تنظیمات باتری و سیستم‌عامل ممکن است آن‌ها را به تأخیر بیندازند یا مانع آن‌ها شوند. فهرست گارانتی‌های رو به انقضا همیشه در دسترس است.';

  @override
  String get permissionRequired => 'مجوز اعلان‌ها لازم است.';

  @override
  String get requestPermission => 'درخواست مجوز';

  @override
  String get remindersOff => 'یادآورها خاموش هستند.';

  @override
  String get remindersUnavailable =>
      'یادآورهای سیستم در دسترس نیستند. از فهرست گارانتی‌های رو به انقضا استفاده کنید.';

  @override
  String remindersScheduled(int count) {
    return '$count یادآور زمان‌بندی شد.';
  }

  @override
  String get linuxReminderHelp =>
      'در Linux یادآورها فقط زمانی کار می‌کنند که Kepli باز باشد و سرویس اعلان در دسترس باشد.';

  @override
  String get accessibility => 'دسترس‌پذیری';

  @override
  String get highContrast => 'افزایش کنتراست';

  @override
  String get reduceMotion => 'کاهش حرکت';

  @override
  String get accessibilityHelp =>
      'Kepli از تنظیمات سیستم شما برای اندازه متن، صفحه‌خوان، کنتراست و کاهش حرکت نیز پیروی می‌کند. همه کارها بدون حرکات لمسی قابل انجام هستند.';

  @override
  String get language => 'زبان';

  @override
  String get languageHelp =>
      'زبان رابط کاربری را انتخاب کنید. زبان پیش‌فرض انگلیسی است. متن موارد ذخیره‌شده شما ترجمه نمی‌شود.';

  @override
  String get categories => 'دسته‌ها';

  @override
  String get addCategory => 'افزودن دسته';

  @override
  String get renameCategory => 'تغییر نام دسته';

  @override
  String get deleteCategory => 'حذف دسته';

  @override
  String get categoryInUse =>
      'یک گارانتی از این دسته استفاده می‌کند. ابتدا دسته آن گارانتی را تغییر دهید.';

  @override
  String get newCategory => 'نام دسته';

  @override
  String get categoryExists => 'این دسته از قبل وجود دارد.';

  @override
  String get categoryElectronics => 'وسایل الکترونیکی';

  @override
  String get categoryAppliances => 'لوازم خانگی';

  @override
  String get categoryTools => 'ابزار';

  @override
  String get categoryOther => 'سایر';

  @override
  String get exportReports => 'گزارش‌ها';

  @override
  String get about => 'درباره Kepli';

  @override
  String get privacyTitle => 'محلی. خصوصی. متعلق به شما.';

  @override
  String get privacyBody =>
      'بدون حساب کاربری، اشتراک، تحلیل استفاده یا ابر Kepli. سوابق شما در فضای ذخیره‌سازی این برنامه می‌مانند تا زمانی که از آن‌ها خروجی بگیرید یا به اشتراک بگذارید. مرتب نسخه پشتیبان بگیرید: حذف برنامه یا گم شدن دستگاه می‌تواند باعث از بین رفتن داده‌های شما شود.';

  @override
  String get appVersion => 'نسخه';

  @override
  String get operationFailed => 'عملیات تکمیل نشد.';

  @override
  String get technicalDetails => 'جزئیات فنی';

  @override
  String get saved => 'گارانتی روی این دستگاه ذخیره شد.';

  @override
  String get deleted => 'گارانتی و پیوست‌های آن حذف شدند.';

  @override
  String get restored =>
      'نسخه پشتیبان بازیابی شد. همه پیوست‌های ارجاع‌شده بررسی و تأیید شدند.';

  @override
  String get settingsSaved => 'تنظیمات ذخیره شد.';

  @override
  String get exportReady => 'خروجی آماده است.';

  @override
  String get exportCancelled => 'خروجی گرفتن لغو شد.';

  @override
  String fileSavedTo(String path) {
    return 'فایل در $path ذخیره شد';
  }

  @override
  String get shareOpened =>
      'در پنل اشتراک‌گذاری انتخاب کنید که فایل کجا ذخیره یا ارسال شود.';

  @override
  String get loading => 'در حال بارگیری';

  @override
  String get retry => 'تلاش دوباره';

  @override
  String get startupError =>
      'Kepli نتوانست داده‌های محلی شما را باز کند. فایل‌های موجود شما بازنشانی نشده‌اند.';

  @override
  String get unavailableImage =>
      'پیش‌نمایش تصویر در دسترس نیست. همچنان می‌توانید فایل اصلی را باز کنید.';

  @override
  String get largeAttachmentTitle => 'پیوست بزرگ';

  @override
  String largeAttachmentWarning(String size) {
    return 'حجم این فایل $size مگابایت است. پیوست‌های بزرگ تهیه نسخه پشتیبان را کند می‌کنند و فضای بیشتری می‌گیرند.';
  }

  @override
  String get continueAction => 'ادامه';

  @override
  String get recoverPhoto => 'استفاده از عکس بازیابی‌شده';

  @override
  String get recoveredPhotoHelp =>
      'پس از آنکه دوربین باعث راه‌اندازی دوباره برنامه شد، عکسی بازیابی شد. آن را به یک گارانتی اضافه کنید تا از دست نرود.';

  @override
  String get dismiss => 'نادیده گرفتن';

  @override
  String get busy => 'عملیات در حال انجام است. لطفاً صبر کنید.';

  @override
  String get menu => 'منو';

  @override
  String get sortHint => 'مرتب‌شده بر اساس نزدیک‌ترین تاریخ انقضا';

  @override
  String get requiredFields =>
      'نام، دسته، تاریخ خرید و مدت گارانتی الزامی هستند.';

  @override
  String get chooseDate => 'انتخاب تاریخ خرید';

  @override
  String get selected => 'انتخاب‌شده';

  @override
  String get notSet => 'تنظیم نشده';

  @override
  String get reportTitle => 'گزارش گارانتی';

  @override
  String get pdfReferences =>
      'رسیدهای PDF و مدارک گارانتی با نام فایل فهرست می‌شوند. در صورت نیاز، فایل‌های اصلی آن‌ها را جداگانه به اشتراک بگذارید.';

  @override
  String get documentFooter =>
      'به‌صورت محلی توسط Kepli تولید شده است. این گزارش نسخه پشتیبان قابل بازیابی نیست.';

  @override
  String get notificationTitle => 'گارانتی رو به انقضا';

  @override
  String notificationBody(String name, String date) {
    return '$name: گارانتی در $date منقضی می‌شود.';
  }

  @override
  String get contacts => 'مخاطبان فروش و خدمات';

  @override
  String get addContact => 'افزودن مخاطب';

  @override
  String get editContact => 'ویرایش مخاطب';

  @override
  String get removeContact => 'حذف مخاطب';

  @override
  String get salesContact => 'فروش';

  @override
  String get serviceContact => 'خدمات';

  @override
  String get contactName => 'شخص رابط';

  @override
  String get organization => 'شرکت یا سازمان';

  @override
  String get phone => 'تلفن';

  @override
  String get email => 'ایمیل';

  @override
  String get contactNotes => 'یادداشت‌های مخاطب';

  @override
  String get noContacts => 'مخاطبی اضافه نشده است';

  @override
  String get businessCard => 'کارت ویزیت';

  @override
  String get scanBusinessCard => 'اسکن کارت ویزیت';

  @override
  String get addBusinessCard => 'افزودن کارت ویزیت';

  @override
  String get businessCardHelp =>
      'از کارت عکس بگیرید یا آن را وارد کنید و به این مخاطب پیوست کنید. مشخصات شخص را در پایین وارد کنید؛ Kepli از تشخیص متن ابری استفاده نمی‌کند.';

  @override
  String get businessCardNeedsContact =>
      'پیش از پیوست کردن کارت ویزیت، نام مخاطب را ذخیره کنید.';

  @override
  String get scanDocument => 'اسکن سند';

  @override
  String get scanHelp =>
      'از صفحه‌ها عکس بگیرید یا تصویر انتخاب کنید، سپس آن‌ها را برش دهید، بچرخانید و در یک PDF ذخیره کنید. پردازش روی همین دستگاه انجام می‌شود؛ متن به‌طور خودکار استخراج نمی‌شود.';

  @override
  String get addPage => 'افزودن صفحه';

  @override
  String get removePage => 'حذف صفحه';

  @override
  String get rotatePage => 'چرخاندن صفحه';

  @override
  String pageNumber(int number) {
    return 'صفحه $number';
  }

  @override
  String get cropTop => 'برش از بالا';

  @override
  String get cropBottom => 'برش از پایین';

  @override
  String get cropLeft => 'برش از چپ';

  @override
  String get cropRight => 'برش از راست';

  @override
  String get enhanceDocument => 'بهبود کنتراست سند';

  @override
  String get saveScan => 'ذخیره اسکن به‌صورت PDF';

  @override
  String get scanName => 'نام سند';

  @override
  String get noPages => 'دست‌کم یک صفحه اضافه کنید.';

  @override
  String get desktopScanHelp =>
      'تصاویر ذخیره‌شده توسط اسکنر یا دوربین خود را انتخاب کنید. نیازی به کنترل مستقیم سخت‌افزار اسکنر نیست.';

  @override
  String get attachmentType => 'نوع پیوست';

  @override
  String get previousPage => 'صفحه قبل';

  @override
  String get nextPage => 'صفحه بعد';

  @override
  String get processingDocument => 'در حال پردازش سند روی این دستگاه';

  @override
  String get readOnlyDetails => 'جزئیات گارانتی';

  @override
  String get selectWarranty => 'برای دیدن جزئیات، یک گارانتی انتخاب کنید.';
}
