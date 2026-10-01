// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'আপনার ওয়ারেন্টি। আপনার রসিদ। সব আপনারই।';

  @override
  String get warranties => 'ওয়ারেন্টি';

  @override
  String get backups => 'ব্যাকআপ';

  @override
  String get settings => 'সেটিংস';

  @override
  String get addWarranty => 'ওয়ারেন্টি যোগ করুন';

  @override
  String get editWarranty => 'ওয়ারেন্টি সম্পাদনা করুন';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get edit => 'সম্পাদনা করুন';

  @override
  String get searchHint => 'নাম, দোকান বা বিভাগ খুঁজুন';

  @override
  String get all => 'সব';

  @override
  String get active => 'মেয়াদ আছে';

  @override
  String get expiringSoon => 'শীঘ্রই মেয়াদ শেষ হবে';

  @override
  String get expired => 'মেয়াদ শেষ';

  @override
  String get claimed => 'দাবি করা হয়েছে';

  @override
  String get noWarranties => 'এখনও কোনো ওয়ারেন্টি নেই';

  @override
  String get getStarted =>
      'একটি কেনাকাটা যোগ করে তার রসিদ, ওয়ারেন্টির কাগজ ও যোগাযোগের তথ্য একসঙ্গে রাখুন।';

  @override
  String get noMatches => 'কোনো মিলে যাওয়া ওয়ারেন্টি নেই';

  @override
  String get clearFilters => 'ফিল্টার সরান';

  @override
  String get purchaseDate => 'কেনার তারিখ';

  @override
  String get expiryDate => 'মেয়াদ শেষের তারিখ';

  @override
  String get warrantyLength => 'ওয়ারেন্টির মেয়াদ';

  @override
  String get months => 'মাস';

  @override
  String get years => 'বছর';

  @override
  String get name => 'নাম';

  @override
  String get nameHint => 'যেমন, রান্নাঘরের ফ্রিজ';

  @override
  String get category => 'বিভাগ';

  @override
  String get vendor => 'দোকান বা বিক্রেতা';

  @override
  String get price => 'দাম (ঐচ্ছিক)';

  @override
  String get currency => 'মুদ্রার কোড';

  @override
  String get notes => 'নোট';

  @override
  String get productPhoto => 'পণ্যের ছবি';

  @override
  String get receipt => 'রসিদ';

  @override
  String get warrantyPaper => 'ওয়ারেন্টির কাগজ';

  @override
  String get attachments => 'সংযুক্তি';

  @override
  String get addFiles => 'ফাইল যোগ করুন';

  @override
  String get takePhoto => 'ছবি তুলুন';

  @override
  String get choosePhoto => 'ছবি বাছুন';

  @override
  String get removeAttachment => 'সংযুক্তি সরান';

  @override
  String get openAttachment => 'সংযুক্তি খুলুন';

  @override
  String get markClaimed => 'দাবি করা হয়েছে বলে চিহ্নিত করুন';

  @override
  String get markActive => 'দাবি করার চিহ্ন সরান';

  @override
  String get exportPdf => 'ওয়ারেন্টির PDF রপ্তানি করুন';

  @override
  String get deleteWarranty => 'ওয়ারেন্টি মুছবেন?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'এই ডিভাইস থেকে $name ও তার সব সংযুক্তি মুছবেন? এটি পূর্বাবস্থায় ফেরানো যাবে না।';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count দিন বাকি',
      one: '1 দিন বাকি',
      zero: 'আজ মেয়াদ শেষ হবে',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countটি ওয়ারেন্টি',
      one: '1টি ওয়ারেন্টি',
      zero: 'কোনো ওয়ারেন্টি নেই',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'এই ঘরটি পূরণ করা আবশ্যক।';

  @override
  String get invalidDuration => '1 থেকে 1,200 মাস লিখুন।';

  @override
  String get invalidPrice =>
      'দশমিকের পরে সর্বোচ্চ দুই অঙ্কসহ একটি পরিমাণ লিখুন।';

  @override
  String get invalidCurrency => 'তিন অক্ষরের মুদ্রার কোড লিখুন, যেমন USD।';

  @override
  String get invalidEmail => 'একটি বৈধ ইমেইল ঠিকানা লিখুন।';

  @override
  String get discardChanges => 'অসংরক্ষিত পরিবর্তন বাদ দেবেন?';

  @override
  String get discard => 'বাদ দিন';

  @override
  String get keepEditing => 'সম্পাদনা চালিয়ে যান';

  @override
  String get restoreBackup => 'ব্যাকআপ পুনরুদ্ধার করুন';

  @override
  String get exportBackup => 'ব্যাকআপ রপ্তানি করুন';

  @override
  String get exportCsv => 'CSV রপ্তানি করুন';

  @override
  String get backupExplanation =>
      'একটি ZIP ফাইলে আপনার ওয়ারেন্টি, যোগাযোগের তথ্য, পছন্দসমূহ ও মূল সংযুক্তি থাকে। এটি অন্য ডিভাইসে নিয়ে গিয়ে সেখানে পুনরুদ্ধার করুন। এটি হাতে করা স্থানান্তর, স্বয়ংক্রিয় সিঙ্ক নয়।';

  @override
  String get backupPrivacy =>
      'ব্যাকআপ এনক্রিপ্ট করা হয় না। সেগুলো নিরাপদ স্থানে রাখুন। Kepli-এর কোনো ক্লাউড পরিষেবা নেই; সিস্টেমের শেয়ার প্যানেলে আপনার বেছে নেওয়া গন্তব্যগুলো আপনার নিয়ন্ত্রণে থাকে।';

  @override
  String get chooseBackup => 'ব্যাকআপ ফাইল বাছুন';

  @override
  String get backupPreview => 'ব্যাকআপ পর্যালোচনা করুন';

  @override
  String backupSummary(int items, int files) {
    return '$itemsটি ওয়ারেন্টি ও $filesটি সংযুক্তি';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date তারিখে $platform-এ রপ্তানি করা হয়েছে';
  }

  @override
  String get merge => 'একত্র করুন';

  @override
  String get mergeHelp =>
      'নতুন ওয়ারেন্টি যোগ করুন এবং মিলে যাওয়া ওয়ারেন্টির নতুনতর সংস্করণ রাখুন। বর্তমান পছন্দসমূহ বজায় থাকবে।';

  @override
  String get replaceAll => 'সব প্রতিস্থাপন করুন';

  @override
  String get replaceHelp =>
      'এই ডিভাইসের ওয়ারেন্টি ও পছন্দসমূহ ব্যাকআপ দিয়ে প্রতিস্থাপন করুন।';

  @override
  String replaceConfirmation(int count) {
    return 'এই ডিভাইসের সব $countটি ওয়ারেন্টি স্থায়ীভাবে প্রতিস্থাপন করবেন? সেগুলো রাখতে চাইলে আগে একটি ব্যাকআপ রপ্তানি করুন।';
  }

  @override
  String get confirmReplace => 'সব ওয়ারেন্টি প্রতিস্থাপন করুন';

  @override
  String get conflicts => 'মিলে যাওয়া ওয়ারেন্টি';

  @override
  String get keepLocal => 'এই ডিভাইসের সংস্করণ রাখুন';

  @override
  String get useBackup => 'ব্যাকআপের নতুনতর সংস্করণ ব্যবহার করুন';

  @override
  String get newerWinsHelp =>
      'সাধারণত পরে আপডেট করা সংস্করণটি রাখা হয়। সময়চিহ্ন একই হলে এই ডিভাইসের সংস্করণ থাকে। এর পরিবর্তে স্থানীয় সংস্করণ রাখতে নিচে ওয়ারেন্টি বাছুন।';

  @override
  String get restore => 'পুনরুদ্ধার করুন';

  @override
  String get notifications => 'অনুস্মারক';

  @override
  String get enableReminders => 'মেয়াদ শেষের অনুস্মারক চালু করুন';

  @override
  String get reminderDays => 'মেয়াদ শেষের কত দিন আগে';

  @override
  String get reminderDaysHelp =>
      'মানগুলো কমা দিয়ে আলাদা করুন, যেমন 30, 7, 1। মেয়াদ শেষের দিনের জন্য 0 ব্যবহার করুন।';

  @override
  String get reminderHour => 'অনুস্মারকের সময় (ঘণ্টা 0–23)';

  @override
  String get reminderLimit =>
      'অপারেটিং সিস্টেমের সারিতে কেবল নিকটতম অনুস্মারকগুলো রাখা যায়। পরের অনুস্মারকগুলো যোগ করতে নিয়মিত Kepli খুলুন।';

  @override
  String get notificationPrivacy =>
      'অনুস্মারক স্থানীয়ভাবে নির্ধারিত হয়। অনুমতি, ব্যাটারির সেটিংস ও অপারেটিং সিস্টেমের কারণে সেগুলো দেরিতে আসতে পারে বা বন্ধ থাকতে পারে। শীঘ্রই মেয়াদ শেষ হবে এমন ওয়ারেন্টির তালিকা সবসময় পাওয়া যায়।';

  @override
  String get permissionRequired => 'বিজ্ঞপ্তির অনুমতি প্রয়োজন।';

  @override
  String get requestPermission => 'অনুমতি চান';

  @override
  String get remindersOff => 'অনুস্মারক বন্ধ আছে।';

  @override
  String get remindersUnavailable =>
      'সিস্টেমের অনুস্মারক পাওয়া যাচ্ছে না। শীঘ্রই মেয়াদ শেষ হবে এমন ওয়ারেন্টির তালিকা দেখুন।';

  @override
  String remindersScheduled(int count) {
    return '$countটি অনুস্মারক নির্ধারিত হয়েছে।';
  }

  @override
  String get linuxReminderHelp =>
      'Linux-এ Kepli খোলা থাকলে এবং বিজ্ঞপ্তি পরিষেবা চালু থাকলেই অনুস্মারক কাজ করে।';

  @override
  String get accessibility => 'অ্যাক্সেসিবিলিটি';

  @override
  String get highContrast => 'বৈপরীত্য বাড়ান';

  @override
  String get reduceMotion => 'অ্যানিমেশন কমান';

  @override
  String get accessibilityHelp =>
      'Kepli আপনার সিস্টেমের লেখার আকার, স্ক্রিন রিডার, বৈপরীত্য ও কম অ্যানিমেশনের সেটিংসও মেনে চলে। অঙ্গভঙ্গি ছাড়াই সব কাজ করা যায়।';

  @override
  String get language => 'ভাষা';

  @override
  String get languageHelp =>
      'ইন্টারফেসের ভাষা বাছুন। ডিফল্ট ভাষা ইংরেজি। আপনার সংরক্ষিত রেকর্ডের লেখা অনুবাদ করা হয় না।';

  @override
  String get categories => 'বিভাগসমূহ';

  @override
  String get addCategory => 'বিভাগ যোগ করুন';

  @override
  String get renameCategory => 'বিভাগের নাম বদলান';

  @override
  String get deleteCategory => 'বিভাগ মুছুন';

  @override
  String get categoryInUse =>
      'একটি ওয়ারেন্টিতে এই বিভাগ ব্যবহার করা হচ্ছে। আগে সেই ওয়ারেন্টির বিভাগ বদলান।';

  @override
  String get newCategory => 'বিভাগের নাম';

  @override
  String get categoryExists => 'এই বিভাগটি আগে থেকেই আছে।';

  @override
  String get categoryElectronics => 'ইলেকট্রনিক পণ্য';

  @override
  String get categoryAppliances => 'গৃহস্থালি যন্ত্রপাতি';

  @override
  String get categoryTools => 'সরঞ্জাম';

  @override
  String get categoryOther => 'অন্যান্য';

  @override
  String get exportReports => 'প্রতিবেদন';

  @override
  String get about => 'Kepli সম্পর্কে';

  @override
  String get privacyTitle => 'স্থানীয়। ব্যক্তিগত। আপনার।';

  @override
  String get privacyBody =>
      'কোনো অ্যাকাউন্ট, সাবস্ক্রিপশন, ব্যবহার বিশ্লেষণ বা Kepli ক্লাউড নেই। আপনি রপ্তানি বা শেয়ার না করা পর্যন্ত আপনার রেকর্ড এই অ্যাপের স্টোরেজেই থাকে। নিয়মিত ব্যাকআপ রপ্তানি করুন: অ্যাপ আনইনস্টল করলে বা ডিভাইস হারালে আপনার তথ্য মুছে যেতে পারে।';

  @override
  String get appVersion => 'সংস্করণ';

  @override
  String get operationFailed => 'কাজটি সম্পন্ন করা যায়নি।';

  @override
  String get technicalDetails => 'প্রযুক্তিগত বিবরণ';

  @override
  String get saved => 'ওয়ারেন্টি এই ডিভাইসে সংরক্ষিত হয়েছে।';

  @override
  String get deleted => 'ওয়ারেন্টি ও তার সংযুক্তি মুছে ফেলা হয়েছে।';

  @override
  String get restored =>
      'ব্যাকআপ পুনরুদ্ধার হয়েছে। উল্লেখ করা সব সংযুক্তি যাচাই করা হয়েছে।';

  @override
  String get settingsSaved => 'সেটিংস সংরক্ষিত হয়েছে।';

  @override
  String get exportReady => 'রপ্তানি প্রস্তুত।';

  @override
  String get exportCancelled => 'রপ্তানি বাতিল হয়েছে।';

  @override
  String fileSavedTo(String path) {
    return 'ফাইল $path-এ সংরক্ষিত হয়েছে';
  }

  @override
  String get shareOpened =>
      'শেয়ার প্যানেলে ফাইল কোথায় সংরক্ষণ বা পাঠাবেন তা বাছুন।';

  @override
  String get loading => 'লোড হচ্ছে';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get startupError =>
      'Kepli আপনার স্থানীয় তথ্য খুলতে পারেনি। আপনার বিদ্যমান ফাইলগুলো রিসেট করা হয়নি।';

  @override
  String get unavailableImage =>
      'ছবির পূর্বরূপ পাওয়া যাচ্ছে না। আপনি এখনও মূল ফাইল খুলতে পারবেন।';

  @override
  String get largeAttachmentTitle => 'বড় সংযুক্তি';

  @override
  String largeAttachmentWarning(String size) {
    return 'এই ফাইলের আকার $size MB। বড় সংযুক্তির কারণে ব্যাকআপ ধীর হয় এবং বেশি স্টোরেজ লাগে।';
  }

  @override
  String get continueAction => 'চালিয়ে যান';

  @override
  String get recoverPhoto => 'ফিরে পাওয়া ছবি ব্যবহার করুন';

  @override
  String get recoveredPhotoHelp =>
      'ক্যামেরার কারণে অ্যাপ পুনরায় চালু হওয়ার পর একটি ছবি ফিরে পাওয়া গেছে। এটি যাতে হারিয়ে না যায়, সে জন্য কোনো ওয়ারেন্টিতে যোগ করুন।';

  @override
  String get dismiss => 'উপেক্ষা করুন';

  @override
  String get busy => 'কাজ চলছে। অনুগ্রহ করে অপেক্ষা করুন।';

  @override
  String get menu => 'মেনু';

  @override
  String get sortHint => 'সবচেয়ে আগে মেয়াদ শেষ হওয়ার ক্রমে সাজানো';

  @override
  String get requiredFields =>
      'নাম, বিভাগ, কেনার তারিখ ও ওয়ারেন্টির মেয়াদ আবশ্যক।';

  @override
  String get chooseDate => 'কেনার তারিখ বাছুন';

  @override
  String get selected => 'নির্বাচিত';

  @override
  String get notSet => 'নির্ধারিত নয়';

  @override
  String get reportTitle => 'ওয়ারেন্টির প্রতিবেদন';

  @override
  String get pdfReferences =>
      'PDF রসিদ ও ওয়ারেন্টির কাগজ ফাইলের নাম অনুযায়ী তালিকাভুক্ত থাকে। প্রয়োজনে তাদের মূল ফাইল আলাদাভাবে শেয়ার করুন।';

  @override
  String get documentFooter =>
      'Kepli স্থানীয়ভাবে তৈরি করেছে। এই প্রতিবেদন পুনরুদ্ধারযোগ্য ব্যাকআপ নয়।';

  @override
  String get notificationTitle => 'ওয়ারেন্টির মেয়াদ শেষ হচ্ছে';

  @override
  String notificationBody(String name, String date) {
    return '$name: ওয়ারেন্টির মেয়াদ $date তারিখে শেষ হবে।';
  }

  @override
  String get contacts => 'বিক্রয় ও সেবার যোগাযোগ';

  @override
  String get addContact => 'যোগাযোগ যোগ করুন';

  @override
  String get editContact => 'যোগাযোগ সম্পাদনা করুন';

  @override
  String get removeContact => 'যোগাযোগ সরান';

  @override
  String get salesContact => 'বিক্রয়';

  @override
  String get serviceContact => 'সেবা';

  @override
  String get contactName => 'যোগাযোগের ব্যক্তি';

  @override
  String get organization => 'কোম্পানি বা প্রতিষ্ঠান';

  @override
  String get phone => 'ফোন';

  @override
  String get email => 'ইমেইল';

  @override
  String get contactNotes => 'যোগাযোগের নোট';

  @override
  String get noContacts => 'কোনো যোগাযোগ যোগ করা হয়নি';

  @override
  String get businessCard => 'ভিজিটিং কার্ড';

  @override
  String get scanBusinessCard => 'ভিজিটিং কার্ড স্ক্যান করুন';

  @override
  String get addBusinessCard => 'ভিজিটিং কার্ড যোগ করুন';

  @override
  String get businessCardHelp =>
      'কার্ডের ছবি তুলুন বা আমদানি করে এই যোগাযোগের সঙ্গে যুক্ত করুন। নিচে ব্যক্তির তথ্য লিখুন; Kepli ক্লাউডভিত্তিক অক্ষর শনাক্তকরণ ব্যবহার করে না।';

  @override
  String get businessCardNeedsContact =>
      'ভিজিটিং কার্ড যুক্ত করার আগে যোগাযোগের ব্যক্তির নাম সংরক্ষণ করুন।';

  @override
  String get scanDocument => 'নথি স্ক্যান করুন';

  @override
  String get scanHelp =>
      'পাতার ছবি তুলুন বা ছবি বাছুন, তারপর ছাঁটুন, ঘোরান এবং একটি PDF হিসেবে সংরক্ষণ করুন। প্রক্রিয়াকরণ এই ডিভাইসেই হয়; লেখা স্বয়ংক্রিয়ভাবে বের করা হয় না।';

  @override
  String get addPage => 'পাতা যোগ করুন';

  @override
  String get removePage => 'পাতা সরান';

  @override
  String get rotatePage => 'পাতা ঘোরান';

  @override
  String pageNumber(int number) {
    return 'পাতা $number';
  }

  @override
  String get cropTop => 'ওপর থেকে ছাঁটুন';

  @override
  String get cropBottom => 'নিচ থেকে ছাঁটুন';

  @override
  String get cropLeft => 'বাঁ দিক থেকে ছাঁটুন';

  @override
  String get cropRight => 'ডান দিক থেকে ছাঁটুন';

  @override
  String get enhanceDocument => 'নথির বৈপরীত্য বাড়ান';

  @override
  String get saveScan => 'স্ক্যান PDF হিসেবে সংরক্ষণ করুন';

  @override
  String get scanName => 'নথির নাম';

  @override
  String get noPages => 'অন্তত একটি পাতা যোগ করুন।';

  @override
  String get desktopScanHelp =>
      'স্ক্যানার বা ক্যামেরা দিয়ে সংরক্ষিত ছবি বাছুন। স্ক্যানারের হার্ডওয়্যার সরাসরি নিয়ন্ত্রণ করার প্রয়োজন নেই।';

  @override
  String get attachmentType => 'সংযুক্তির ধরন';

  @override
  String get previousPage => 'আগের পাতা';

  @override
  String get nextPage => 'পরের পাতা';

  @override
  String get processingDocument => 'এই ডিভাইসে নথি প্রক্রিয়াকরণ হচ্ছে';

  @override
  String get readOnlyDetails => 'ওয়ারেন্টির বিবরণ';

  @override
  String get selectWarranty => 'বিস্তারিত দেখতে একটি ওয়ারেন্টি বাছুন।';
}
