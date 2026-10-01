// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'మీ వారంటీలు. మీ రసీదులు. మీ సొంతం.';

  @override
  String get warranties => 'వారంటీలు';

  @override
  String get backups => 'బ్యాకప్‌లు';

  @override
  String get settings => 'సెట్టింగ్‌లు';

  @override
  String get addWarranty => 'వారంటీని జోడించండి';

  @override
  String get editWarranty => 'వారంటీని సవరించండి';

  @override
  String get save => 'సేవ్ చేయండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get delete => 'తొలగించండి';

  @override
  String get close => 'మూసివేయండి';

  @override
  String get edit => 'సవరించండి';

  @override
  String get searchHint => 'పేరు, దుకాణం లేదా వర్గం ద్వారా వెతకండి';

  @override
  String get all => 'అన్నీ';

  @override
  String get active => 'చెల్లుబాటులో ఉన్నవి';

  @override
  String get expiringSoon => 'త్వరలో గడువు ముగిసేవి';

  @override
  String get expired => 'గడువు ముగిసినవి';

  @override
  String get claimed => 'క్లెయిమ్ చేసినవి';

  @override
  String get noWarranties => 'ఇంకా వారంటీలు లేవు';

  @override
  String get getStarted =>
      'ఒక కొనుగోలును జోడించి, దాని రసీదు, వారంటీ పత్రాలు, సంప్రదింపు వివరాలను ఒకేచోట ఉంచండి.';

  @override
  String get noMatches => 'సరిపోలే వారంటీలు లేవు';

  @override
  String get clearFilters => 'ఫిల్టర్‌లను తీసివేయండి';

  @override
  String get purchaseDate => 'కొనుగోలు తేదీ';

  @override
  String get expiryDate => 'గడువు ముగిసే తేదీ';

  @override
  String get warrantyLength => 'వారంటీ వ్యవధి';

  @override
  String get months => 'నెలలు';

  @override
  String get years => 'సంవత్సరాలు';

  @override
  String get name => 'పేరు';

  @override
  String get nameHint => 'ఉదాహరణకు, వంటగది ఫ్రిజ్';

  @override
  String get category => 'వర్గం';

  @override
  String get vendor => 'దుకాణం లేదా విక్రేత';

  @override
  String get price => 'ధర (ఐచ్ఛికం)';

  @override
  String get currency => 'కరెన్సీ కోడ్';

  @override
  String get notes => 'గమనికలు';

  @override
  String get productPhoto => 'ఉత్పత్తి ఫోటో';

  @override
  String get receipt => 'రసీదు';

  @override
  String get warrantyPaper => 'వారంటీ పత్రం';

  @override
  String get attachments => 'జోడింపులు';

  @override
  String get addFiles => 'ఫైళ్లను జోడించండి';

  @override
  String get takePhoto => 'ఫోటో తీయండి';

  @override
  String get choosePhoto => 'ఫోటోలను ఎంచుకోండి';

  @override
  String get removeAttachment => 'జోడింపును తీసివేయండి';

  @override
  String get openAttachment => 'జోడింపును తెరవండి';

  @override
  String get markClaimed => 'క్లెయిమ్ చేసినట్లు గుర్తించండి';

  @override
  String get markActive => 'క్లెయిమ్ చేసిన గుర్తును తీసివేయండి';

  @override
  String get exportPdf => 'వారంటీ PDFని ఎగుమతి చేయండి';

  @override
  String get deleteWarranty => 'వారంటీని తొలగించాలా?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'ఈ పరికరం నుండి $name మరియు దాని అన్ని జోడింపులను తొలగించాలా? దీన్ని రద్దు చేసి తిరిగి పొందలేరు.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ఇంకా $count రోజులు ఉన్నాయి',
      one: 'ఇంకా 1 రోజు ఉంది',
      zero: 'ఈరోజే గడువు ముగుస్తుంది',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count వారంటీలు',
      one: '1 వారంటీ',
      zero: 'వారంటీలు లేవు',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'ఈ ఫీల్డ్ తప్పనిసరి.';

  @override
  String get invalidDuration => '1 నుండి 1,200 నెలల వరకు నమోదు చేయండి.';

  @override
  String get invalidPrice =>
      'దశాంశ బిందువు తర్వాత గరిష్ఠంగా రెండు అంకెలతో మొత్తాన్ని నమోదు చేయండి.';

  @override
  String get invalidCurrency =>
      'USD వంటి మూడు అక్షరాల కరెన్సీ కోడ్‌ను నమోదు చేయండి.';

  @override
  String get invalidEmail =>
      'చెల్లుబాటు అయ్యే ఇమెయిల్ చిరునామాను నమోదు చేయండి.';

  @override
  String get discardChanges => 'సేవ్ చేయని మార్పులను విస్మరించాలా?';

  @override
  String get discard => 'విస్మరించండి';

  @override
  String get keepEditing => 'సవరణను కొనసాగించండి';

  @override
  String get restoreBackup => 'బ్యాకప్‌ను పునరుద్ధరించండి';

  @override
  String get exportBackup => 'బ్యాకప్‌ను ఎగుమతి చేయండి';

  @override
  String get exportCsv => 'CSVని ఎగుమతి చేయండి';

  @override
  String get backupExplanation =>
      'ఒక ZIP ఫైల్‌లో మీ వారంటీలు, పరిచయాలు, ప్రాధాన్యతలు, అసలు జోడింపులు ఉంటాయి. దాన్ని మరో పరికరానికి తరలించి అక్కడ పునరుద్ధరించండి. ఇది మీరు స్వయంగా చేసే బదిలీ, ఆటోమేటిక్ సింక్ కాదు.';

  @override
  String get backupPrivacy =>
      'బ్యాకప్‌లు ఎన్‌క్రిప్ట్ చేయబడవు. వాటిని సురక్షిత ప్రదేశంలో ఉంచండి. Kepliకి క్లౌడ్ సేవ లేదు; సిస్టమ్ షేర్ ప్యానెల్‌లో మీరు ఎంచుకునే గమ్యస్థానాలు మీ నియంత్రణలో ఉంటాయి.';

  @override
  String get chooseBackup => 'బ్యాకప్ ఫైల్‌ను ఎంచుకోండి';

  @override
  String get backupPreview => 'బ్యాకప్‌ను సమీక్షించండి';

  @override
  String backupSummary(int items, int files) {
    return '$items వారంటీలు, $files జోడింపులు';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$dateన $platformలో ఎగుమతి చేయబడింది';
  }

  @override
  String get merge => 'విలీనం చేయండి';

  @override
  String get mergeHelp =>
      'కొత్త వారంటీలను జోడించి, సరిపోలే వారంటీలలో మరింత కొత్త సంస్కరణను ఉంచండి. ప్రస్తుత ప్రాధాన్యతలు అలాగే ఉంటాయి.';

  @override
  String get replaceAll => 'అన్నింటినీ భర్తీ చేయండి';

  @override
  String get replaceHelp =>
      'ఈ పరికరంలోని వారంటీలు, ప్రాధాన్యతలను బ్యాకప్‌లోని వాటితో భర్తీ చేయండి.';

  @override
  String replaceConfirmation(int count) {
    return 'ఈ పరికరంలోని మొత్తం $count వారంటీలను శాశ్వతంగా భర్తీ చేయాలా? వాటిని ఉంచుకోవాలంటే ముందుగా బ్యాకప్‌ను ఎగుమతి చేయండి.';
  }

  @override
  String get confirmReplace => 'అన్ని వారంటీలను భర్తీ చేయండి';

  @override
  String get conflicts => 'సరిపోలే వారంటీలు';

  @override
  String get keepLocal => 'ఈ పరికరంలోని సంస్కరణను ఉంచండి';

  @override
  String get useBackup => 'బ్యాకప్‌లోని మరింత కొత్త సంస్కరణను వాడండి';

  @override
  String get newerWinsHelp =>
      'సాధారణంగా ఇటీవల అప్‌డేట్ చేసిన సంస్కరణకు ప్రాధాన్యత ఉంటుంది. సమయ ముద్రలు సమానంగా ఉంటే ఈ పరికరంలోని సంస్కరణ ఉంటుంది. బదులుగా స్థానిక సంస్కరణను ఉంచేందుకు కింద వారంటీలను ఎంచుకోండి.';

  @override
  String get restore => 'పునరుద్ధరించండి';

  @override
  String get notifications => 'రిమైండర్‌లు';

  @override
  String get enableReminders => 'గడువు ముగింపు రిమైండర్‌లను ప్రారంభించండి';

  @override
  String get reminderDays => 'గడువు ముగియడానికి ముందు రోజులు';

  @override
  String get reminderDaysHelp =>
      'విలువలను కామాలతో వేరు చేయండి, ఉదాహరణకు 30, 7, 1. గడువు ముగిసే తేదీకి 0 వాడండి.';

  @override
  String get reminderHour => 'రిమైండర్ గంట (0–23)';

  @override
  String get reminderLimit =>
      'ఆపరేటింగ్ సిస్టమ్ క్యూలో అతి సమీప రిమైండర్‌లకు మాత్రమే చోటు ఉంటుంది. తదుపరి రిమైండర్‌లను చేర్చడానికి Kepliని క్రమం తప్పకుండా తెరవండి.';

  @override
  String get notificationPrivacy =>
      'రిమైండర్‌లు స్థానికంగా షెడ్యూల్ చేయబడతాయి. అనుమతులు, బ్యాటరీ సెట్టింగ్‌లు, ఆపరేటింగ్ సిస్టమ్ వల్ల అవి ఆలస్యం కావచ్చు లేదా ఆగిపోవచ్చు. త్వరలో గడువు ముగిసే వారంటీల జాబితా ఎల్లప్పుడూ అందుబాటులో ఉంటుంది.';

  @override
  String get permissionRequired => 'నోటిఫికేషన్ అనుమతి అవసరం.';

  @override
  String get requestPermission => 'అనుమతి కోరండి';

  @override
  String get remindersOff => 'రిమైండర్‌లు ఆఫ్‌లో ఉన్నాయి.';

  @override
  String get remindersUnavailable =>
      'సిస్టమ్ రిమైండర్‌లు అందుబాటులో లేవు. త్వరలో గడువు ముగిసే వారంటీల జాబితాను ఉపయోగించండి.';

  @override
  String remindersScheduled(int count) {
    return '$count రిమైండర్‌లు షెడ్యూల్ చేయబడ్డాయి.';
  }

  @override
  String get linuxReminderHelp =>
      'Linuxలో Kepli తెరిచి ఉన్నప్పుడు, నోటిఫికేషన్ సేవ అందుబాటులో ఉన్నప్పుడు మాత్రమే రిమైండర్‌లు పనిచేస్తాయి.';

  @override
  String get accessibility => 'యాక్సెసిబిలిటీ';

  @override
  String get highContrast => 'కాంట్రాస్ట్ పెంచండి';

  @override
  String get reduceMotion => 'చలనాన్ని తగ్గించండి';

  @override
  String get accessibilityHelp =>
      'Kepli మీ సిస్టమ్‌లోని అక్షరాల పరిమాణం, స్క్రీన్ రీడర్, కాంట్రాస్ట్, చలనాన్ని తగ్గించే సెట్టింగ్‌లను కూడా అనుసరిస్తుంది. ప్రతి చర్యను సంజ్ఞలు లేకుండానే చేయవచ్చు.';

  @override
  String get language => 'భాష';

  @override
  String get languageHelp =>
      'ఇంటర్‌ఫేస్ భాషను ఎంచుకోండి. డిఫాల్ట్ భాష ఆంగ్లం. మీరు సేవ్ చేసిన రికార్డుల వచనం అనువదించబడదు.';

  @override
  String get categories => 'వర్గాలు';

  @override
  String get addCategory => 'వర్గాన్ని జోడించండి';

  @override
  String get renameCategory => 'వర్గం పేరు మార్చండి';

  @override
  String get deleteCategory => 'వర్గాన్ని తొలగించండి';

  @override
  String get categoryInUse =>
      'ఒక వారంటీ ఈ వర్గాన్ని ఉపయోగిస్తోంది. ముందుగా ఆ వారంటీ వర్గాన్ని మార్చండి.';

  @override
  String get newCategory => 'వర్గం పేరు';

  @override
  String get categoryExists => 'ఆ వర్గం ఇప్పటికే ఉంది.';

  @override
  String get categoryElectronics => 'ఎలక్ట్రానిక్ వస్తువులు';

  @override
  String get categoryAppliances => 'గృహోపకరణాలు';

  @override
  String get categoryTools => 'పనిముట్లు';

  @override
  String get categoryOther => 'ఇతర';

  @override
  String get exportReports => 'నివేదికలు';

  @override
  String get about => 'Kepli గురించి';

  @override
  String get privacyTitle => 'స్థానికం. వ్యక్తిగతం. మీ సొంతం.';

  @override
  String get privacyBody =>
      'ఖాతా, చందా, వినియోగ విశ్లేషణలు లేదా Kepli క్లౌడ్ ఏవీ లేవు. మీరు ఎగుమతి చేసే లేదా షేర్ చేసే వరకు మీ రికార్డులు ఈ యాప్ నిల్వలోనే ఉంటాయి. క్రమం తప్పకుండా బ్యాకప్‌లను ఎగుమతి చేయండి: యాప్‌ను అన్‌ఇన్‌స్టాల్ చేయడం లేదా పరికరం పోవడం వల్ల మీ డేటా పోవచ్చు.';

  @override
  String get appVersion => 'సంస్కరణ';

  @override
  String get operationFailed => 'చర్యను పూర్తి చేయలేకపోయాము.';

  @override
  String get technicalDetails => 'సాంకేతిక వివరాలు';

  @override
  String get saved => 'వారంటీ ఈ పరికరంలో సేవ్ చేయబడింది.';

  @override
  String get deleted => 'వారంటీ, దాని జోడింపులు తొలగించబడ్డాయి.';

  @override
  String get restored =>
      'బ్యాకప్ పునరుద్ధరించబడింది. సూచించిన అన్ని జోడింపులు ధృవీకరించబడ్డాయి.';

  @override
  String get settingsSaved => 'సెట్టింగ్‌లు సేవ్ చేయబడ్డాయి.';

  @override
  String get exportReady => 'ఎగుమతి సిద్ధంగా ఉంది.';

  @override
  String get exportCancelled => 'ఎగుమతి రద్దు చేయబడింది.';

  @override
  String fileSavedTo(String path) {
    return 'ఫైల్ $pathలో సేవ్ చేయబడింది';
  }

  @override
  String get shareOpened =>
      'షేర్ ప్యానెల్‌లో ఫైల్‌ను ఎక్కడ సేవ్ చేయాలో లేదా పంపాలో ఎంచుకోండి.';

  @override
  String get loading => 'లోడ్ అవుతోంది';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get startupError =>
      'Kepli మీ స్థానిక డేటాను తెరవలేకపోయింది. ఇప్పటికే ఉన్న మీ ఫైళ్లు రీసెట్ చేయబడలేదు.';

  @override
  String get unavailableImage =>
      'చిత్రం ప్రివ్యూ అందుబాటులో లేదు. మీరు ఇప్పటికీ అసలు ఫైల్‌ను తెరవవచ్చు.';

  @override
  String get largeAttachmentTitle => 'పెద్ద జోడింపు';

  @override
  String largeAttachmentWarning(String size) {
    return 'ఈ ఫైల్ పరిమాణం $size MB. పెద్ద జోడింపులు బ్యాకప్‌లను నెమ్మదింపజేస్తాయి, ఎక్కువ నిల్వ స్థలాన్ని తీసుకుంటాయి.';
  }

  @override
  String get continueAction => 'కొనసాగించండి';

  @override
  String get recoverPhoto => 'తిరిగి పొందిన ఫోటోను వాడండి';

  @override
  String get recoveredPhotoHelp =>
      'కెమెరా వల్ల యాప్ పునఃప్రారంభమైన తర్వాత ఒక ఫోటో తిరిగి పొందబడింది. అది పోకుండా ఉండేందుకు ఒక వారంటీకి జోడించండి.';

  @override
  String get dismiss => 'విస్మరించండి';

  @override
  String get busy => 'చర్య జరుగుతోంది. దయచేసి వేచి ఉండండి.';

  @override
  String get menu => 'మెనూ';

  @override
  String get sortHint => 'అతి త్వరగా గడువు ముగిసే క్రమంలో';

  @override
  String get requiredFields =>
      'పేరు, వర్గం, కొనుగోలు తేదీ, వారంటీ వ్యవధి తప్పనిసరి.';

  @override
  String get chooseDate => 'కొనుగోలు తేదీని ఎంచుకోండి';

  @override
  String get selected => 'ఎంచుకోబడింది';

  @override
  String get notSet => 'సెట్ చేయలేదు';

  @override
  String get reportTitle => 'వారంటీ నివేదిక';

  @override
  String get pdfReferences =>
      'PDF రసీదులు, వారంటీ పత్రాలు ఫైల్ పేర్లతో జాబితాలో ఉంటాయి. అవసరమైనప్పుడు వాటి అసలు ఫైళ్లను విడిగా షేర్ చేయండి.';

  @override
  String get documentFooter =>
      'Kepli ద్వారా స్థానికంగా రూపొందించబడింది. ఈ నివేదిక పునరుద్ధరించగల బ్యాకప్ కాదు.';

  @override
  String get notificationTitle => 'వారంటీ గడువు ముగుస్తోంది';

  @override
  String notificationBody(String name, String date) {
    return '$name: వారంటీ గడువు $dateన ముగుస్తుంది.';
  }

  @override
  String get contacts => 'అమ్మకాలు, సేవల సంప్రదింపులు';

  @override
  String get addContact => 'పరిచయాన్ని జోడించండి';

  @override
  String get editContact => 'పరిచయాన్ని సవరించండి';

  @override
  String get removeContact => 'పరిచయాన్ని తీసివేయండి';

  @override
  String get salesContact => 'అమ్మకాలు';

  @override
  String get serviceContact => 'సేవ';

  @override
  String get contactName => 'సంప్రదించాల్సిన వ్యక్తి';

  @override
  String get organization => 'కంపెనీ లేదా సంస్థ';

  @override
  String get phone => 'ఫోన్';

  @override
  String get email => 'ఇమెయిల్';

  @override
  String get contactNotes => 'పరిచయ గమనికలు';

  @override
  String get noContacts => 'పరిచయాలు జోడించలేదు';

  @override
  String get businessCard => 'విజిటింగ్ కార్డు';

  @override
  String get scanBusinessCard => 'విజిటింగ్ కార్డును స్కాన్ చేయండి';

  @override
  String get addBusinessCard => 'విజిటింగ్ కార్డును జోడించండి';

  @override
  String get businessCardHelp =>
      'కార్డు ఫోటో తీయండి లేదా దిగుమతి చేసి ఈ పరిచయానికి జోడించండి. కింద వ్యక్తి వివరాలను నమోదు చేయండి; Kepli క్లౌడ్ ఆధారిత అక్షర గుర్తింపును ఉపయోగించదు.';

  @override
  String get businessCardNeedsContact =>
      'విజిటింగ్ కార్డును జోడించే ముందు పరిచయం పేరును సేవ్ చేయండి.';

  @override
  String get scanDocument => 'పత్రాన్ని స్కాన్ చేయండి';

  @override
  String get scanHelp =>
      'పేజీల ఫోటోలు తీయండి లేదా చిత్రాలను ఎంచుకోండి. ఆపై కత్తిరించి, తిప్పి, ఒకే PDFగా సేవ్ చేయండి. ప్రాసెసింగ్ ఈ పరికరంలోనే జరుగుతుంది; వచనం స్వయంచాలకంగా వెలికితీయబడదు.';

  @override
  String get addPage => 'పేజీని జోడించండి';

  @override
  String get removePage => 'పేజీని తీసివేయండి';

  @override
  String get rotatePage => 'పేజీని తిప్పండి';

  @override
  String pageNumber(int number) {
    return 'పేజీ $number';
  }

  @override
  String get cropTop => 'పై నుండి కత్తిరించండి';

  @override
  String get cropBottom => 'కింది నుండి కత్తిరించండి';

  @override
  String get cropLeft => 'ఎడమ నుండి కత్తిరించండి';

  @override
  String get cropRight => 'కుడి నుండి కత్తిరించండి';

  @override
  String get enhanceDocument => 'పత్రం కాంట్రాస్ట్‌ను పెంచండి';

  @override
  String get saveScan => 'స్కాన్‌ను PDFగా సేవ్ చేయండి';

  @override
  String get scanName => 'పత్రం పేరు';

  @override
  String get noPages => 'కనీసం ఒక పేజీని జోడించండి.';

  @override
  String get desktopScanHelp =>
      'స్కానర్ లేదా కెమెరాతో సేవ్ చేసిన చిత్రాలను ఎంచుకోండి. స్కానర్ హార్డ్‌వేర్‌ను నేరుగా నియంత్రించాల్సిన అవసరం లేదు.';

  @override
  String get attachmentType => 'జోడింపు రకం';

  @override
  String get previousPage => 'మునుపటి పేజీ';

  @override
  String get nextPage => 'తదుపరి పేజీ';

  @override
  String get processingDocument => 'ఈ పరికరంలో పత్రం ప్రాసెస్ అవుతోంది';

  @override
  String get readOnlyDetails => 'వారంటీ వివరాలు';

  @override
  String get selectWarranty => 'వివరాలు చూడటానికి వారంటీని ఎంచుకోండి.';
}
