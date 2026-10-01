// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'તમારી વોરંટીઓ. તમારી રસીદો. તમારી જ માલિકી.';

  @override
  String get warranties => 'વોરંટીઓ';

  @override
  String get backups => 'બૅકઅપ';

  @override
  String get settings => 'સેટિંગ્સ';

  @override
  String get addWarranty => 'વોરંટી ઉમેરો';

  @override
  String get editWarranty => 'વોરંટીમાં ફેરફાર કરો';

  @override
  String get save => 'સાચવો';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get close => 'બંધ કરો';

  @override
  String get edit => 'ફેરફાર કરો';

  @override
  String get searchHint => 'નામ, દુકાન અથવા શ્રેણી શોધો';

  @override
  String get all => 'બધી';

  @override
  String get active => 'માન્ય';

  @override
  String get expiringSoon => 'ટૂંક સમયમાં મુદત પૂરી થશે';

  @override
  String get expired => 'મુદત પૂરી થઈ';

  @override
  String get claimed => 'દાવો કરેલો';

  @override
  String get status => 'સ્થિતિ';

  @override
  String get noWarranties => 'હજી કોઈ વોરંટી નથી';

  @override
  String get getStarted =>
      'ખરીદી ઉમેરો અને તેની રસીદ, વોરંટીના કાગળો અને સંપર્કો એકસાથે રાખો.';

  @override
  String get noMatches => 'કોઈ મેળ ખાતી વોરંટી નથી';

  @override
  String get clearFilters => 'ફિલ્ટર દૂર કરો';

  @override
  String get purchaseDate => 'ખરીદીની તારીખ';

  @override
  String get expiryDate => 'મુદત પૂરી થવાની તારીખ';

  @override
  String get warrantyLength => 'વોરંટીનો સમયગાળો';

  @override
  String get months => 'મહિના';

  @override
  String get years => 'વર્ષ';

  @override
  String get customDuration => 'પસંદગીનો સમયગાળો';

  @override
  String get name => 'નામ';

  @override
  String get nameHint => 'ઉદાહરણ તરીકે, રસોડાનું ફ્રિજ';

  @override
  String get category => 'શ્રેણી';

  @override
  String get vendor => 'દુકાન અથવા વેચનાર';

  @override
  String get price => 'કિંમત (વૈકલ્પિક)';

  @override
  String get currency => 'ચલણનો કોડ';

  @override
  String get notes => 'નોંધો';

  @override
  String get productPhoto => 'ઉત્પાદનનો ફોટો';

  @override
  String get receipt => 'રસીદ';

  @override
  String get warrantyPaper => 'વોરંટીનો કાગળ';

  @override
  String get attachments => 'જોડાણો';

  @override
  String get addFiles => 'ફાઇલો ઉમેરો';

  @override
  String get takePhoto => 'ફોટો પાડો';

  @override
  String get choosePhoto => 'ફોટા પસંદ કરો';

  @override
  String get removeAttachment => 'જોડાણ દૂર કરો';

  @override
  String get openAttachment => 'જોડાણ ખોલો';

  @override
  String get markClaimed => 'દાવો કરેલો તરીકે ચિહ્નિત કરો';

  @override
  String get markActive => 'દાવો કર્યાનું ચિહ્ન દૂર કરો';

  @override
  String get exportPdf => 'વોરંટીની PDF નિકાસ કરો';

  @override
  String get deleteWarranty => 'વોરંટી કાઢી નાખવી છે?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'આ ઉપકરણમાંથી $name અને તેના બધાં જોડાણો કાઢી નાખવાં છે? આ ક્રિયા પાછી ફેરવી શકાશે નહીં.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count દિવસ બાકી',
      one: '1 દિવસ બાકી',
      zero: 'આજે મુદત પૂરી થાય છે',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count વોરંટીઓ',
      one: '1 વોરંટી',
      zero: 'કોઈ વોરંટી નથી',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'આ ખાનું ભરવું જરૂરી છે.';

  @override
  String get invalidDuration => '1 થી 1,200 મહિના દાખલ કરો.';

  @override
  String get invalidPrice => 'દશાંશ પછી વધુમાં વધુ બે અંકોવાળી રકમ દાખલ કરો.';

  @override
  String get invalidCurrency => 'ત્રણ અક્ષરનો ચલણ કોડ દાખલ કરો, જેમ કે USD.';

  @override
  String get invalidEmail => 'માન્ય ઇમેઇલ સરનામું દાખલ કરો.';

  @override
  String get discardChanges => 'સાચવ્યા વગરના ફેરફારો છોડી દેવા છે?';

  @override
  String get discard => 'છોડી દો';

  @override
  String get keepEditing => 'ફેરફાર કરવાનું ચાલુ રાખો';

  @override
  String get restoreBackup => 'બૅકઅપ પુનઃસ્થાપિત કરો';

  @override
  String get exportBackup => 'બૅકઅપ નિકાસ કરો';

  @override
  String get exportCsv => 'CSV નિકાસ કરો';

  @override
  String get backupExplanation =>
      'એક ZIP ફાઇલમાં તમારી વોરંટીઓ, સંપર્કો, પસંદગીઓ અને મૂળ જોડાણો હોય છે. તેને બીજા ઉપકરણ પર લઈ જઈ ત્યાં પુનઃસ્થાપિત કરો. આ જાતે કરવાનું સ્થાનાંતરણ છે, આપમેળે સમન્વયન નથી.';

  @override
  String get backupPrivacy =>
      'બૅકઅપ એન્ક્રિપ્ટ કરેલા નથી. તેમને સુરક્ષિત જગ્યાએ રાખો. Kepliની કોઈ ક્લાઉડ સેવા નથી; સિસ્ટમની શેર પેનલમાં તમે પસંદ કરેલાં ગંતવ્યો તમારા નિયંત્રણમાં છે.';

  @override
  String get chooseBackup => 'બૅકઅપ ફાઇલ પસંદ કરો';

  @override
  String get backupPreview => 'બૅકઅપની સમીક્ષા કરો';

  @override
  String get newWarranties => 'નવી વોરંટીઓ';

  @override
  String backupSummary(int items, int files) {
    return '$items વોરંટીઓ અને $files જોડાણો';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$dateના રોજ $platform પર નિકાસ કરેલું';
  }

  @override
  String get merge => 'ભેગું કરો';

  @override
  String get mergeHelp =>
      'નવી વોરંટીઓ ઉમેરો અને મેળ ખાતી વોરંટીઓનું વધુ નવું સંસ્કરણ રાખો. હાલની પસંદગીઓ જાળવવામાં આવે છે.';

  @override
  String get replaceAll => 'બધું બદલો';

  @override
  String get replaceHelp => 'આ ઉપકરણની વોરંટીઓ અને પસંદગીઓ બૅકઅપથી બદલો.';

  @override
  String replaceConfirmation(int count) {
    return 'આ ઉપકરણની બધી $count વોરંટીઓ કાયમ માટે બદલવી છે? તેમને રાખવા માંગતા હો તો પહેલાં બૅકઅપ નિકાસ કરો.';
  }

  @override
  String get confirmReplace => 'બધી વોરંટીઓ બદલો';

  @override
  String get conflicts => 'મેળ ખાતી વોરંટીઓ';

  @override
  String get keepLocal => 'આ ઉપકરણનું સંસ્કરણ રાખો';

  @override
  String get useBackup => 'બૅકઅપનું વધુ નવું સંસ્કરણ વાપરો';

  @override
  String get newerWinsHelp =>
      'સામાન્ય રીતે તાજેતરમાં અપડેટ થયેલું સંસ્કરણ રાખવામાં આવે છે. સમયચિહ્નો સરખાં હોય તો આ ઉપકરણનું સંસ્કરણ રહે છે. તેના બદલે સ્થાનિક સંસ્કરણ રાખવા માટે નીચે વોરંટીઓ પસંદ કરો.';

  @override
  String get restore => 'પુનઃસ્થાપિત કરો';

  @override
  String get notifications => 'યાદ અપાવતી સૂચનાઓ';

  @override
  String get enableReminders => 'મુદત પૂરી થવાની યાદ અપાવવાનું ચાલુ કરો';

  @override
  String get reminderDays => 'મુદત પૂરી થતાં પહેલાંના દિવસો';

  @override
  String get reminderDaysHelp =>
      'મૂલ્યોને અલ્પવિરામથી અલગ કરો, જેમ કે 30, 7, 1. મુદત પૂરી થવાની તારીખ માટે 0 વાપરો.';

  @override
  String get invalidReminderDays =>
      '1 થી 12 અલગ-અલગ મૂલ્યો દાખલ કરો, દરેક મૂલ્ય 0 થી 3,650 દિવસ વચ્ચે હોવું જોઈએ.';

  @override
  String get reminderHour => 'યાદ અપાવવાનો કલાક (0–23)';

  @override
  String get invalidReminderHour => '0 થી 23 વચ્ચેનો કલાક દાખલ કરો.';

  @override
  String get reminderLimit =>
      'ઑપરેટિંગ સિસ્ટમની કતારમાં ફક્ત સૌથી નજીકની યાદ અપાવતી સૂચનાઓ સમાય છે. પછીની સૂચનાઓ ઉમેરવા માટે Kepli નિયમિત ખોલો.';

  @override
  String get notificationPrivacy =>
      'યાદ અપાવતી સૂચનાઓ સ્થાનિક રીતે ગોઠવાય છે. પરવાનગીઓ, બૅટરી સેટિંગ્સ અને ઑપરેટિંગ સિસ્ટમ તેમને મોડી કરી શકે છે અથવા રોકી શકે છે. ટૂંક સમયમાં મુદત પૂરી થતી વોરંટીઓની યાદી હંમેશાં ઉપલબ્ધ છે.';

  @override
  String get permissionRequired => 'સૂચનાઓની પરવાનગી જરૂરી છે.';

  @override
  String get requestPermission => 'પરવાનગી માંગો';

  @override
  String get remindersOff => 'યાદ અપાવતી સૂચનાઓ બંધ છે.';

  @override
  String get remindersUnavailable =>
      'સિસ્ટમની યાદ અપાવતી સૂચનાઓ ઉપલબ્ધ નથી. ટૂંક સમયમાં મુદત પૂરી થતી વોરંટીઓની યાદી વાપરો.';

  @override
  String remindersScheduled(int count) {
    return '$count યાદ અપાવતી સૂચનાઓ ગોઠવાઈ.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux પર Kepli ખુલ્લું હોય અને સૂચના સેવા ઉપલબ્ધ હોય ત્યારે જ યાદ અપાવતી સૂચનાઓ કામ કરે છે.';

  @override
  String get accessibility => 'સુલભતા';

  @override
  String get highContrast => 'કોન્ટ્રાસ્ટ વધારો';

  @override
  String get reduceMotion => 'હલનચલન ઘટાડો';

  @override
  String get accessibilityHelp =>
      'Kepli તમારી સિસ્ટમના લખાણના કદ, સ્ક્રીન રીડર, કોન્ટ્રાસ્ટ અને ઓછા હલનચલનની સેટિંગ્સને પણ અનુસરે છે. દરેક ક્રિયા હાવભાવ વગર કરી શકાય છે.';

  @override
  String get language => 'ભાષા';

  @override
  String get languageHelp =>
      'ઇન્ટરફેસની ભાષા પસંદ કરો. ડિફૉલ્ટ ભાષા અંગ્રેજી છે. તમારા સાચવેલા રેકોર્ડના લખાણનો અનુવાદ થતો નથી.';

  @override
  String get categories => 'શ્રેણીઓ';

  @override
  String get addCategory => 'શ્રેણી ઉમેરો';

  @override
  String get renameCategory => 'શ્રેણીનું નામ બદલો';

  @override
  String get deleteCategory => 'શ્રેણી કાઢી નાખો';

  @override
  String get categoryInUse =>
      'એક વોરંટી આ શ્રેણી વાપરે છે. પહેલાં તે વોરંટીની શ્રેણી બદલો.';

  @override
  String get newCategory => 'શ્રેણીનું નામ';

  @override
  String get categoryExists => 'આ શ્રેણી પહેલેથી છે.';

  @override
  String get categoryElectronics => 'ઇલેક્ટ્રોનિક વસ્તુઓ';

  @override
  String get categoryAppliances => 'ઘરગથ્થુ ઉપકરણો';

  @override
  String get categoryTools => 'ઓજારો';

  @override
  String get categoryOther => 'અન્ય';

  @override
  String get exportReports => 'અહેવાલો';

  @override
  String get about => 'Kepli વિશે';

  @override
  String get privacyTitle => 'સ્થાનિક. ખાનગી. તમારું.';

  @override
  String get privacyBody =>
      'કોઈ ખાતું, સબ્સ્ક્રિપ્શન, વપરાશનું વિશ્લેષણ કે Kepli ક્લાઉડ નથી. તમે નિકાસ કે શેર ન કરો ત્યાં સુધી તમારા રેકોર્ડ આ ઍપના સ્ટોરેજમાં જ રહે છે. નિયમિત બૅકઅપ નિકાસ કરો: ઍપ અનઇન્સ્ટૉલ કરવાથી અથવા ઉપકરણ ગુમાવવાથી તમારો ડેટા મટી શકે છે.';

  @override
  String get appVersion => 'સંસ્કરણ';

  @override
  String get operationFailed => 'ક્રિયા પૂર્ણ કરી શકાઈ નહીં.';

  @override
  String get technicalDetails => 'તકનીકી વિગતો';

  @override
  String get saved => 'વોરંટી આ ઉપકરણ પર સાચવવામાં આવી.';

  @override
  String get deleted => 'વોરંટી અને તેના જોડાણો કાઢી નાખવામાં આવ્યાં.';

  @override
  String get restored =>
      'બૅકઅપ પુનઃસ્થાપિત થયો. ઉલ્લેખિત બધાં જોડાણો ચકાસવામાં આવ્યાં.';

  @override
  String get settingsSaved => 'સેટિંગ્સ સાચવવામાં આવી.';

  @override
  String get exportReady => 'નિકાસ તૈયાર છે.';

  @override
  String get exportCancelled => 'નિકાસ રદ કરવામાં આવી.';

  @override
  String fileSavedTo(String path) {
    return 'ફાઇલ $path પર સાચવવામાં આવી';
  }

  @override
  String get shareOpened =>
      'શેર પેનલમાં ફાઇલ ક્યાં સાચવવી કે મોકલવી તે પસંદ કરો.';

  @override
  String get loading => 'લોડ થઈ રહ્યું છે';

  @override
  String get retry => 'ફરી પ્રયાસ કરો';

  @override
  String get startupError =>
      'Kepli તમારો સ્થાનિક ડેટા ખોલી શક્યું નહીં. તમારી હાલની ફાઇલો રીસેટ કરવામાં આવી નથી.';

  @override
  String get unavailableImage =>
      'છબીનું પૂર્વાવલોકન ઉપલબ્ધ નથી. તમે હજી પણ મૂળ ફાઇલ ખોલી શકો છો.';

  @override
  String get largeAttachmentTitle => 'મોટું જોડાણ';

  @override
  String largeAttachmentWarning(String size) {
    return 'આ ફાઇલનું કદ $size MB છે. મોટાં જોડાણોથી બૅકઅપ ધીમા બને છે અને વધુ સ્ટોરેજ જોઈએ છે.';
  }

  @override
  String get continueAction => 'ચાલુ રાખો';

  @override
  String get recoverPhoto => 'પુનઃપ્રાપ્ત ફોટો વાપરો';

  @override
  String get recoveredPhotoHelp =>
      'કૅમેરાને કારણે ઍપ ફરી શરૂ થયા પછી એક ફોટો પુનઃપ્રાપ્ત થયો. તે ખોવાઈ ન જાય તે માટે તેને કોઈ વોરંટીમાં ઉમેરો.';

  @override
  String get dismiss => 'અવગણો';

  @override
  String get busy => 'ક્રિયા ચાલુ છે. કૃપા કરીને રાહ જુઓ.';

  @override
  String get menu => 'મેનૂ';

  @override
  String get sortHint => 'સૌથી વહેલી મુદત પૂરી થવાના ક્રમમાં';

  @override
  String get requiredFields =>
      'નામ, શ્રેણી, ખરીદીની તારીખ અને વોરંટીનો સમયગાળો જરૂરી છે.';

  @override
  String get chooseDate => 'ખરીદીની તારીખ પસંદ કરો';

  @override
  String get selected => 'પસંદ કરેલું';

  @override
  String get notSet => 'સેટ કરેલું નથી';

  @override
  String get reportTitle => 'વોરંટી અહેવાલ';

  @override
  String get pdfReferences =>
      'PDF રસીદો અને વોરંટીના કાગળો ફાઇલના નામ પ્રમાણે યાદીમાં છે. જરૂર પડે ત્યારે તેમની મૂળ ફાઇલો અલગથી શેર કરો.';

  @override
  String get documentFooter =>
      'Kepli દ્વારા સ્થાનિક રીતે બનાવેલું. આ અહેવાલ પુનઃસ્થાપિત કરી શકાય એવો બૅકઅપ નથી.';

  @override
  String get notificationTitle => 'વોરંટીની મુદત પૂરી થઈ રહી છે';

  @override
  String notificationBody(String name, String date) {
    return '$name: વોરંટીની મુદત $dateના રોજ પૂરી થાય છે.';
  }

  @override
  String get contacts => 'વેચાણ અને સેવાના સંપર્કો';

  @override
  String get addContact => 'સંપર્ક ઉમેરો';

  @override
  String get editContact => 'સંપર્કમાં ફેરફાર કરો';

  @override
  String get removeContact => 'સંપર્ક દૂર કરો';

  @override
  String get salesContact => 'વેચાણ';

  @override
  String get serviceContact => 'સેવા';

  @override
  String get contactName => 'સંપર્ક વ્યક્તિ';

  @override
  String get organization => 'કંપની અથવા સંસ્થા';

  @override
  String get phone => 'ફોન';

  @override
  String get email => 'ઇમેઇલ';

  @override
  String get contactNotes => 'સંપર્કની નોંધો';

  @override
  String get noContacts => 'કોઈ સંપર્કો ઉમેર્યા નથી';

  @override
  String get businessCard => 'વિઝિટિંગ કાર્ડ';

  @override
  String get scanBusinessCard => 'વિઝિટિંગ કાર્ડ સ્કેન કરો';

  @override
  String get addBusinessCard => 'વિઝિટિંગ કાર્ડ ઉમેરો';

  @override
  String get businessCardHelp =>
      'કાર્ડનો ફોટો પાડો અથવા આયાત કરીને આ સંપર્ક સાથે જોડો. નીચે વ્યક્તિની વિગતો દાખલ કરો; Kepli ક્લાઉડ આધારિત અક્ષર ઓળખ વાપરતું નથી.';

  @override
  String get businessCardNeedsContact =>
      'વિઝિટિંગ કાર્ડ જોડતાં પહેલાં સંપર્કનું નામ સાચવો.';

  @override
  String get scanDocument => 'દસ્તાવેજ સ્કેન કરો';

  @override
  String get scanHelp =>
      'પાનાંના ફોટા પાડો અથવા છબીઓ પસંદ કરો, પછી કાપો, ફેરવો અને એક PDF તરીકે સાચવો. પ્રક્રિયા આ ઉપકરણ પર જ થાય છે; લખાણ આપમેળે કાઢવામાં આવતું નથી.';

  @override
  String get addPage => 'પાનું ઉમેરો';

  @override
  String get removePage => 'પાનું દૂર કરો';

  @override
  String get rotatePage => 'પાનું ફેરવો';

  @override
  String pageNumber(int number) {
    return 'પાનું $number';
  }

  @override
  String get cropTop => 'ઉપરથી કાપો';

  @override
  String get cropBottom => 'નીચેથી કાપો';

  @override
  String get cropLeft => 'ડાબેથી કાપો';

  @override
  String get cropRight => 'જમણેથી કાપો';

  @override
  String get enhanceDocument => 'દસ્તાવેજનો કોન્ટ્રાસ્ટ વધારો';

  @override
  String get saveScan => 'સ્કેનને PDF તરીકે સાચવો';

  @override
  String get scanName => 'દસ્તાવેજનું નામ';

  @override
  String get noPages => 'ઓછામાં ઓછું એક પાનું ઉમેરો.';

  @override
  String get desktopScanHelp =>
      'તમારા સ્કેનર અથવા કૅમેરાએ સાચવેલી છબીઓ પસંદ કરો. સ્કેનરના હાર્ડવેરનું સીધું નિયંત્રણ જરૂરી નથી.';

  @override
  String get attachmentType => 'જોડાણનો પ્રકાર';

  @override
  String get previousPage => 'અગાઉનું પાનું';

  @override
  String get nextPage => 'આગળનું પાનું';

  @override
  String get processingDocument => 'આ ઉપકરણ પર દસ્તાવેજની પ્રક્રિયા થઈ રહી છે';

  @override
  String get readOnlyDetails => 'વોરંટીની વિગતો';

  @override
  String get selectWarranty => 'વિગતો જોવા માટે વોરંટી પસંદ કરો.';
}
