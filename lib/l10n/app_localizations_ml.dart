// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline =>
      'നിങ്ങളുടെ വാറന്റികൾ. നിങ്ങളുടെ രസീതുകൾ. നിങ്ങൾക്കു സ്വന്തം.';

  @override
  String get warranties => 'വാറന്റികൾ';

  @override
  String get backups => 'ബാക്കപ്പുകൾ';

  @override
  String get settings => 'ക്രമീകരണങ്ങൾ';

  @override
  String get addWarranty => 'വാറന്റി ചേർക്കുക';

  @override
  String get editWarranty => 'വാറന്റി തിരുത്തുക';

  @override
  String get save => 'സംരക്ഷിക്കുക';

  @override
  String get cancel => 'റദ്ദാക്കുക';

  @override
  String get delete => 'ഇല്ലാതാക്കുക';

  @override
  String get close => 'അടയ്ക്കുക';

  @override
  String get edit => 'തിരുത്തുക';

  @override
  String get searchHint => 'പേര്, കട അല്ലെങ്കിൽ വിഭാഗം തിരയുക';

  @override
  String get all => 'എല്ലാം';

  @override
  String get active => 'സാധുവായത്';

  @override
  String get expiringSoon => 'ഉടൻ കാലാവധി തീരുന്നത്';

  @override
  String get expired => 'കാലാവധി തീർന്നത്';

  @override
  String get claimed => 'ക്ലെയിം ചെയ്തത്';

  @override
  String get status => 'നില';

  @override
  String get noWarranties => 'ഇതുവരെ വാറന്റികളില്ല';

  @override
  String get getStarted =>
      'ഒരു വാങ്ങൽ ചേർത്ത് അതിന്റെ രസീത്, വാറന്റി രേഖകൾ, ബന്ധപ്പെടാനുള്ള വിവരങ്ങൾ എന്നിവ ഒന്നിച്ച് സൂക്ഷിക്കുക.';

  @override
  String get noMatches => 'പൊരുത്തപ്പെടുന്ന വാറന്റികളില്ല';

  @override
  String get clearFilters => 'ഫിൽട്ടറുകൾ നീക്കുക';

  @override
  String get purchaseDate => 'വാങ്ങിയ തീയതി';

  @override
  String get expiryDate => 'കാലാവധി തീരുന്ന തീയതി';

  @override
  String get warrantyLength => 'വാറന്റി കാലയളവ്';

  @override
  String get months => 'മാസങ്ങൾ';

  @override
  String get years => 'വർഷങ്ങൾ';

  @override
  String get customDuration => 'ഇഷ്ടാനുസൃത കാലയളവ്';

  @override
  String get name => 'പേര്';

  @override
  String get nameHint => 'ഉദാഹരണത്തിന്, അടുക്കളയിലെ ഫ്രിഡ്ജ്';

  @override
  String get category => 'വിഭാഗം';

  @override
  String get vendor => 'കട അല്ലെങ്കിൽ വിൽപ്പനക്കാരൻ';

  @override
  String get price => 'വില (നിർബന്ധമില്ല)';

  @override
  String get currency => 'കറൻസി കോഡ്';

  @override
  String get notes => 'കുറിപ്പുകൾ';

  @override
  String get productPhoto => 'ഉൽപ്പന്നത്തിന്റെ ഫോട്ടോ';

  @override
  String get receipt => 'രസീത്';

  @override
  String get warrantyPaper => 'വാറന്റി രേഖ';

  @override
  String get attachments => 'അറ്റാച്ച്മെന്റുകൾ';

  @override
  String get addFiles => 'ഫയലുകൾ ചേർക്കുക';

  @override
  String get takePhoto => 'ഫോട്ടോ എടുക്കുക';

  @override
  String get choosePhoto => 'ഫോട്ടോകൾ തിരഞ്ഞെടുക്കുക';

  @override
  String get removeAttachment => 'അറ്റാച്ച്മെന്റ് നീക്കുക';

  @override
  String get openAttachment => 'അറ്റാച്ച്മെന്റ് തുറക്കുക';

  @override
  String get markClaimed => 'ക്ലെയിം ചെയ്തതായി അടയാളപ്പെടുത്തുക';

  @override
  String get markActive => 'ക്ലെയിം ചെയ്ത നില നീക്കുക';

  @override
  String get exportPdf => 'വാറന്റി PDF കയറ്റുമതി ചെയ്യുക';

  @override
  String get deleteWarranty => 'വാറന്റി ഇല്ലാതാക്കണോ?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'ഈ ഉപകരണത്തിൽ നിന്ന് $name ഉം അതിന്റെ എല്ലാ അറ്റാച്ച്മെന്റുകളും ഇല്ലാതാക്കണോ? ഈ നടപടി പഴയപടിയാക്കാൻ കഴിയില്ല.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ദിവസങ്ങൾ ബാക്കി',
      one: '1 ദിവസം ബാക്കി',
      zero: 'ഇന്ന് കാലാവധി തീരും',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count വാറന്റികൾ',
      one: '1 വാറന്റി',
      zero: 'വാറന്റികളില്ല',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'ഈ ഫീൽഡ് പൂരിപ്പിക്കണം.';

  @override
  String get invalidDuration => '1 മുതൽ 1,200 മാസം വരെ നൽകുക.';

  @override
  String get invalidPrice =>
      'ദശാംശത്തിനു ശേഷം പരമാവധി രണ്ട് അക്കങ്ങളുള്ള തുക നൽകുക.';

  @override
  String get invalidCurrency => 'USD പോലുള്ള മൂന്നക്ഷര കറൻസി കോഡ് നൽകുക.';

  @override
  String get invalidEmail => 'സാധുവായ ഒരു ഇമെയിൽ വിലാസം നൽകുക.';

  @override
  String get discardChanges => 'സംരക്ഷിക്കാത്ത മാറ്റങ്ങൾ ഉപേക്ഷിക്കണോ?';

  @override
  String get discard => 'ഉപേക്ഷിക്കുക';

  @override
  String get keepEditing => 'തിരുത്തൽ തുടരുക';

  @override
  String get restoreBackup => 'ബാക്കപ്പ് പുനഃസ്ഥാപിക്കുക';

  @override
  String get exportBackup => 'ബാക്കപ്പ് കയറ്റുമതി ചെയ്യുക';

  @override
  String get exportCsv => 'CSV കയറ്റുമതി ചെയ്യുക';

  @override
  String get backupExplanation =>
      'ഒറ്റ ZIP ഫയലിൽ നിങ്ങളുടെ വാറന്റികൾ, കോൺടാക്റ്റുകൾ, മുൻഗണനകൾ, യഥാർഥ അറ്റാച്ച്മെന്റുകൾ എന്നിവ ഉൾപ്പെടുന്നു. അത് മറ്റൊരു ഉപകരണത്തിലേക്ക് മാറ്റി അവിടെ പുനഃസ്ഥാപിക്കുക. ഇത് നിങ്ങൾ സ്വയം നടത്തുന്ന കൈമാറ്റമാണ്, സ്വയമേവയുള്ള സമന്വയമല്ല.';

  @override
  String get backupPrivacy =>
      'ബാക്കപ്പുകൾ എൻക്രിപ്റ്റ് ചെയ്തിട്ടില്ല. അവ സുരക്ഷിതമായ സ്ഥലത്ത് സൂക്ഷിക്കുക. Kepli-ക്ക് ക്ലൗഡ് സേവനമില്ല; സിസ്റ്റത്തിന്റെ പങ്കിടൽ പാനലിൽ നിങ്ങൾ തിരഞ്ഞെടുക്കുന്ന ലക്ഷ്യസ്ഥാനങ്ങൾ നിങ്ങളുടെ നിയന്ത്രണത്തിലാണ്.';

  @override
  String get chooseBackup => 'ബാക്കപ്പ് ഫയൽ തിരഞ്ഞെടുക്കുക';

  @override
  String get backupPreview => 'ബാക്കപ്പ് പരിശോധിക്കുക';

  @override
  String get newWarranties => 'പുതിയ വാറന്റികൾ';

  @override
  String backupSummary(int items, int files) {
    return '$items വാറന്റികളും $files അറ്റാച്ച്മെന്റുകളും';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date-ന് $platform-ൽ കയറ്റുമതി ചെയ്തു';
  }

  @override
  String get merge => 'ലയിപ്പിക്കുക';

  @override
  String get mergeHelp =>
      'പുതിയ വാറന്റികൾ ചേർത്ത്, പൊരുത്തപ്പെടുന്ന വാറന്റികളുടെ കൂടുതൽ പുതിയ പതിപ്പ് നിലനിർത്തുക. നിലവിലെ മുൻഗണനകൾ നിലനിൽക്കും.';

  @override
  String get replaceAll => 'എല്ലാം മാറ്റിസ്ഥാപിക്കുക';

  @override
  String get replaceHelp =>
      'ഈ ഉപകരണത്തിലെ വാറന്റികളും മുൻഗണനകളും ബാക്കപ്പിലുള്ളവ ഉപയോഗിച്ച് മാറ്റിസ്ഥാപിക്കുക.';

  @override
  String replaceConfirmation(int count) {
    return 'ഈ ഉപകരണത്തിലെ എല്ലാ $count വാറന്റികളും സ്ഥിരമായി മാറ്റിസ്ഥാപിക്കണോ? അവ നിലനിർത്തണമെങ്കിൽ ആദ്യം ബാക്കപ്പ് കയറ്റുമതി ചെയ്യുക.';
  }

  @override
  String get confirmReplace => 'എല്ലാ വാറന്റികളും മാറ്റിസ്ഥാപിക്കുക';

  @override
  String get conflicts => 'പൊരുത്തപ്പെടുന്ന വാറന്റികൾ';

  @override
  String get keepLocal => 'ഈ ഉപകരണത്തിലെ പതിപ്പ് നിലനിർത്തുക';

  @override
  String get useBackup => 'ബാക്കപ്പിലെ കൂടുതൽ പുതിയ പതിപ്പ് ഉപയോഗിക്കുക';

  @override
  String get newerWinsHelp =>
      'സാധാരണയായി ഏറ്റവും ഒടുവിൽ പുതുക്കിയ പതിപ്പാണ് നിലനിർത്തുന്നത്. സമയമുദ്രകൾ തുല്യമാണെങ്കിൽ ഈ ഉപകരണത്തിലെ പതിപ്പ് നിലനിർത്തും. പകരം പ്രാദേശിക പതിപ്പ് നിലനിർത്താൻ താഴെ വാറന്റികൾ തിരഞ്ഞെടുക്കുക.';

  @override
  String get restore => 'പുനഃസ്ഥാപിക്കുക';

  @override
  String get notifications => 'ഓർമ്മപ്പെടുത്തലുകൾ';

  @override
  String get enableReminders =>
      'കാലാവധി ഓർമ്മപ്പെടുത്തലുകൾ പ്രവർത്തനക്ഷമമാക്കുക';

  @override
  String get reminderDays => 'കാലാവധി തീരുന്നതിന് മുമ്പുള്ള ദിവസങ്ങൾ';

  @override
  String get reminderDaysHelp =>
      'മൂല്യങ്ങൾ കോമ ഉപയോഗിച്ച് വേർതിരിക്കുക, ഉദാഹരണത്തിന് 30, 7, 1. കാലാവധി തീരുന്ന തീയതിക്ക് 0 ഉപയോഗിക്കുക.';

  @override
  String get invalidReminderDays =>
      '1 മുതൽ 12 വരെ വ്യത്യസ്ത മൂല്യങ്ങൾ നൽകുക. ഓരോന്നും 0 മുതൽ 3,650 ദിവസങ്ങൾക്കുള്ളിൽ ആയിരിക്കണം.';

  @override
  String get reminderHour => 'ഓർമ്മപ്പെടുത്തേണ്ട മണിക്കൂർ (0–23)';

  @override
  String get invalidReminderHour => '0 മുതൽ 23 വരെയുള്ള ഒരു മണിക്കൂർ നൽകുക.';

  @override
  String get reminderLimit =>
      'ഓപ്പറേറ്റിങ് സിസ്റ്റത്തിന്റെ ക്യൂവിൽ ഏറ്റവും അടുത്ത ഓർമ്മപ്പെടുത്തലുകൾക്കു മാത്രമേ ഇടമുള്ളൂ. അടുത്തവ ചേർക്കാൻ Kepli പതിവായി തുറക്കുക.';

  @override
  String get notificationPrivacy =>
      'ഓർമ്മപ്പെടുത്തലുകൾ ഈ ഉപകരണത്തിൽത്തന്നെ സമയക്രമീകരിക്കുന്നു. അനുമതികൾ, ബാറ്ററി ക്രമീകരണങ്ങൾ, ഓപ്പറേറ്റിങ് സിസ്റ്റം എന്നിവ അവ വൈകിപ്പിക്കുകയോ തടയുകയോ ചെയ്യാം. ഉടൻ കാലാവധി തീരുന്നവയുടെ പട്ടിക എപ്പോഴും ലഭ്യമാണ്.';

  @override
  String get permissionRequired => 'അറിയിപ്പുകൾക്കുള്ള അനുമതി ആവശ്യമാണ്.';

  @override
  String get requestPermission => 'അനുമതി അഭ്യർഥിക്കുക';

  @override
  String get remindersOff => 'ഓർമ്മപ്പെടുത്തലുകൾ ഓഫാണ്.';

  @override
  String get remindersUnavailable =>
      'സിസ്റ്റം ഓർമ്മപ്പെടുത്തലുകൾ ലഭ്യമല്ല. ഉടൻ കാലാവധി തീരുന്നവയുടെ പട്ടിക ഉപയോഗിക്കുക.';

  @override
  String remindersScheduled(int count) {
    return '$count ഓർമ്മപ്പെടുത്തലുകൾ സമയക്രമീകരിച്ചു.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux-ൽ Kepli തുറന്നിരിക്കുമ്പോഴും അറിയിപ്പ് സേവനം ലഭ്യമായിരിക്കുമ്പോഴും മാത്രമേ ഓർമ്മപ്പെടുത്തലുകൾ പ്രവർത്തിക്കൂ.';

  @override
  String get accessibility => 'പ്രവേശനക്ഷമത';

  @override
  String get highContrast => 'കോൺട്രാസ്റ്റ് കൂട്ടുക';

  @override
  String get reduceMotion => 'ചലനം കുറയ്ക്കുക';

  @override
  String get accessibilityHelp =>
      'നിങ്ങളുടെ സിസ്റ്റത്തിലെ എഴുത്തിന്റെ വലുപ്പം, സ്ക്രീൻ റീഡർ, കോൺട്രാസ്റ്റ്, ചലനം കുറയ്ക്കൽ എന്നീ ക്രമീകരണങ്ങളും Kepli പിന്തുടരുന്നു. എല്ലാ പ്രവർത്തനങ്ങളും ആംഗ്യങ്ങളില്ലാതെ ചെയ്യാം.';

  @override
  String get language => 'ഭാഷ';

  @override
  String get languageHelp =>
      'ഇന്റർഫേസ് ഭാഷ തിരഞ്ഞെടുക്കുക. ഇംഗ്ലീഷാണ് സ്ഥിരസ്ഥിതി ഭാഷ. സംരക്ഷിച്ച ഇനങ്ങളിലെ എഴുത്ത് വിവർത്തനം ചെയ്യില്ല.';

  @override
  String get categories => 'വിഭാഗങ്ങൾ';

  @override
  String get addCategory => 'വിഭാഗം ചേർക്കുക';

  @override
  String get renameCategory => 'വിഭാഗത്തിന്റെ പേര് മാറ്റുക';

  @override
  String get deleteCategory => 'വിഭാഗം ഇല്ലാതാക്കുക';

  @override
  String get categoryInUse =>
      'ഒരു വാറന്റി ഈ വിഭാഗം ഉപയോഗിക്കുന്നു. ആദ്യം ആ വാറന്റിയുടെ വിഭാഗം മാറ്റുക.';

  @override
  String get newCategory => 'വിഭാഗത്തിന്റെ പേര്';

  @override
  String get categoryExists => 'ഈ വിഭാഗം നേരത്തേ നിലവിലുണ്ട്.';

  @override
  String get categoryElectronics => 'ഇലക്ട്രോണിക് ഉപകരണങ്ങൾ';

  @override
  String get categoryAppliances => 'വീട്ടുപകരണങ്ങൾ';

  @override
  String get categoryTools => 'പണിയായുധങ്ങൾ';

  @override
  String get categoryOther => 'മറ്റുള്ളവ';

  @override
  String get exportReports => 'റിപ്പോർട്ടുകൾ';

  @override
  String get about => 'Kepli-യെക്കുറിച്ച്';

  @override
  String get privacyTitle => 'പ്രാദേശികം. സ്വകാര്യത. നിങ്ങളുടെ സ്വന്തം.';

  @override
  String get privacyBody =>
      'അക്കൗണ്ട്, സബ്സ്ക്രിപ്ഷൻ, ഉപയോഗ വിശകലനം അല്ലെങ്കിൽ Kepli ക്ലൗഡ് ഒന്നുമില്ല. നിങ്ങൾ കയറ്റുമതി ചെയ്യുകയോ പങ്കിടുകയോ ചെയ്യുന്നതുവരെ നിങ്ങളുടെ രേഖകൾ ഈ ആപ്പിന്റെ സംഭരണത്തിൽ തുടരും. പതിവായി ബാക്കപ്പുകൾ കയറ്റുമതി ചെയ്യുക: ആപ്പ് അൺഇൻസ്റ്റാൾ ചെയ്യുന്നതോ ഉപകരണം നഷ്ടപ്പെടുന്നതോ നിങ്ങളുടെ ഡാറ്റ ഇല്ലാതാക്കിയേക്കാം.';

  @override
  String get appVersion => 'പതിപ്പ്';

  @override
  String get operationFailed => 'പ്രവർത്തനം പൂർത്തിയാക്കാനായില്ല.';

  @override
  String get technicalDetails => 'സാങ്കേതിക വിവരങ്ങൾ';

  @override
  String get saved => 'വാറന്റി ഈ ഉപകരണത്തിൽ സംരക്ഷിച്ചു.';

  @override
  String get deleted => 'വാറന്റിയും അതിന്റെ അറ്റാച്ച്മെന്റുകളും ഇല്ലാതാക്കി.';

  @override
  String get restored =>
      'ബാക്കപ്പ് പുനഃസ്ഥാപിച്ചു. പരാമർശിച്ച എല്ലാ അറ്റാച്ച്മെന്റുകളും പരിശോധിച്ചു.';

  @override
  String get settingsSaved => 'ക്രമീകരണങ്ങൾ സംരക്ഷിച്ചു.';

  @override
  String get exportReady => 'കയറ്റുമതി തയ്യാറാണ്.';

  @override
  String get exportCancelled => 'കയറ്റുമതി റദ്ദാക്കി.';

  @override
  String fileSavedTo(String path) {
    return 'ഫയൽ $path-ൽ സംരക്ഷിച്ചു';
  }

  @override
  String get shareOpened =>
      'പങ്കിടൽ പാനലിൽ ഫയൽ എവിടെ സംരക്ഷിക്കണം അല്ലെങ്കിൽ അയയ്ക്കണം എന്ന് തിരഞ്ഞെടുക്കുക.';

  @override
  String get loading => 'ലോഡ് ചെയ്യുന്നു';

  @override
  String get retry => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get startupError =>
      'Kepli-ക്ക് നിങ്ങളുടെ പ്രാദേശിക ഡാറ്റ തുറക്കാനായില്ല. നിലവിലുള്ള ഫയലുകൾ പുനഃക്രമീകരിച്ചിട്ടില്ല.';

  @override
  String get unavailableImage =>
      'ചിത്രത്തിന്റെ പ്രിവ്യൂ ലഭ്യമല്ല. നിങ്ങൾക്ക് ഇപ്പോഴും യഥാർഥ ഫയൽ തുറക്കാം.';

  @override
  String get largeAttachmentTitle => 'വലിയ അറ്റാച്ച്മെന്റ്';

  @override
  String largeAttachmentWarning(String size) {
    return 'ഈ ഫയലിന്റെ വലുപ്പം $size MB ആണ്. വലിയ അറ്റാച്ച്മെന്റുകൾ ബാക്കപ്പ് മന്ദഗതിയിലാക്കുകയും കൂടുതൽ സംഭരണസ്ഥലം ഉപയോഗിക്കുകയും ചെയ്യും.';
  }

  @override
  String get continueAction => 'തുടരുക';

  @override
  String get recoverPhoto => 'വീണ്ടെടുത്ത ഫോട്ടോ ഉപയോഗിക്കുക';

  @override
  String get recoveredPhotoHelp =>
      'ക്യാമറ കാരണം ആപ്പ് വീണ്ടും ആരംഭിച്ചതിനു ശേഷം ഒരു ഫോട്ടോ വീണ്ടെടുത്തു. അത് നഷ്ടപ്പെടാതിരിക്കാൻ ഒരു വാറന്റിയിൽ ചേർക്കുക.';

  @override
  String get dismiss => 'ഒഴിവാക്കുക';

  @override
  String get busy => 'പ്രവർത്തനം പുരോഗമിക്കുന്നു. ദയവായി കാത്തിരിക്കുക.';

  @override
  String get menu => 'മെനു';

  @override
  String get sortHint => 'ഏറ്റവും ആദ്യം കാലാവധി തീരുന്ന ക്രമത്തിൽ';

  @override
  String get requiredFields =>
      'പേര്, വിഭാഗം, വാങ്ങിയ തീയതി, വാറന്റി കാലയളവ് എന്നിവ നിർബന്ധമാണ്.';

  @override
  String get chooseDate => 'വാങ്ങിയ തീയതി തിരഞ്ഞെടുക്കുക';

  @override
  String get selected => 'തിരഞ്ഞെടുത്തത്';

  @override
  String get notSet => 'സജ്ജമാക്കിയിട്ടില്ല';

  @override
  String get reportTitle => 'വാറന്റി റിപ്പോർട്ട്';

  @override
  String get pdfReferences =>
      'PDF രസീതുകളും വാറന്റി രേഖകളും ഫയലിന്റെ പേര് അനുസരിച്ച് പട്ടികപ്പെടുത്തിയിരിക്കുന്നു. ആവശ്യമായി വരുമ്പോൾ അവയുടെ യഥാർഥ ഫയലുകൾ പ്രത്യേകം പങ്കിടുക.';

  @override
  String get documentFooter =>
      'Kepli ഈ ഉപകരണത്തിൽ സൃഷ്ടിച്ചത്. ഈ റിപ്പോർട്ട് പുനഃസ്ഥാപിക്കാവുന്ന ബാക്കപ്പ് അല്ല.';

  @override
  String get notificationTitle => 'വാറന്റി കാലാവധി തീരുന്നു';

  @override
  String notificationBody(String name, String date) {
    return '$name: വാറന്റി കാലാവധി $date-ന് തീരും.';
  }

  @override
  String get contacts => 'വിൽപ്പന, സേവന കോൺടാക്റ്റുകൾ';

  @override
  String get addContact => 'കോൺടാക്റ്റ് ചേർക്കുക';

  @override
  String get editContact => 'കോൺടാക്റ്റ് തിരുത്തുക';

  @override
  String get removeContact => 'കോൺടാക്റ്റ് നീക്കുക';

  @override
  String get salesContact => 'വിൽപ്പന';

  @override
  String get serviceContact => 'സേവനം';

  @override
  String get contactName => 'ബന്ധപ്പെടേണ്ട വ്യക്തി';

  @override
  String get organization => 'കമ്പനി അല്ലെങ്കിൽ സ്ഥാപനം';

  @override
  String get phone => 'ഫോൺ';

  @override
  String get email => 'ഇമെയിൽ';

  @override
  String get contactNotes => 'കോൺടാക്റ്റ് കുറിപ്പുകൾ';

  @override
  String get noContacts => 'കോൺടാക്റ്റുകളൊന്നും ചേർത്തിട്ടില്ല';

  @override
  String get businessCard => 'ബിസിനസ് കാർഡ്';

  @override
  String get scanBusinessCard => 'ബിസിനസ് കാർഡ് സ്കാൻ ചെയ്യുക';

  @override
  String get addBusinessCard => 'ബിസിനസ് കാർഡ് ചേർക്കുക';

  @override
  String get businessCardHelp =>
      'കാർഡിന്റെ ഫോട്ടോ എടുക്കുകയോ ഇറക്കുമതി ചെയ്യുകയോ ചെയ്ത് ഈ കോൺടാക്റ്റിൽ ചേർക്കുക. വ്യക്തിയുടെ വിവരങ്ങൾ താഴെ നൽകുക; Kepli ക്ലൗഡ് അധിഷ്ഠിത അക്ഷര തിരിച്ചറിയൽ ഉപയോഗിക്കുന്നില്ല.';

  @override
  String get businessCardNeedsContact =>
      'ബിസിനസ് കാർഡ് ചേർക്കുന്നതിനു മുമ്പ് കോൺടാക്റ്റിന്റെ പേര് സംരക്ഷിക്കുക.';

  @override
  String get scanDocument => 'രേഖ സ്കാൻ ചെയ്യുക';

  @override
  String get scanHelp =>
      'പേജുകളുടെ ഫോട്ടോ എടുക്കുക അല്ലെങ്കിൽ ചിത്രങ്ങൾ തിരഞ്ഞെടുക്കുക. തുടർന്ന് മുറിക്കുക, തിരിക്കുക, ഒറ്റ PDF ആയി സംരക്ഷിക്കുക. പ്രോസസ്സിങ് ഈ ഉപകരണത്തിൽത്തന്നെ നടക്കും; എഴുത്ത് സ്വയമേവ വേർതിരിച്ചെടുക്കില്ല.';

  @override
  String get addPage => 'പേജ് ചേർക്കുക';

  @override
  String get removePage => 'പേജ് നീക്കുക';

  @override
  String get rotatePage => 'പേജ് തിരിക്കുക';

  @override
  String pageNumber(int number) {
    return 'പേജ് $number';
  }

  @override
  String get cropTop => 'മുകളിൽനിന്ന് മുറിക്കുക';

  @override
  String get cropBottom => 'താഴെനിന്ന് മുറിക്കുക';

  @override
  String get cropLeft => 'ഇടത്തുനിന്ന് മുറിക്കുക';

  @override
  String get cropRight => 'വലത്തുനിന്ന് മുറിക്കുക';

  @override
  String get enhanceDocument => 'രേഖയുടെ കോൺട്രാസ്റ്റ് മെച്ചപ്പെടുത്തുക';

  @override
  String get saveScan => 'സ്കാൻ PDF ആയി സംരക്ഷിക്കുക';

  @override
  String get scanName => 'രേഖയുടെ പേര്';

  @override
  String get noPages => 'കുറഞ്ഞത് ഒരു പേജ് ചേർക്കുക.';

  @override
  String get desktopScanHelp =>
      'നിങ്ങളുടെ സ്കാനറോ ക്യാമറയോ സംരക്ഷിച്ച ചിത്രങ്ങൾ തിരഞ്ഞെടുക്കുക. സ്കാനർ ഹാർഡ്‌വെയർ നേരിട്ട് നിയന്ത്രിക്കേണ്ടതില്ല.';

  @override
  String get attachmentType => 'അറ്റാച്ച്മെന്റ് തരം';

  @override
  String get previousPage => 'മുമ്പത്തെ പേജ്';

  @override
  String get nextPage => 'അടുത്ത പേജ്';

  @override
  String get processingDocument => 'ഈ ഉപകരണത്തിൽ രേഖ പ്രോസസ്സ് ചെയ്യുന്നു';

  @override
  String get readOnlyDetails => 'വാറന്റി വിവരങ്ങൾ';

  @override
  String get selectWarranty => 'വിവരങ്ങൾ കാണാൻ ഒരു വാറന്റി തിരഞ്ഞെടുക്കുക.';
}
