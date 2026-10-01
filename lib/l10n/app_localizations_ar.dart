// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'ضماناتك. إيصالاتك. ملكك.';

  @override
  String get warranties => 'الضمانات';

  @override
  String get backups => 'النسخ الاحتياطية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get addWarranty => 'إضافة ضمان';

  @override
  String get editWarranty => 'تعديل الضمان';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get close => 'إغلاق';

  @override
  String get edit => 'تعديل';

  @override
  String get searchHint => 'البحث بالاسم أو المتجر أو الفئة';

  @override
  String get all => 'الكل';

  @override
  String get active => 'ساري';

  @override
  String get expiringSoon => 'ينتهي قريبًا';

  @override
  String get expired => 'منتهي';

  @override
  String get claimed => 'تمت المطالبة';

  @override
  String get noWarranties => 'لا توجد ضمانات بعد';

  @override
  String get getStarted =>
      'أضف عملية شراء واحتفظ بإيصالها وأوراق ضمانها وجهات الاتصال معًا.';

  @override
  String get noMatches => 'لا توجد ضمانات مطابقة';

  @override
  String get clearFilters => 'مسح عوامل التصفية';

  @override
  String get purchaseDate => 'تاريخ الشراء';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get warrantyLength => 'مدة الضمان';

  @override
  String get months => 'أشهر';

  @override
  String get years => 'سنوات';

  @override
  String get name => 'الاسم';

  @override
  String get nameHint => 'مثلًا، ثلاجة المطبخ';

  @override
  String get category => 'الفئة';

  @override
  String get vendor => 'المتجر أو البائع';

  @override
  String get price => 'السعر (اختياري)';

  @override
  String get currency => 'رمز العملة';

  @override
  String get notes => 'ملاحظات';

  @override
  String get productPhoto => 'صورة المنتج';

  @override
  String get receipt => 'الإيصال';

  @override
  String get warrantyPaper => 'ورقة الضمان';

  @override
  String get attachments => 'المرفقات';

  @override
  String get addFiles => 'إضافة ملفات';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get choosePhoto => 'اختيار صور';

  @override
  String get removeAttachment => 'إزالة المرفق';

  @override
  String get openAttachment => 'فتح المرفق';

  @override
  String get markClaimed => 'وضع علامة تمت المطالبة';

  @override
  String get markActive => 'إزالة حالة المطالبة';

  @override
  String get exportPdf => 'تصدير الضمان بصيغة PDF';

  @override
  String get deleteWarranty => 'حذف الضمان؟';

  @override
  String deleteWarrantyWarning(String name) {
    return 'هل تريد حذف $name وجميع مرفقاته من هذا الجهاز؟ لا يمكن التراجع عن ذلك.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'الأيام المتبقية: $count',
      many: 'بقي $count يومًا',
      few: 'بقيت $count أيام',
      two: 'بقي يومان',
      one: 'بقي يوم واحد',
      zero: 'ينتهي اليوم',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'عدد الضمانات: $count',
      many: '$count ضمانًا',
      few: '$count ضمانات',
      two: 'ضمانان',
      one: 'ضمان واحد',
      zero: 'لا توجد ضمانات',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'هذا الحقل مطلوب.';

  @override
  String get invalidDuration => 'أدخل مدة من 1 إلى 1,200 شهر.';

  @override
  String get invalidPrice => 'أدخل مبلغًا لا يتجاوز منزلتين عشريتين.';

  @override
  String get invalidCurrency => 'أدخل رمز عملة من ثلاثة أحرف، مثل USD.';

  @override
  String get invalidEmail => 'أدخل عنوان بريد إلكتروني صالحًا.';

  @override
  String get discardChanges => 'تجاهل التغييرات غير المحفوظة؟';

  @override
  String get discard => 'تجاهل';

  @override
  String get keepEditing => 'متابعة التعديل';

  @override
  String get restoreBackup => 'استعادة نسخة احتياطية';

  @override
  String get exportBackup => 'تصدير نسخة احتياطية';

  @override
  String get exportCsv => 'تصدير بصيغة CSV';

  @override
  String get backupExplanation =>
      'يحتوي ملف ZIP واحد على ضماناتك وجهات اتصالك وتفضيلاتك ومرفقاتك الأصلية. انقله إلى جهاز آخر واستعده هناك. هذا نقل يدوي وليس مزامنة تلقائية.';

  @override
  String get backupPrivacy =>
      'النسخ الاحتياطية غير مشفرة. احتفظ بها في مكان آمن. لا يوفر Kepli خدمة سحابية؛ وأنت تتحكم في الوجهات التي تختارها من لوحة المشاركة في النظام.';

  @override
  String get chooseBackup => 'اختيار ملف النسخة الاحتياطية';

  @override
  String get backupPreview => 'مراجعة النسخة الاحتياطية';

  @override
  String backupSummary(int items, int files) {
    return 'الضمانات: $items، والمرفقات: $files';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'تم التصدير في $date على $platform';
  }

  @override
  String get merge => 'دمج';

  @override
  String get mergeHelp =>
      'إضافة الضمانات الجديدة والاحتفاظ بالإصدار الأحدث من الضمانات المطابقة. تبقى التفضيلات الحالية كما هي.';

  @override
  String get replaceAll => 'استبدال الكل';

  @override
  String get replaceHelp =>
      'استبدال ضمانات هذا الجهاز وتفضيلاته بمحتويات النسخة الاحتياطية.';

  @override
  String replaceConfirmation(int count) {
    return 'هل تريد استبدال جميع ضمانات هذا الجهاز، وعددها $count، نهائيًا؟ صدّر نسخة احتياطية أولًا إذا أردت الاحتفاظ بها.';
  }

  @override
  String get confirmReplace => 'استبدال جميع الضمانات';

  @override
  String get conflicts => 'الضمانات المطابقة';

  @override
  String get keepLocal => 'الاحتفاظ بإصدار هذا الجهاز';

  @override
  String get useBackup => 'استخدام الإصدار الأحدث من النسخة الاحتياطية';

  @override
  String get newerWinsHelp =>
      'تُعطى الأولوية عادةً للتحديث الأحدث. عند تساوي الطوابع الزمنية، يُحتفظ بإصدار هذا الجهاز. اختر ضمانات أدناه للاحتفاظ بإصدارها المحلي بدلًا من ذلك.';

  @override
  String get restore => 'استعادة';

  @override
  String get notifications => 'التذكيرات';

  @override
  String get enableReminders => 'تفعيل تذكيرات انتهاء الضمان';

  @override
  String get reminderDays => 'الأيام قبل الانتهاء';

  @override
  String get reminderDaysHelp =>
      'افصل القيم بفواصل، مثل 30, 7, 1. استخدم 0 لتاريخ الانتهاء نفسه.';

  @override
  String get reminderHour => 'ساعة التذكير (0–23)';

  @override
  String get reminderLimit =>
      'لا تتسع قائمة انتظار نظام التشغيل إلا لأقرب التذكيرات. افتح Kepli بانتظام لإضافة التذكيرات التالية.';

  @override
  String get notificationPrivacy =>
      'تُجدول التذكيرات محليًا. قد تتسبب الأذونات وإعدادات البطارية ونظام التشغيل في تأخيرها أو منعها. تبقى قائمة الضمانات التي تنتهي قريبًا متاحة دائمًا.';

  @override
  String get permissionRequired => 'إذن الإشعارات مطلوب.';

  @override
  String get requestPermission => 'طلب الإذن';

  @override
  String get remindersOff => 'التذكيرات معطلة.';

  @override
  String get remindersUnavailable =>
      'تذكيرات النظام غير متاحة. استخدم قائمة الضمانات التي تنتهي قريبًا.';

  @override
  String remindersScheduled(int count) {
    return 'عدد التذكيرات المجدولة: $count.';
  }

  @override
  String get linuxReminderHelp =>
      'على Linux، لا تعمل التذكيرات إلا عندما يكون Kepli مفتوحًا وتكون خدمة الإشعارات متاحة.';

  @override
  String get accessibility => 'إمكانية الوصول';

  @override
  String get highContrast => 'زيادة التباين';

  @override
  String get reduceMotion => 'تقليل الحركة';

  @override
  String get accessibilityHelp =>
      'يراعي Kepli أيضًا إعدادات النظام لحجم النص وقارئ الشاشة والتباين وتقليل الحركة. يمكن تنفيذ كل إجراء دون إيماءات.';

  @override
  String get language => 'اللغة';

  @override
  String get languageHelp =>
      'اختر لغة الواجهة. الإنجليزية هي اللغة الافتراضية. لا تُترجم النصوص المحفوظة في سجلاتك.';

  @override
  String get categories => 'الفئات';

  @override
  String get addCategory => 'إضافة فئة';

  @override
  String get renameCategory => 'إعادة تسمية الفئة';

  @override
  String get deleteCategory => 'حذف الفئة';

  @override
  String get categoryInUse =>
      'يستخدم أحد الضمانات هذه الفئة. غيّر فئة ذلك الضمان أولًا.';

  @override
  String get newCategory => 'اسم الفئة';

  @override
  String get categoryExists => 'هذه الفئة موجودة بالفعل.';

  @override
  String get categoryElectronics => 'إلكترونيات';

  @override
  String get categoryAppliances => 'أجهزة منزلية';

  @override
  String get categoryTools => 'أدوات';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get exportReports => 'التقارير';

  @override
  String get about => 'حول Kepli';

  @override
  String get privacyTitle => 'محلي. خاص. ملكك.';

  @override
  String get privacyBody =>
      'لا حساب ولا اشتراك ولا تحليلات ولا سحابة Kepli. تبقى سجلاتك في مساحة تخزين هذا التطبيق إلى أن تصدّرها أو تشاركها. صدّر نسخًا احتياطية بانتظام: قد تؤدي إزالة التطبيق أو فقدان الجهاز إلى محو بياناتك.';

  @override
  String get appVersion => 'الإصدار';

  @override
  String get operationFailed => 'تعذر إكمال العملية.';

  @override
  String get technicalDetails => 'تفاصيل تقنية';

  @override
  String get saved => 'تم حفظ الضمان على هذا الجهاز.';

  @override
  String get deleted => 'تم حذف الضمان ومرفقاته.';

  @override
  String get restored =>
      'تمت استعادة النسخة الاحتياطية والتحقق من جميع المرفقات المشار إليها.';

  @override
  String get settingsSaved => 'تم حفظ الإعدادات.';

  @override
  String get exportReady => 'التصدير جاهز.';

  @override
  String get exportCancelled => 'تم إلغاء التصدير.';

  @override
  String fileSavedTo(String path) {
    return 'تم حفظ الملف في $path';
  }

  @override
  String get shareOpened => 'اختر مكان حفظ الملف أو إرساله من لوحة المشاركة.';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get startupError =>
      'تعذر على Kepli فتح بياناتك المحلية. لم تتم إعادة ضبط ملفاتك الحالية.';

  @override
  String get unavailableImage =>
      'معاينة الصورة غير متاحة. لا يزال بإمكانك فتح الملف الأصلي.';

  @override
  String get largeAttachmentTitle => 'مرفق كبير';

  @override
  String largeAttachmentWarning(String size) {
    return 'حجم هذا الملف $size ميغابايت. تُبطئ المرفقات الكبيرة النسخ الاحتياطي وتشغل مساحة تخزين أكبر.';
  }

  @override
  String get continueAction => 'متابعة';

  @override
  String get recoverPhoto => 'استخدام الصورة المستردة';

  @override
  String get recoveredPhotoHelp =>
      'تم استرداد صورة بعد أن تسببت الكاميرا في إعادة تشغيل التطبيق. أضفها إلى ضمان حتى لا تُفقد.';

  @override
  String get dismiss => 'تجاهل';

  @override
  String get busy => 'العملية قيد التنفيذ. يُرجى الانتظار.';

  @override
  String get menu => 'القائمة';

  @override
  String get sortHint => 'مرتبة حسب أقرب تاريخ انتهاء';

  @override
  String get requiredFields => 'الاسم والفئة وتاريخ الشراء ومدة الضمان مطلوبة.';

  @override
  String get chooseDate => 'اختيار تاريخ الشراء';

  @override
  String get selected => 'محدد';

  @override
  String get notSet => 'غير محدد';

  @override
  String get reportTitle => 'تقرير الضمانات';

  @override
  String get pdfReferences =>
      'تُدرج إيصالات PDF وأوراق الضمان حسب اسم الملف. شارك ملفاتها الأصلية بشكل منفصل عند الحاجة.';

  @override
  String get documentFooter =>
      'أُنشئ محليًا بواسطة Kepli. هذا التقرير ليس نسخة احتياطية قابلة للاستعادة.';

  @override
  String get notificationTitle => 'ضمان يوشك على الانتهاء';

  @override
  String notificationBody(String name, String date) {
    return '$name: ينتهي الضمان في $date.';
  }

  @override
  String get contacts => 'جهات اتصال المبيعات والخدمة';

  @override
  String get addContact => 'إضافة جهة اتصال';

  @override
  String get editContact => 'تعديل جهة الاتصال';

  @override
  String get removeContact => 'إزالة جهة الاتصال';

  @override
  String get salesContact => 'المبيعات';

  @override
  String get serviceContact => 'الخدمة';

  @override
  String get contactName => 'الشخص المسؤول';

  @override
  String get organization => 'الشركة أو المؤسسة';

  @override
  String get phone => 'الهاتف';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get contactNotes => 'ملاحظات جهة الاتصال';

  @override
  String get noContacts => 'لم تُضف أي جهات اتصال';

  @override
  String get businessCard => 'بطاقة عمل';

  @override
  String get scanBusinessCard => 'مسح بطاقة عمل';

  @override
  String get addBusinessCard => 'إضافة بطاقة عمل';

  @override
  String get businessCardHelp =>
      'صوّر البطاقة أو استوردها وأرفقها بجهة الاتصال هذه. أدخل بيانات الشخص أدناه؛ لا يستخدم Kepli التعرف الضوئي على النصوص عبر السحابة.';

  @override
  String get businessCardNeedsContact =>
      'احفظ اسم جهة الاتصال قبل إرفاق بطاقة عمل.';

  @override
  String get scanDocument => 'مسح مستند';

  @override
  String get scanHelp =>
      'صوّر الصفحات أو اختر صورًا، ثم قصّها ودوّرها واحفظها في ملف PDF واحد. تتم المعالجة على هذا الجهاز؛ ولا يُستخرج النص تلقائيًا.';

  @override
  String get addPage => 'إضافة صفحة';

  @override
  String get removePage => 'إزالة الصفحة';

  @override
  String get rotatePage => 'تدوير الصفحة';

  @override
  String pageNumber(int number) {
    return 'الصفحة $number';
  }

  @override
  String get cropTop => 'قص من الأعلى';

  @override
  String get cropBottom => 'قص من الأسفل';

  @override
  String get cropLeft => 'قص من اليسار';

  @override
  String get cropRight => 'قص من اليمين';

  @override
  String get enhanceDocument => 'تحسين تباين المستند';

  @override
  String get saveScan => 'حفظ المسح بصيغة PDF';

  @override
  String get scanName => 'اسم المستند';

  @override
  String get noPages => 'أضف صفحة واحدة على الأقل.';

  @override
  String get desktopScanHelp =>
      'اختر الصور التي حفظتها الماسحة الضوئية أو الكاميرا. لا يلزم التحكم المباشر في جهاز المسح الضوئي.';

  @override
  String get attachmentType => 'نوع المرفق';

  @override
  String get previousPage => 'الصفحة السابقة';

  @override
  String get nextPage => 'الصفحة التالية';

  @override
  String get processingDocument => 'جارٍ معالجة المستند على هذا الجهاز';

  @override
  String get readOnlyDetails => 'تفاصيل الضمان';

  @override
  String get selectWarranty => 'اختر ضمانًا لعرض تفاصيله.';
}
