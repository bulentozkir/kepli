// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'तुमच्या वॉरंटी. तुमच्या पावत्या. तुमच्याच ताब्यात.';

  @override
  String get warranties => 'वॉरंटी';

  @override
  String get backups => 'बॅकअप';

  @override
  String get settings => 'सेटिंग्ज';

  @override
  String get addWarranty => 'वॉरंटी जोडा';

  @override
  String get editWarranty => 'वॉरंटी संपादित करा';

  @override
  String get save => 'जतन करा';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get delete => 'हटवा';

  @override
  String get close => 'बंद करा';

  @override
  String get edit => 'संपादित करा';

  @override
  String get searchHint => 'नाव, दुकान किंवा श्रेणी शोधा';

  @override
  String get all => 'सर्व';

  @override
  String get active => 'वैध';

  @override
  String get expiringSoon => 'लवकरच मुदत संपणाऱ्या';

  @override
  String get expired => 'मुदत संपलेली';

  @override
  String get claimed => 'दावा केलेला';

  @override
  String get noWarranties => 'अद्याप कोणतीही वॉरंटी नाही';

  @override
  String get getStarted =>
      'एखादी खरेदी जोडा आणि तिची पावती, वॉरंटीची कागदपत्रे व संपर्क एकत्र ठेवा.';

  @override
  String get noMatches => 'जुळणाऱ्या वॉरंटी नाहीत';

  @override
  String get clearFilters => 'फिल्टर काढा';

  @override
  String get purchaseDate => 'खरेदीची तारीख';

  @override
  String get expiryDate => 'मुदत संपण्याची तारीख';

  @override
  String get warrantyLength => 'वॉरंटीचा कालावधी';

  @override
  String get months => 'महिने';

  @override
  String get years => 'वर्षे';

  @override
  String get name => 'नाव';

  @override
  String get nameHint => 'उदाहरणार्थ, स्वयंपाकघरातील फ्रिज';

  @override
  String get category => 'श्रेणी';

  @override
  String get vendor => 'दुकान किंवा विक्रेता';

  @override
  String get price => 'किंमत (ऐच्छिक)';

  @override
  String get currency => 'चलनाचा कोड';

  @override
  String get notes => 'नोंदी';

  @override
  String get productPhoto => 'उत्पादनाचा फोटो';

  @override
  String get receipt => 'पावती';

  @override
  String get warrantyPaper => 'वॉरंटीचे कागदपत्र';

  @override
  String get attachments => 'जोडलेल्या फाइल';

  @override
  String get addFiles => 'फाइल जोडा';

  @override
  String get takePhoto => 'फोटो काढा';

  @override
  String get choosePhoto => 'फोटो निवडा';

  @override
  String get removeAttachment => 'जोडलेली फाइल काढा';

  @override
  String get openAttachment => 'जोडलेली फाइल उघडा';

  @override
  String get markClaimed => 'दावा केलेला म्हणून चिन्हांकित करा';

  @override
  String get markActive => 'दावा केल्याची खूण काढा';

  @override
  String get exportPdf => 'वॉरंटीची PDF निर्यात करा';

  @override
  String get deleteWarranty => 'वॉरंटी हटवायची?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'या डिव्हाइसवरून $name आणि त्याला जोडलेल्या सर्व फाइल हटवायच्या? हे पूर्ववत करता येणार नाही.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिवस बाकी',
      one: '1 दिवस बाकी',
      zero: 'आज मुदत संपते',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वॉरंटी',
      one: '1 वॉरंटी',
      zero: 'कोणतीही वॉरंटी नाही',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'हे क्षेत्र भरणे आवश्यक आहे.';

  @override
  String get invalidDuration => '1 ते 1,200 महिने प्रविष्ट करा.';

  @override
  String get invalidPrice =>
      'दशांश चिन्हानंतर जास्तीत जास्त दोन अंक असलेली रक्कम प्रविष्ट करा.';

  @override
  String get invalidCurrency => 'तीन अक्षरी चलन कोड प्रविष्ट करा, जसे की USD.';

  @override
  String get invalidEmail => 'वैध ईमेल पत्ता प्रविष्ट करा.';

  @override
  String get discardChanges => 'जतन न केलेले बदल टाकून द्यायचे?';

  @override
  String get discard => 'टाकून द्या';

  @override
  String get keepEditing => 'संपादन सुरू ठेवा';

  @override
  String get restoreBackup => 'बॅकअप पुनर्संचयित करा';

  @override
  String get exportBackup => 'बॅकअप निर्यात करा';

  @override
  String get exportCsv => 'CSV निर्यात करा';

  @override
  String get backupExplanation =>
      'एका ZIP फाइलमध्ये तुमच्या वॉरंटी, संपर्क, प्राधान्ये आणि मूळ जोडलेल्या फाइल असतात. ती दुसऱ्या डिव्हाइसवर नेऊन तिथे पुनर्संचयित करा. हे स्वतः करायचे हस्तांतरण आहे, स्वयंचलित सिंक नाही.';

  @override
  String get backupPrivacy =>
      'बॅकअप एन्क्रिप्ट केलेले नसतात. ते सुरक्षित ठिकाणी ठेवा. Kepli ची कोणतीही क्लाउड सेवा नाही; सिस्टमच्या शेअर पॅनेलमध्ये तुम्ही निवडलेली ठिकाणे तुमच्या नियंत्रणात असतात.';

  @override
  String get chooseBackup => 'बॅकअप फाइल निवडा';

  @override
  String get backupPreview => 'बॅकअप तपासा';

  @override
  String backupSummary(int items, int files) {
    return '$items वॉरंटी आणि $files जोडलेल्या फाइल';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date रोजी $platform वर निर्यात केले';
  }

  @override
  String get merge => 'एकत्र करा';

  @override
  String get mergeHelp =>
      'नवीन वॉरंटी जोडा आणि जुळणाऱ्या वॉरंटींची अधिक नवीन आवृत्ती ठेवा. सध्याची प्राधान्ये कायम राहतील.';

  @override
  String get replaceAll => 'सर्व बदला';

  @override
  String get replaceHelp =>
      'या डिव्हाइसवरील वॉरंटी आणि प्राधान्ये बॅकअपमधील माहितीने बदला.';

  @override
  String replaceConfirmation(int count) {
    return 'या डिव्हाइसवरील सर्व $count वॉरंटी कायमस्वरूपी बदलायच्या? त्या ठेवायच्या असल्यास आधी बॅकअप निर्यात करा.';
  }

  @override
  String get confirmReplace => 'सर्व वॉरंटी बदला';

  @override
  String get conflicts => 'जुळणाऱ्या वॉरंटी';

  @override
  String get keepLocal => 'या डिव्हाइसवरील आवृत्ती ठेवा';

  @override
  String get useBackup => 'बॅकअपमधील अधिक नवीन आवृत्ती वापरा';

  @override
  String get newerWinsHelp =>
      'सहसा अधिक अलीकडे अद्ययावत केलेली आवृत्ती ठेवली जाते. वेळेच्या नोंदी समान असल्यास या डिव्हाइसवरील आवृत्ती ठेवली जाते. त्याऐवजी स्थानिक आवृत्ती ठेवण्यासाठी खाली वॉरंटी निवडा.';

  @override
  String get restore => 'पुनर्संचयित करा';

  @override
  String get notifications => 'स्मरणपत्रे';

  @override
  String get enableReminders => 'मुदत संपण्याची स्मरणपत्रे सुरू करा';

  @override
  String get reminderDays => 'मुदत संपण्यापूर्वीचे दिवस';

  @override
  String get reminderDaysHelp =>
      'मूल्ये स्वल्पविरामाने वेगळी करा, जसे की 30, 7, 1. मुदत संपण्याच्या तारखेसाठी 0 वापरा.';

  @override
  String get reminderHour => 'स्मरणपत्राची वेळ (तास 0–23)';

  @override
  String get reminderLimit =>
      'ऑपरेटिंग सिस्टमच्या रांगेत फक्त सर्वात जवळची स्मरणपत्रे मावतात. पुढील स्मरणपत्रे भरण्यासाठी Kepli नियमितपणे उघडा.';

  @override
  String get notificationPrivacy =>
      'स्मरणपत्रे स्थानिकपणे नियोजित केली जातात. परवानग्या, बॅटरी सेटिंग्ज आणि ऑपरेटिंग सिस्टममुळे ती उशिरा येऊ शकतात किंवा थांबू शकतात. लवकरच मुदत संपणाऱ्या वॉरंटींची यादी नेहमी उपलब्ध असते.';

  @override
  String get permissionRequired => 'सूचनांची परवानगी आवश्यक आहे.';

  @override
  String get requestPermission => 'परवानगी मागा';

  @override
  String get remindersOff => 'स्मरणपत्रे बंद आहेत.';

  @override
  String get remindersUnavailable =>
      'सिस्टमची स्मरणपत्रे उपलब्ध नाहीत. लवकरच मुदत संपणाऱ्या वॉरंटींची यादी वापरा.';

  @override
  String remindersScheduled(int count) {
    return '$count स्मरणपत्रे नियोजित केली.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux वर Kepli उघडे असताना आणि सूचना सेवा उपलब्ध असतानाच स्मरणपत्रे काम करतात.';

  @override
  String get accessibility => 'सुलभता';

  @override
  String get highContrast => 'कॉन्ट्रास्ट वाढवा';

  @override
  String get reduceMotion => 'हालचाल कमी करा';

  @override
  String get accessibilityHelp =>
      'Kepli तुमच्या सिस्टममधील मजकुराचा आकार, स्क्रीन रीडर, कॉन्ट्रास्ट आणि हालचाल कमी करण्याच्या सेटिंग्जचेही पालन करते. प्रत्येक कृती जेश्चरशिवाय करता येते.';

  @override
  String get language => 'भाषा';

  @override
  String get languageHelp =>
      'इंटरफेसची भाषा निवडा. इंग्रजी ही डीफॉल्ट भाषा आहे. तुमच्या जतन केलेल्या नोंदींतील मजकुराचे भाषांतर केले जात नाही.';

  @override
  String get categories => 'श्रेणी';

  @override
  String get addCategory => 'श्रेणी जोडा';

  @override
  String get renameCategory => 'श्रेणीचे नाव बदला';

  @override
  String get deleteCategory => 'श्रेणी हटवा';

  @override
  String get categoryInUse =>
      'ही श्रेणी एका वॉरंटीसाठी वापरली जात आहे. आधी त्या वॉरंटीची श्रेणी बदला.';

  @override
  String get newCategory => 'श्रेणीचे नाव';

  @override
  String get categoryExists => 'ही श्रेणी आधीच अस्तित्वात आहे.';

  @override
  String get categoryElectronics => 'इलेक्ट्रॉनिक वस्तू';

  @override
  String get categoryAppliances => 'घरगुती उपकरणे';

  @override
  String get categoryTools => 'अवजारे';

  @override
  String get categoryOther => 'इतर';

  @override
  String get exportReports => 'अहवाल';

  @override
  String get about => 'Kepli विषयी';

  @override
  String get privacyTitle => 'स्थानिक. खाजगी. तुमचे.';

  @override
  String get privacyBody =>
      'खाते नाही, सदस्यता नाही, वापराचे विश्लेषण नाही किंवा Kepli क्लाउडही नाही. तुम्ही निर्यात किंवा शेअर करेपर्यंत तुमच्या नोंदी या अॅपच्या साठवणुकीतच राहतात. नियमितपणे बॅकअप निर्यात करा: अॅप अनइन्स्टॉल केल्यास किंवा डिव्हाइस हरवल्यास तुमचा डेटा नष्ट होऊ शकतो.';

  @override
  String get appVersion => 'आवृत्ती';

  @override
  String get operationFailed => 'क्रिया पूर्ण करता आली नाही.';

  @override
  String get technicalDetails => 'तांत्रिक तपशील';

  @override
  String get saved => 'वॉरंटी या डिव्हाइसवर जतन केली.';

  @override
  String get deleted => 'वॉरंटी आणि तिला जोडलेल्या फाइल हटवल्या.';

  @override
  String get restored =>
      'बॅकअप पुनर्संचयित केला. संदर्भ दिलेल्या सर्व जोडलेल्या फाइल पडताळल्या.';

  @override
  String get settingsSaved => 'सेटिंग्ज जतन केल्या.';

  @override
  String get exportReady => 'निर्यात तयार आहे.';

  @override
  String get exportCancelled => 'निर्यात रद्द केली.';

  @override
  String fileSavedTo(String path) {
    return 'फाइल $path येथे जतन केली';
  }

  @override
  String get shareOpened =>
      'शेअर पॅनेलमध्ये फाइल कुठे जतन करायची किंवा पाठवायची ते निवडा.';

  @override
  String get loading => 'लोड होत आहे';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get startupError =>
      'Kepli ला तुमचा स्थानिक डेटा उघडता आला नाही. तुमच्या विद्यमान फाइल रीसेट केलेल्या नाहीत.';

  @override
  String get unavailableImage =>
      'प्रतिमेचे पूर्वावलोकन उपलब्ध नाही. तुम्ही तरीही मूळ फाइल उघडू शकता.';

  @override
  String get largeAttachmentTitle => 'मोठी जोडलेली फाइल';

  @override
  String largeAttachmentWarning(String size) {
    return 'या फाइलचा आकार $size MB आहे. मोठ्या फाइल जोडल्याने बॅकअपला जास्त वेळ लागतो आणि अधिक साठवणूक लागते.';
  }

  @override
  String get continueAction => 'पुढे चला';

  @override
  String get recoverPhoto => 'पुनर्प्राप्त फोटो वापरा';

  @override
  String get recoveredPhotoHelp =>
      'कॅमेऱ्यामुळे अॅप पुन्हा सुरू झाल्यानंतर एक फोटो पुनर्प्राप्त झाला. तो हरवू नये म्हणून एखाद्या वॉरंटीला जोडा.';

  @override
  String get dismiss => 'दुर्लक्ष करा';

  @override
  String get busy => 'क्रिया सुरू आहे. कृपया प्रतीक्षा करा.';

  @override
  String get menu => 'मेनू';

  @override
  String get sortHint => 'सर्वात आधी मुदत संपणाऱ्या क्रमाने लावलेले';

  @override
  String get requiredFields =>
      'नाव, श्रेणी, खरेदीची तारीख आणि वॉरंटीचा कालावधी आवश्यक आहे.';

  @override
  String get chooseDate => 'खरेदीची तारीख निवडा';

  @override
  String get selected => 'निवडलेले';

  @override
  String get notSet => 'सेट केलेले नाही';

  @override
  String get reportTitle => 'वॉरंटी अहवाल';

  @override
  String get pdfReferences =>
      'PDF पावत्या आणि वॉरंटीची कागदपत्रे फाइलच्या नावाने सूचीबद्ध आहेत. गरज पडल्यास त्यांच्या मूळ फाइल स्वतंत्रपणे शेअर करा.';

  @override
  String get documentFooter =>
      'Kepli ने स्थानिकपणे तयार केले. हा अहवाल पुनर्संचयित करता येणारा बॅकअप नाही.';

  @override
  String get notificationTitle => 'वॉरंटीची मुदत संपत आहे';

  @override
  String notificationBody(String name, String date) {
    return '$name: वॉरंटीची मुदत $date रोजी संपते.';
  }

  @override
  String get contacts => 'विक्री आणि सेवा संपर्क';

  @override
  String get addContact => 'संपर्क जोडा';

  @override
  String get editContact => 'संपर्क संपादित करा';

  @override
  String get removeContact => 'संपर्क काढा';

  @override
  String get salesContact => 'विक्री';

  @override
  String get serviceContact => 'सेवा';

  @override
  String get contactName => 'संपर्क व्यक्ती';

  @override
  String get organization => 'कंपनी किंवा संस्था';

  @override
  String get phone => 'फोन';

  @override
  String get email => 'ईमेल';

  @override
  String get contactNotes => 'संपर्काच्या नोंदी';

  @override
  String get noContacts => 'कोणतेही संपर्क जोडलेले नाहीत';

  @override
  String get businessCard => 'व्यवसाय कार्ड';

  @override
  String get scanBusinessCard => 'व्यवसाय कार्ड स्कॅन करा';

  @override
  String get addBusinessCard => 'व्यवसाय कार्ड जोडा';

  @override
  String get businessCardHelp =>
      'कार्डचा फोटो काढा किंवा आयात करा आणि या संपर्काला जोडा. खाली त्या व्यक्तीचे तपशील प्रविष्ट करा; Kepli क्लाउडवरील अक्षर ओळख वापरत नाही.';

  @override
  String get businessCardNeedsContact =>
      'व्यवसाय कार्ड जोडण्यापूर्वी संपर्काचे नाव जतन करा.';

  @override
  String get scanDocument => 'कागदपत्र स्कॅन करा';

  @override
  String get scanHelp =>
      'पानांचे फोटो काढा किंवा प्रतिमा निवडा, नंतर कापा, फिरवा आणि एक PDF म्हणून जतन करा. प्रक्रिया याच डिव्हाइसवर होते; मजकूर आपोआप काढला जात नाही.';

  @override
  String get addPage => 'पान जोडा';

  @override
  String get removePage => 'पान काढा';

  @override
  String get rotatePage => 'पान फिरवा';

  @override
  String pageNumber(int number) {
    return 'पान $number';
  }

  @override
  String get cropTop => 'वरून कापा';

  @override
  String get cropBottom => 'खालून कापा';

  @override
  String get cropLeft => 'डावीकडून कापा';

  @override
  String get cropRight => 'उजवीकडून कापा';

  @override
  String get enhanceDocument => 'कागदपत्राचा कॉन्ट्रास्ट वाढवा';

  @override
  String get saveScan => 'स्कॅन PDF म्हणून जतन करा';

  @override
  String get scanName => 'कागदपत्राचे नाव';

  @override
  String get noPages => 'किमान एक पान जोडा.';

  @override
  String get desktopScanHelp =>
      'स्कॅनर किंवा कॅमेऱ्याने जतन केलेल्या प्रतिमा निवडा. स्कॅनरच्या हार्डवेअरचे थेट नियंत्रण आवश्यक नाही.';

  @override
  String get attachmentType => 'जोडलेल्या फाइलचा प्रकार';

  @override
  String get previousPage => 'मागील पान';

  @override
  String get nextPage => 'पुढील पान';

  @override
  String get processingDocument =>
      'या डिव्हाइसवर कागदपत्रावर प्रक्रिया होत आहे';

  @override
  String get readOnlyDetails => 'वॉरंटीचे तपशील';

  @override
  String get selectWarranty => 'तपशील पाहण्यासाठी वॉरंटी निवडा.';
}
