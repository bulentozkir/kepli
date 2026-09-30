// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'आपकी वारंटियाँ। आपकी रसीदें। सब आपके पास।';

  @override
  String get warranties => 'वारंटियाँ';

  @override
  String get backups => 'बैकअप';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get addWarranty => 'वारंटी जोड़ें';

  @override
  String get editWarranty => 'वारंटी संपादित करें';

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'मिटाएँ';

  @override
  String get close => 'बंद करें';

  @override
  String get edit => 'संपादित करें';

  @override
  String get searchHint => 'नाम, दुकान या श्रेणी खोजें';

  @override
  String get all => 'सभी';

  @override
  String get active => 'मान्य';

  @override
  String get expiringSoon => 'जल्द समाप्त होने वाली';

  @override
  String get expired => 'समाप्त';

  @override
  String get claimed => 'दावा किया गया';

  @override
  String get noWarranties => 'अभी कोई वारंटी नहीं है';

  @override
  String get getStarted =>
      'कोई खरीद जोड़ें और उसकी रसीद, वारंटी के कागज़ और संपर्क एक साथ रखें।';

  @override
  String get noMatches => 'कोई मेल खाती वारंटी नहीं मिली';

  @override
  String get clearFilters => 'फ़िल्टर हटाएँ';

  @override
  String get purchaseDate => 'खरीद की तारीख';

  @override
  String get expiryDate => 'समाप्ति की तारीख';

  @override
  String get warrantyLength => 'वारंटी की अवधि';

  @override
  String get months => 'महीने';

  @override
  String get years => 'वर्ष';

  @override
  String get name => 'नाम';

  @override
  String get nameHint => 'जैसे, रसोई का फ़्रिज';

  @override
  String get category => 'श्रेणी';

  @override
  String get vendor => 'दुकान या विक्रेता';

  @override
  String get price => 'कीमत (वैकल्पिक)';

  @override
  String get currency => 'मुद्रा कोड';

  @override
  String get notes => 'नोट्स';

  @override
  String get productPhoto => 'उत्पाद की फ़ोटो';

  @override
  String get receipt => 'रसीद';

  @override
  String get warrantyPaper => 'वारंटी का कागज़';

  @override
  String get attachments => 'संलग्नक';

  @override
  String get addFiles => 'फ़ाइलें जोड़ें';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get choosePhoto => 'फ़ोटो चुनें';

  @override
  String get removeAttachment => 'संलग्नक हटाएँ';

  @override
  String get openAttachment => 'संलग्नक खोलें';

  @override
  String get markClaimed => 'दावा किया गया चिह्नित करें';

  @override
  String get markActive => 'दावा किए जाने का चिह्न हटाएँ';

  @override
  String get exportPdf => 'वारंटी की PDF निर्यात करें';

  @override
  String get deleteWarranty => 'वारंटी मिटाएँ?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'क्या इस डिवाइस से $name और उसके सभी संलग्नक मिटाएँ? इसे वापस नहीं किया जा सकता।';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन बाकी',
      one: '1 दिन बाकी',
      zero: 'आज समाप्त होगी',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वारंटियाँ',
      one: '1 वारंटी',
      zero: 'कोई वारंटी नहीं',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'यह फ़ील्ड भरना ज़रूरी है।';

  @override
  String get invalidDuration => '1 से 1,200 महीने दर्ज करें।';

  @override
  String get invalidPrice =>
      'दशमलव के बाद अधिकतम दो अंकों वाली राशि दर्ज करें।';

  @override
  String get invalidCurrency =>
      'तीन अक्षरों का मुद्रा कोड दर्ज करें, जैसे USD।';

  @override
  String get invalidEmail => 'मान्य ईमेल पता दर्ज करें।';

  @override
  String get discardChanges => 'बिना सहेजे बदलाव छोड़ दें?';

  @override
  String get discard => 'बदलाव छोड़ें';

  @override
  String get keepEditing => 'संपादन जारी रखें';

  @override
  String get restoreBackup => 'बैकअप बहाल करें';

  @override
  String get exportBackup => 'बैकअप निर्यात करें';

  @override
  String get exportCsv => 'CSV निर्यात करें';

  @override
  String get backupExplanation =>
      'एक ZIP फ़ाइल में आपकी वारंटियाँ, संपर्क, प्राथमिकताएँ और मूल संलग्नक होते हैं। इसे दूसरे डिवाइस पर ले जाकर वहाँ बहाल करें। यह मैन्युअल स्थानांतरण है, अपने-आप सिंक होना नहीं।';

  @override
  String get backupPrivacy =>
      'बैकअप एन्क्रिप्ट नहीं किए जाते। उन्हें सुरक्षित जगह रखें। Kepli की कोई क्लाउड सेवा नहीं है; सिस्टम के साझाकरण पैनल में चुने गए गंतव्य आपके नियंत्रण में हैं।';

  @override
  String get chooseBackup => 'बैकअप फ़ाइल चुनें';

  @override
  String get backupPreview => 'बैकअप की समीक्षा करें';

  @override
  String backupSummary(int items, int files) {
    return '$items वारंटियाँ और $files संलग्नक';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date को $platform पर निर्यात किया गया';
  }

  @override
  String get merge => 'मिलाएँ';

  @override
  String get mergeHelp =>
      'नई वारंटियाँ जोड़ें और मेल खाने वाली वारंटियों का नया संस्करण रखें। मौजूदा प्राथमिकताएँ बनी रहेंगी।';

  @override
  String get replaceAll => 'सभी बदलें';

  @override
  String get replaceHelp =>
      'इस डिवाइस की वारंटियाँ और प्राथमिकताएँ बैकअप से बदलें।';

  @override
  String replaceConfirmation(int count) {
    return 'क्या इस डिवाइस की सभी $count वारंटियाँ स्थायी रूप से बदलें? उन्हें रखना चाहते हैं तो पहले बैकअप निर्यात करें।';
  }

  @override
  String get confirmReplace => 'सभी वारंटियाँ बदलें';

  @override
  String get conflicts => 'मेल खाने वाली वारंटियाँ';

  @override
  String get keepLocal => 'इस डिवाइस का संस्करण रखें';

  @override
  String get useBackup => 'बैकअप का नया संस्करण इस्तेमाल करें';

  @override
  String get newerWinsHelp =>
      'आमतौर पर हाल में अपडेट किया गया संस्करण रखा जाता है। समय-मुद्राएँ समान होने पर इस डिवाइस का संस्करण रखा जाता है। इसके बजाय स्थानीय संस्करण रखने के लिए नीचे वारंटियाँ चुनें।';

  @override
  String get restore => 'बहाल करें';

  @override
  String get notifications => 'रिमाइंडर';

  @override
  String get enableReminders => 'समाप्ति के रिमाइंडर चालू करें';

  @override
  String get reminderDays => 'समाप्ति से पहले के दिन';

  @override
  String get reminderDaysHelp =>
      'मानों को कॉमा से अलग करें, जैसे 30, 7, 1। समाप्ति की तारीख के लिए 0 लिखें।';

  @override
  String get reminderHour => 'रिमाइंडर का घंटा (0–23)';

  @override
  String get reminderLimit =>
      'ऑपरेटिंग सिस्टम की कतार में केवल सबसे नज़दीकी रिमाइंडर आ पाते हैं। कतार में अगले रिमाइंडर जोड़ने के लिए Kepli नियमित रूप से खोलें।';

  @override
  String get notificationPrivacy =>
      'रिमाइंडर स्थानीय रूप से तय किए जाते हैं। अनुमतियों, बैटरी सेटिंग्स और ऑपरेटिंग सिस्टम के कारण वे देर से आ सकते हैं या रुक सकते हैं। जल्द समाप्त होने वाली वारंटियों की सूची हमेशा उपलब्ध रहती है।';

  @override
  String get permissionRequired => 'सूचनाओं की अनुमति ज़रूरी है।';

  @override
  String get requestPermission => 'अनुमति माँगें';

  @override
  String get remindersOff => 'रिमाइंडर बंद हैं।';

  @override
  String get remindersUnavailable =>
      'सिस्टम रिमाइंडर उपलब्ध नहीं हैं। जल्द समाप्त होने वाली वारंटियों की सूची देखें।';

  @override
  String remindersScheduled(int count) {
    return '$count रिमाइंडर तय किए गए।';
  }

  @override
  String get linuxReminderHelp =>
      'Linux पर रिमाइंडर तभी काम करते हैं जब Kepli खुला हो और सूचना सेवा उपलब्ध हो।';

  @override
  String get accessibility => 'सुलभता';

  @override
  String get highContrast => 'कंट्रास्ट बढ़ाएँ';

  @override
  String get reduceMotion => 'ऐनिमेशन कम करें';

  @override
  String get accessibilityHelp =>
      'Kepli आपके सिस्टम के टेक्स्ट आकार, स्क्रीन रीडर, कंट्रास्ट और कम ऐनिमेशन की सेटिंग्स का भी पालन करता है। हर काम जेस्चर के बिना किया जा सकता है।';

  @override
  String get language => 'भाषा';

  @override
  String get languageHelp =>
      'इंटरफ़ेस की भाषा चुनें। डिफ़ॉल्ट भाषा अंग्रेज़ी है। सहेजे गए रिकॉर्ड के टेक्स्ट का अनुवाद नहीं होता।';

  @override
  String get categories => 'श्रेणियाँ';

  @override
  String get addCategory => 'श्रेणी जोड़ें';

  @override
  String get renameCategory => 'श्रेणी का नाम बदलें';

  @override
  String get deleteCategory => 'श्रेणी मिटाएँ';

  @override
  String get categoryInUse =>
      'एक वारंटी में यह श्रेणी इस्तेमाल हो रही है। पहले उस वारंटी की श्रेणी बदलें।';

  @override
  String get newCategory => 'श्रेणी का नाम';

  @override
  String get categoryExists => 'यह श्रेणी पहले से मौजूद है।';

  @override
  String get categoryElectronics => 'इलेक्ट्रॉनिक सामान';

  @override
  String get categoryAppliances => 'घरेलू उपकरण';

  @override
  String get categoryTools => 'औज़ार';

  @override
  String get categoryOther => 'अन्य';

  @override
  String get exportReports => 'रिपोर्ट';

  @override
  String get about => 'Kepli के बारे में';

  @override
  String get privacyTitle => 'स्थानीय। निजी। आपका।';

  @override
  String get privacyBody =>
      'न खाता, न सदस्यता, न उपयोग का विश्लेषण, न Kepli क्लाउड। आपके रिकॉर्ड इस ऐप के स्टोरेज में रहते हैं, जब तक आप उन्हें निर्यात या साझा न करें। नियमित रूप से बैकअप निर्यात करें: ऐप अनइंस्टॉल करने या डिवाइस खोने से आपका डेटा मिट सकता है।';

  @override
  String get appVersion => 'संस्करण';

  @override
  String get operationFailed => 'यह काम पूरा नहीं हो सका।';

  @override
  String get technicalDetails => 'तकनीकी विवरण';

  @override
  String get saved => 'वारंटी इस डिवाइस पर सहेजी गई।';

  @override
  String get deleted => 'वारंटी और उसके संलग्नक मिटा दिए गए।';

  @override
  String get restored =>
      'बैकअप बहाल हुआ। सभी संदर्भित संलग्नकों का सत्यापन हो गया।';

  @override
  String get settingsSaved => 'सेटिंग्स सहेजी गईं।';

  @override
  String get exportReady => 'निर्यात तैयार है।';

  @override
  String get exportCancelled => 'निर्यात रद्द किया गया।';

  @override
  String fileSavedTo(String path) {
    return 'फ़ाइल $path पर सहेजी गई';
  }

  @override
  String get shareOpened =>
      'साझाकरण पैनल में चुनें कि फ़ाइल कहाँ सहेजनी या भेजनी है।';

  @override
  String get loading => 'लोड हो रहा है';

  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get startupError =>
      'Kepli आपका स्थानीय डेटा नहीं खोल सका। आपकी मौजूदा फ़ाइलें रीसेट नहीं की गई हैं।';

  @override
  String get unavailableImage =>
      'चित्र का पूर्वावलोकन उपलब्ध नहीं है। आप फिर भी मूल फ़ाइल खोल सकते हैं।';

  @override
  String get largeAttachmentTitle => 'बड़ा संलग्नक';

  @override
  String largeAttachmentWarning(String size) {
    return 'इस फ़ाइल का आकार $size MB है। बड़े संलग्नकों से बैकअप धीमे बनते हैं और ज़्यादा स्टोरेज लगता है।';
  }

  @override
  String get continueAction => 'जारी रखें';

  @override
  String get recoverPhoto => 'वापस मिली फ़ोटो इस्तेमाल करें';

  @override
  String get recoveredPhotoHelp =>
      'कैमरे के कारण ऐप फिर शुरू होने के बाद एक फ़ोटो वापस मिली। इसे खोने से बचाने के लिए किसी वारंटी में जोड़ें।';

  @override
  String get dismiss => 'खारिज करें';

  @override
  String get busy => 'काम चल रहा है। कृपया प्रतीक्षा करें।';

  @override
  String get menu => 'मेन्यू';

  @override
  String get sortHint => 'सबसे पहले समाप्त होने वाली वारंटी के क्रम में';

  @override
  String get requiredFields =>
      'नाम, श्रेणी, खरीद की तारीख और वारंटी की अवधि ज़रूरी हैं।';

  @override
  String get chooseDate => 'खरीद की तारीख चुनें';

  @override
  String get selected => 'चयनित';

  @override
  String get notSet => 'तय नहीं';

  @override
  String get reportTitle => 'वारंटी रिपोर्ट';

  @override
  String get pdfReferences =>
      'PDF रसीदें और वारंटी के कागज़ फ़ाइल के नाम से सूचीबद्ध हैं। ज़रूरत होने पर उनकी मूल फ़ाइलें अलग से साझा करें।';

  @override
  String get documentFooter =>
      'Kepli द्वारा स्थानीय रूप से तैयार किया गया। यह रिपोर्ट बहाल करने योग्य बैकअप नहीं है।';

  @override
  String get notificationTitle => 'वारंटी समाप्त होने वाली है';

  @override
  String notificationBody(String name, String date) {
    return '$name: वारंटी $date को समाप्त होगी।';
  }

  @override
  String get contacts => 'बिक्री और सेवा के संपर्क';

  @override
  String get addContact => 'संपर्क जोड़ें';

  @override
  String get editContact => 'संपर्क संपादित करें';

  @override
  String get removeContact => 'संपर्क हटाएँ';

  @override
  String get salesContact => 'बिक्री';

  @override
  String get serviceContact => 'सेवा';

  @override
  String get contactName => 'संपर्क व्यक्ति';

  @override
  String get organization => 'कंपनी या संगठन';

  @override
  String get phone => 'फ़ोन';

  @override
  String get email => 'ईमेल';

  @override
  String get contactNotes => 'संपर्क के नोट्स';

  @override
  String get noContacts => 'कोई संपर्क नहीं जोड़ा गया';

  @override
  String get businessCard => 'विज़िटिंग कार्ड';

  @override
  String get scanBusinessCard => 'विज़िटिंग कार्ड स्कैन करें';

  @override
  String get addBusinessCard => 'विज़िटिंग कार्ड जोड़ें';

  @override
  String get businessCardHelp =>
      'कार्ड की फ़ोटो लें या उसे आयात करके इस संपर्क के साथ संलग्न करें। नीचे व्यक्ति का विवरण दर्ज करें; Kepli क्लाउड पर अक्षर पहचान का उपयोग नहीं करता।';

  @override
  String get businessCardNeedsContact =>
      'विज़िटिंग कार्ड संलग्न करने से पहले संपर्क का नाम सहेजें।';

  @override
  String get scanDocument => 'दस्तावेज़ स्कैन करें';

  @override
  String get scanHelp =>
      'पन्नों की फ़ोटो लें या चित्र चुनें, फिर काटें, घुमाएँ और एक PDF के रूप में सहेजें। प्रोसेसिंग इसी डिवाइस पर होती है; टेक्स्ट अपने-आप नहीं निकाला जाता।';

  @override
  String get addPage => 'पन्ना जोड़ें';

  @override
  String get removePage => 'पन्ना हटाएँ';

  @override
  String get rotatePage => 'पन्ना घुमाएँ';

  @override
  String pageNumber(int number) {
    return 'पन्ना $number';
  }

  @override
  String get cropTop => 'ऊपर से काटें';

  @override
  String get cropBottom => 'नीचे से काटें';

  @override
  String get cropLeft => 'बाएँ से काटें';

  @override
  String get cropRight => 'दाएँ से काटें';

  @override
  String get enhanceDocument => 'दस्तावेज़ का कंट्रास्ट बढ़ाएँ';

  @override
  String get saveScan => 'स्कैन को PDF के रूप में सहेजें';

  @override
  String get scanName => 'दस्तावेज़ का नाम';

  @override
  String get noPages => 'कम-से-कम एक पन्ना जोड़ें।';

  @override
  String get desktopScanHelp =>
      'स्कैनर या कैमरे से सहेजे गए चित्र चुनें। स्कैनर हार्डवेयर को सीधे नियंत्रित करना ज़रूरी नहीं है।';

  @override
  String get attachmentType => 'संलग्नक का प्रकार';

  @override
  String get previousPage => 'पिछला पन्ना';

  @override
  String get nextPage => 'अगला पन्ना';

  @override
  String get processingDocument => 'इस डिवाइस पर दस्तावेज़ प्रोसेस हो रहा है';

  @override
  String get readOnlyDetails => 'वारंटी का विवरण';

  @override
  String get selectWarranty => 'विवरण देखने के लिए कोई वारंटी चुनें।';
}
