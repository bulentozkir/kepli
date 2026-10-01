// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Dhamana zako. Risiti zako. Ni zako.';

  @override
  String get warranties => 'Dhamana';

  @override
  String get backups => 'Nakala rudufu';

  @override
  String get settings => 'Mipangilio';

  @override
  String get addWarranty => 'Ongeza dhamana';

  @override
  String get editWarranty => 'Hariri dhamana';

  @override
  String get save => 'Hifadhi';

  @override
  String get cancel => 'Ghairi';

  @override
  String get delete => 'Futa';

  @override
  String get close => 'Funga';

  @override
  String get edit => 'Hariri';

  @override
  String get searchHint => 'Tafuta kwa jina, duka au aina';

  @override
  String get all => 'Zote';

  @override
  String get active => 'Halali';

  @override
  String get expiringSoon => 'Zinakaribia kuisha';

  @override
  String get expired => 'Zilizoisha';

  @override
  String get claimed => 'Dai limewasilishwa';

  @override
  String get status => 'Hali';

  @override
  String get noWarranties => 'Bado hakuna dhamana';

  @override
  String get getStarted =>
      'Ongeza ununuzi na uhifadhi risiti yake, hati za dhamana na mawasiliano pamoja.';

  @override
  String get noMatches => 'Hakuna dhamana zinazolingana';

  @override
  String get clearFilters => 'Ondoa vichujio';

  @override
  String get purchaseDate => 'Tarehe ya ununuzi';

  @override
  String get expiryDate => 'Tarehe ya kuisha';

  @override
  String get warrantyLength => 'Muda wa dhamana';

  @override
  String get months => 'Miezi';

  @override
  String get years => 'Miaka';

  @override
  String get customDuration => 'Muda maalumu';

  @override
  String get name => 'Jina';

  @override
  String get nameHint => 'Kwa mfano, jokofu la jikoni';

  @override
  String get category => 'Aina';

  @override
  String get vendor => 'Duka au muuzaji';

  @override
  String get price => 'Bei (si lazima)';

  @override
  String get currency => 'Msimbo wa sarafu';

  @override
  String get notes => 'Maelezo';

  @override
  String get productPhoto => 'Picha ya bidhaa';

  @override
  String get receipt => 'Risiti';

  @override
  String get warrantyPaper => 'Hati ya dhamana';

  @override
  String get attachments => 'Viambatisho';

  @override
  String get addFiles => 'Ongeza faili';

  @override
  String get takePhoto => 'Piga picha';

  @override
  String get choosePhoto => 'Chagua picha';

  @override
  String get removeAttachment => 'Ondoa kiambatisho';

  @override
  String get openAttachment => 'Fungua kiambatisho';

  @override
  String get markClaimed => 'Weka alama kuwa dai limewasilishwa';

  @override
  String get markActive => 'Ondoa hali ya dai lililowasilishwa';

  @override
  String get exportPdf => 'Hamisha dhamana kama PDF';

  @override
  String get deleteWarranty => 'Ufute dhamana?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Ufute $name na viambatisho vyake vyote kutoka kwenye kifaa hiki? Kitendo hiki hakiwezi kutenduliwa.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zimebaki siku $count',
      one: 'Imebaki siku 1',
      zero: 'Inaisha leo',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Dhamana $count',
      one: 'Dhamana 1',
      zero: 'Hakuna dhamana',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Sehemu hii inahitajika.';

  @override
  String get invalidDuration => 'Weka muda wa mwezi 1 hadi miezi 1,200.';

  @override
  String get invalidPrice =>
      'Weka kiasi chenye hadi tarakimu mbili baada ya nukta ya desimali.';

  @override
  String get invalidCurrency =>
      'Weka msimbo wa sarafu wenye herufi tatu, kama USD.';

  @override
  String get invalidEmail => 'Weka anwani halali ya barua pepe.';

  @override
  String get discardChanges =>
      'Utupilie mbali mabadiliko ambayo hayajahifadhiwa?';

  @override
  String get discard => 'Tupilia mbali';

  @override
  String get keepEditing => 'Endelea kuhariri';

  @override
  String get restoreBackup => 'Rejesha nakala rudufu';

  @override
  String get exportBackup => 'Hamisha nakala rudufu';

  @override
  String get exportCsv => 'Hamisha kama CSV';

  @override
  String get backupExplanation =>
      'Faili moja ya ZIP ina dhamana zako, mawasiliano, mapendeleo na viambatisho asili. Ihamishe hadi kifaa kingine na uirejeshe huko. Uhamishaji huu unafanywa na wewe, si usawazishaji wa kiotomatiki.';

  @override
  String get backupPrivacy =>
      'Nakala rudufu hazijasimbwa kwa njia fiche. Zihifadhi mahali salama. Kepli haina huduma ya wingu; unadhibiti maeneo unayochagua katika kidirisha cha kushiriki cha mfumo.';

  @override
  String get chooseBackup => 'Chagua faili ya nakala rudufu';

  @override
  String get backupPreview => 'Kagua nakala rudufu';

  @override
  String get newWarranties => 'Dhamana mpya';

  @override
  String backupSummary(int items, int files) {
    return 'Dhamana: $items; viambatisho: $files';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Ilihamishwa tarehe $date kwenye $platform';
  }

  @override
  String get merge => 'Unganisha';

  @override
  String get mergeHelp =>
      'Huongeza dhamana mpya na kuweka toleo jipya zaidi la dhamana zinazolingana. Mapendeleo ya sasa yanahifadhiwa.';

  @override
  String get replaceAll => 'Badilisha zote';

  @override
  String get replaceHelp =>
      'Hubadilisha dhamana na mapendeleo ya kifaa hiki kwa kutumia yaliyomo kwenye nakala rudufu.';

  @override
  String replaceConfirmation(int count) {
    return 'Ubadilishe kabisa dhamana zote $count kwenye kifaa hiki? Hamisha nakala rudufu kwanza ikiwa unataka kuzihifadhi.';
  }

  @override
  String get confirmReplace => 'Badilisha dhamana zote';

  @override
  String get conflicts => 'Dhamana zinazolingana';

  @override
  String get keepLocal => 'Hifadhi toleo la kifaa hiki';

  @override
  String get useBackup => 'Tumia toleo jipya zaidi la nakala rudufu';

  @override
  String get newerWinsHelp =>
      'Kwa kawaida sasisho jipya zaidi ndilo linalotumika. Ikiwa alama za muda ni sawa, toleo la kifaa hiki huhifadhiwa. Chagua dhamana hapa chini ili kuhifadhi toleo la kifaa hiki badala yake.';

  @override
  String get restore => 'Rejesha';

  @override
  String get notifications => 'Vikumbusho';

  @override
  String get enableReminders => 'Washa vikumbusho vya kuisha kwa dhamana';

  @override
  String get reminderDays => 'Siku kabla ya kuisha';

  @override
  String get reminderDaysHelp =>
      'Tenganisha thamani kwa koma, kwa mfano 30, 7, 1. Tumia 0 kwa tarehe ya kuisha.';

  @override
  String get invalidReminderDays =>
      'Weka thamani 1 hadi 12 zisizojirudia, kila moja ikiwa kati ya siku 0 na 3,650.';

  @override
  String get reminderHour => 'Saa ya kikumbusho (0-23)';

  @override
  String get invalidReminderHour => 'Weka saa kati ya 0 na 23.';

  @override
  String get reminderLimit =>
      'Vikumbusho vya karibu zaidi pekee ndivyo vinavyotoshea kwenye foleni ya mfumo wa uendeshaji. Fungua Kepli mara kwa mara ili kuongeza vingine.';

  @override
  String get notificationPrivacy =>
      'Vikumbusho hupangwa kwenye kifaa hiki. Ruhusa, mipangilio ya betri na mfumo wa uendeshaji vinaweza kuvichelewesha au kuvizuia. Orodha ya dhamana zinazokaribia kuisha inapatikana kila wakati.';

  @override
  String get permissionRequired => 'Ruhusa ya arifa inahitajika.';

  @override
  String get requestPermission => 'Omba ruhusa';

  @override
  String get remindersOff => 'Vikumbusho vimezimwa.';

  @override
  String get remindersUnavailable =>
      'Vikumbusho vya mfumo havipatikani. Tumia orodha ya dhamana zinazokaribia kuisha.';

  @override
  String remindersScheduled(int count) {
    return 'Vikumbusho vilivyopangwa: $count.';
  }

  @override
  String get linuxReminderHelp =>
      'Kwenye Linux, vikumbusho hufanya kazi tu wakati Kepli imefunguliwa na huduma ya arifa inapatikana.';

  @override
  String get accessibility => 'Ufikivu';

  @override
  String get highContrast => 'Ongeza utofautishaji';

  @override
  String get reduceMotion => 'Punguza miondoko';

  @override
  String get accessibilityHelp =>
      'Kepli pia hufuata mipangilio ya mfumo ya ukubwa wa maandishi, kisoma skrini, utofautishaji na kupunguza miondoko. Kila kitendo kinapatikana bila kutumia ishara za kugusa.';

  @override
  String get language => 'Lugha';

  @override
  String get languageHelp =>
      'Chagua lugha ya kiolesura. Kiingereza ndiyo lugha chaguomsingi. Maandishi ya vipengee ulivyohifadhi hayatafsiriwi.';

  @override
  String get categories => 'Aina';

  @override
  String get addCategory => 'Ongeza aina';

  @override
  String get renameCategory => 'Badilisha jina la aina';

  @override
  String get deleteCategory => 'Futa aina';

  @override
  String get categoryInUse =>
      'Aina hii inatumiwa na dhamana. Badilisha aina ya dhamana hiyo kwanza.';

  @override
  String get newCategory => 'Jina la aina';

  @override
  String get categoryExists => 'Aina hiyo tayari ipo.';

  @override
  String get categoryElectronics => 'Vifaa vya elektroniki';

  @override
  String get categoryAppliances => 'Vifaa vya nyumbani';

  @override
  String get categoryTools => 'Zana';

  @override
  String get categoryOther => 'Nyingine';

  @override
  String get exportReports => 'Ripoti';

  @override
  String get about => 'Kuhusu Kepli';

  @override
  String get privacyTitle => 'Kwenye kifaa chako. Faragha. Ni vyako.';

  @override
  String get privacyBody =>
      'Hakuna akaunti, usajili wa kulipia, uchanganuzi wa matumizi wala wingu la Kepli. Rekodi zako hubaki kwenye hifadhi ya programu hii hadi uzihamishe au uzishiriki. Hamisha nakala rudufu mara kwa mara: kuondoa programu au kupoteza kifaa kunaweza kusababisha kupotea kwa data yako.';

  @override
  String get appVersion => 'Toleo';

  @override
  String get operationFailed => 'Haikuwezekana kukamilisha shughuli.';

  @override
  String get technicalDetails => 'Maelezo ya kiufundi';

  @override
  String get saved => 'Dhamana imehifadhiwa kwenye kifaa hiki.';

  @override
  String get deleted => 'Dhamana na viambatisho vyake vimefutwa.';

  @override
  String get restored =>
      'Nakala rudufu imerejeshwa. Viambatisho vyote vilivyorejelewa vimethibitishwa.';

  @override
  String get settingsSaved => 'Mipangilio imehifadhiwa.';

  @override
  String get exportReady => 'Uhamishaji uko tayari.';

  @override
  String get exportCancelled => 'Uhamishaji umeghairiwa.';

  @override
  String fileSavedTo(String path) {
    return 'Faili imehifadhiwa katika $path';
  }

  @override
  String get shareOpened =>
      'Chagua mahali pa kuhifadhi au kutuma faili katika kidirisha cha kushiriki.';

  @override
  String get loading => 'Inapakia';

  @override
  String get retry => 'Jaribu tena';

  @override
  String get startupError =>
      'Kepli haikuweza kufungua data yako kwenye kifaa hiki. Faili zako zilizopo hazijawekwa upya.';

  @override
  String get unavailableImage =>
      'Onyesho la kukagua picha halipatikani. Bado unaweza kufungua faili asili.';

  @override
  String get largeAttachmentTitle => 'Kiambatisho kikubwa';

  @override
  String largeAttachmentWarning(String size) {
    return 'Faili hii ina ukubwa wa MB $size. Viambatisho vikubwa hupunguza kasi ya kutengeneza nakala rudufu na hutumia nafasi zaidi ya hifadhi.';
  }

  @override
  String get continueAction => 'Endelea';

  @override
  String get recoverPhoto => 'Tumia picha iliyorejeshwa';

  @override
  String get recoveredPhotoHelp =>
      'Picha ilirejeshwa baada ya kamera kuanzisha upya programu. Iongeze kwenye dhamana ili isipotee.';

  @override
  String get dismiss => 'Puuza';

  @override
  String get busy => 'Shughuli inaendelea. Tafadhali subiri.';

  @override
  String get menu => 'Menyu';

  @override
  String get sortHint =>
      'Zimepangwa kuanzia tarehe ya kuisha iliyo karibu zaidi';

  @override
  String get requiredFields =>
      'Jina, aina, tarehe ya ununuzi na muda wa dhamana vinahitajika.';

  @override
  String get chooseDate => 'Chagua tarehe ya ununuzi';

  @override
  String get selected => 'Imechaguliwa';

  @override
  String get notSet => 'Haijawekwa';

  @override
  String get reportTitle => 'Ripoti ya dhamana';

  @override
  String get pdfReferences =>
      'Risiti na hati za dhamana za PDF zimeorodheshwa kwa jina la faili. Shiriki faili zake asili kando zinapohitajika.';

  @override
  String get documentFooter =>
      'Imetengenezwa kwenye kifaa hiki na Kepli. Ripoti hii si nakala rudufu inayoweza kurejeshwa.';

  @override
  String get notificationTitle => 'Dhamana inakaribia kuisha';

  @override
  String notificationBody(String name, String date) {
    return '$name: dhamana inaisha tarehe $date.';
  }

  @override
  String get contacts => 'Mawasiliano ya mauzo na huduma';

  @override
  String get addContact => 'Ongeza mawasiliano';

  @override
  String get editContact => 'Hariri mawasiliano';

  @override
  String get removeContact => 'Ondoa mawasiliano';

  @override
  String get salesContact => 'Mauzo';

  @override
  String get serviceContact => 'Huduma';

  @override
  String get contactName => 'Mtu wa kuwasiliana naye';

  @override
  String get organization => 'Kampuni au shirika';

  @override
  String get phone => 'Simu';

  @override
  String get email => 'Barua pepe';

  @override
  String get contactNotes => 'Maelezo ya mawasiliano';

  @override
  String get noContacts => 'Hakuna mawasiliano yaliyoongezwa';

  @override
  String get businessCard => 'Kadi ya biashara';

  @override
  String get scanBusinessCard => 'Changanua kadi ya biashara';

  @override
  String get addBusinessCard => 'Ongeza kadi ya biashara';

  @override
  String get businessCardHelp =>
      'Piga picha ya kadi au uilete kutoka kwenye faili na uiambatishe kwenye mawasiliano haya. Weka maelezo ya mtu hapa chini; Kepli haitumii utambuzi wa maandishi kwenye wingu.';

  @override
  String get businessCardNeedsContact =>
      'Hifadhi jina la mtu wa kuwasiliana naye kabla ya kuambatisha kadi ya biashara.';

  @override
  String get scanDocument => 'Changanua hati';

  @override
  String get scanHelp =>
      'Piga picha za kurasa au chagua picha, kisha zipunguze kingo, zizungushe na uzihifadhi kama PDF moja. Uchakataji hufanyika kwenye kifaa hiki; maandishi hayatolewi kiotomatiki.';

  @override
  String get addPage => 'Ongeza ukurasa';

  @override
  String get removePage => 'Ondoa ukurasa';

  @override
  String get rotatePage => 'Zungusha ukurasa';

  @override
  String pageNumber(int number) {
    return 'Ukurasa $number';
  }

  @override
  String get cropTop => 'Kata sehemu ya juu';

  @override
  String get cropBottom => 'Kata sehemu ya chini';

  @override
  String get cropLeft => 'Kata upande wa kushoto';

  @override
  String get cropRight => 'Kata upande wa kulia';

  @override
  String get enhanceDocument => 'Ongeza utofautishaji wa hati';

  @override
  String get saveScan => 'Hifadhi uchanganuzi kama PDF';

  @override
  String get scanName => 'Jina la hati';

  @override
  String get noPages => 'Ongeza angalau ukurasa mmoja.';

  @override
  String get desktopScanHelp =>
      'Chagua picha zilizohifadhiwa na kichanganuzi au kamera yako. Udhibiti wa moja kwa moja wa kifaa cha kuchanganua hauhitajiki.';

  @override
  String get attachmentType => 'Aina ya kiambatisho';

  @override
  String get previousPage => 'Ukurasa uliotangulia';

  @override
  String get nextPage => 'Ukurasa unaofuata';

  @override
  String get processingDocument => 'Inachakata hati kwenye kifaa hiki';

  @override
  String get readOnlyDetails => 'Maelezo ya dhamana';

  @override
  String get selectWarranty => 'Chagua dhamana ili kuona maelezo yake.';
}
