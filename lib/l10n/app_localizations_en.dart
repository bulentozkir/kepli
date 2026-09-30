// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Your warranties. Your receipts. Yours.';

  @override
  String get warranties => 'Warranties';

  @override
  String get backups => 'Backups';

  @override
  String get settings => 'Settings';

  @override
  String get addWarranty => 'Add warranty';

  @override
  String get editWarranty => 'Edit warranty';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get searchHint => 'Search name, store or category';

  @override
  String get all => 'All';

  @override
  String get active => 'Active';

  @override
  String get expiringSoon => 'Expiring soon';

  @override
  String get expired => 'Expired';

  @override
  String get claimed => 'Claimed';

  @override
  String get noWarranties => 'No warranties yet';

  @override
  String get getStarted =>
      'Add a purchase and keep its receipt, warranty papers and contacts together.';

  @override
  String get noMatches => 'No matching warranties';

  @override
  String get clearFilters => 'Clear filters';

  @override
  String get purchaseDate => 'Purchase date';

  @override
  String get expiryDate => 'Expiry date';

  @override
  String get warrantyLength => 'Warranty length';

  @override
  String get months => 'Months';

  @override
  String get years => 'Years';

  @override
  String get name => 'Name';

  @override
  String get nameHint => 'For example, kitchen refrigerator';

  @override
  String get category => 'Category';

  @override
  String get vendor => 'Store or vendor';

  @override
  String get price => 'Price (optional)';

  @override
  String get currency => 'Currency code';

  @override
  String get notes => 'Notes';

  @override
  String get productPhoto => 'Product photo';

  @override
  String get receipt => 'Receipt';

  @override
  String get warrantyPaper => 'Warranty paper';

  @override
  String get attachments => 'Attachments';

  @override
  String get addFiles => 'Add files';

  @override
  String get takePhoto => 'Take photo';

  @override
  String get choosePhoto => 'Choose photos';

  @override
  String get removeAttachment => 'Remove attachment';

  @override
  String get openAttachment => 'Open attachment';

  @override
  String get markClaimed => 'Mark as claimed';

  @override
  String get markActive => 'Clear claimed status';

  @override
  String get exportPdf => 'Export warranty PDF';

  @override
  String get deleteWarranty => 'Delete warranty?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Delete $name and all its attachments from this device? This cannot be undone.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left',
      one: '1 day left',
      zero: 'Expires today',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count warranties',
      one: '1 warranty',
      zero: 'No warranties',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get invalidDuration => 'Enter 1 to 1,200 months.';

  @override
  String get invalidPrice => 'Enter an amount with up to two decimal places.';

  @override
  String get invalidCurrency =>
      'Enter a three-letter currency code, such as USD.';

  @override
  String get invalidEmail => 'Enter a valid email address.';

  @override
  String get discardChanges => 'Discard unsaved changes?';

  @override
  String get discard => 'Discard';

  @override
  String get keepEditing => 'Keep editing';

  @override
  String get restoreBackup => 'Restore backup';

  @override
  String get exportBackup => 'Export backup';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get backupExplanation =>
      'One ZIP file contains your warranties, contacts, preferences and original attachments. Move it to another device and restore it there. This is manual transfer, not automatic sync.';

  @override
  String get backupPrivacy =>
      'Backups are not encrypted. Keep them somewhere safe. Kepli has no cloud service; destinations you choose in the system share sheet are under your control.';

  @override
  String get chooseBackup => 'Choose backup file';

  @override
  String get backupPreview => 'Review backup';

  @override
  String backupSummary(int items, int files) {
    return '$items warranties and $files attachments';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Exported $date on $platform';
  }

  @override
  String get merge => 'Merge';

  @override
  String get mergeHelp =>
      'Add new warranties and keep the newer version of matching warranties. Current preferences are kept.';

  @override
  String get replaceAll => 'Replace all';

  @override
  String get replaceHelp =>
      'Replace this device\'s warranties and preferences with the backup.';

  @override
  String replaceConfirmation(int count) {
    return 'Permanently replace all $count warranties on this device? Export a backup first if you want to keep them.';
  }

  @override
  String get confirmReplace => 'Replace all warranties';

  @override
  String get conflicts => 'Matching warranties';

  @override
  String get keepLocal => 'Keep this device\'s version';

  @override
  String get useBackup => 'Use the newer backup version';

  @override
  String get newerWinsHelp =>
      'The newer update normally wins. Equal timestamps keep this device\'s version. Select warranties below to keep the local version instead.';

  @override
  String get restore => 'Restore';

  @override
  String get notifications => 'Reminders';

  @override
  String get enableReminders => 'Enable expiry reminders';

  @override
  String get reminderDays => 'Days before expiry';

  @override
  String get reminderDaysHelp =>
      'Separate values with commas, for example 30, 7, 1. Use 0 for the expiry date.';

  @override
  String get reminderHour => 'Reminder hour (0-23)';

  @override
  String get reminderLimit =>
      'Only the nearest reminders fit in the operating system\'s queue. Open Kepli regularly to replenish it.';

  @override
  String get notificationPrivacy =>
      'Reminders are scheduled locally. Permissions, battery settings and the operating system can delay or prevent them. Your expiring-soon list is always available.';

  @override
  String get permissionRequired => 'Notification permission is required.';

  @override
  String get requestPermission => 'Request permission';

  @override
  String get remindersOff => 'Reminders are off.';

  @override
  String get remindersUnavailable =>
      'System reminders are unavailable. Use the expiring-soon list.';

  @override
  String remindersScheduled(int count) {
    return '$count reminders scheduled.';
  }

  @override
  String get linuxReminderHelp =>
      'On Linux, reminders work only while Kepli is open and a notification service is available.';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get highContrast => 'Increase contrast';

  @override
  String get reduceMotion => 'Reduce motion';

  @override
  String get accessibilityHelp =>
      'Kepli also respects your system text size, screen reader, contrast and reduced-motion settings. Every action is available without gestures.';

  @override
  String get language => 'Language';

  @override
  String get languageHelp =>
      'Choose the interface language. English is the default. Your saved item text is not translated.';

  @override
  String get categories => 'Categories';

  @override
  String get addCategory => 'Add category';

  @override
  String get renameCategory => 'Rename category';

  @override
  String get deleteCategory => 'Delete category';

  @override
  String get categoryInUse =>
      'This category is used by a warranty. Change that warranty\'s category first.';

  @override
  String get newCategory => 'Category name';

  @override
  String get categoryExists => 'That category already exists.';

  @override
  String get categoryElectronics => 'Electronics';

  @override
  String get categoryAppliances => 'Appliances';

  @override
  String get categoryTools => 'Tools';

  @override
  String get categoryOther => 'Other';

  @override
  String get exportReports => 'Reports';

  @override
  String get about => 'About Kepli';

  @override
  String get privacyTitle => 'Local. Private. Yours.';

  @override
  String get privacyBody =>
      'No account, subscription, analytics or Kepli cloud. Your records stay in this app\'s storage until you export or share them. Export backups regularly: uninstalling the app or losing a device can erase your data.';

  @override
  String get appVersion => 'Version';

  @override
  String get operationFailed => 'The operation could not be completed.';

  @override
  String get technicalDetails => 'Technical details';

  @override
  String get saved => 'Warranty saved on this device.';

  @override
  String get deleted => 'Warranty and its attachments deleted.';

  @override
  String get restored =>
      'Backup restored. All referenced attachments verified.';

  @override
  String get settingsSaved => 'Settings saved.';

  @override
  String get exportReady => 'Export ready.';

  @override
  String get exportCancelled => 'Export cancelled.';

  @override
  String fileSavedTo(String path) {
    return 'File saved to $path';
  }

  @override
  String get shareOpened =>
      'Choose where to save or send the file in the share sheet.';

  @override
  String get loading => 'Loading';

  @override
  String get retry => 'Retry';

  @override
  String get startupError =>
      'Kepli could not open your local data. Your existing files have not been reset.';

  @override
  String get unavailableImage =>
      'Image preview unavailable. You can still open the original file.';

  @override
  String get largeAttachmentTitle => 'Large attachment';

  @override
  String largeAttachmentWarning(String size) {
    return 'This file is $size MB. Large attachments make backups slower and take more storage.';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get recoverPhoto => 'Use recovered photo';

  @override
  String get recoveredPhotoHelp =>
      'A photo was recovered after the camera restarted the app. Add it to a warranty so it is not lost.';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get busy => 'Operation in progress. Please wait.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Sorted by soonest expiry';

  @override
  String get requiredFields =>
      'Name, category, purchase date and warranty length are required.';

  @override
  String get chooseDate => 'Choose purchase date';

  @override
  String get selected => 'Selected';

  @override
  String get notSet => 'Not set';

  @override
  String get reportTitle => 'Warranty report';

  @override
  String get pdfReferences =>
      'PDF receipts and warranty papers are listed by filename. Share their original files separately when required.';

  @override
  String get documentFooter =>
      'Generated locally by Kepli. This report is not a restorable backup.';

  @override
  String get notificationTitle => 'Warranty expiring';

  @override
  String notificationBody(String name, String date) {
    return '$name: warranty expires on $date.';
  }

  @override
  String get contacts => 'Sales and service contacts';

  @override
  String get addContact => 'Add contact';

  @override
  String get editContact => 'Edit contact';

  @override
  String get removeContact => 'Remove contact';

  @override
  String get salesContact => 'Sales';

  @override
  String get serviceContact => 'Service';

  @override
  String get contactName => 'Contact person';

  @override
  String get organization => 'Company or organization';

  @override
  String get phone => 'Phone';

  @override
  String get email => 'Email';

  @override
  String get contactNotes => 'Contact notes';

  @override
  String get noContacts => 'No contacts added';

  @override
  String get businessCard => 'Business card';

  @override
  String get scanBusinessCard => 'Scan business card';

  @override
  String get addBusinessCard => 'Add business card';

  @override
  String get businessCardHelp =>
      'Photograph or import the card and attach it to this contact. Enter the person\'s details below; Kepli does not use cloud OCR.';

  @override
  String get businessCardNeedsContact =>
      'Save the contact\'s name before attaching a business card.';

  @override
  String get scanDocument => 'Scan document';

  @override
  String get scanHelp =>
      'Photograph pages or select images, then crop, rotate and save them as one PDF. Processing stays on this device; text is not automatically extracted.';

  @override
  String get addPage => 'Add page';

  @override
  String get removePage => 'Remove page';

  @override
  String get rotatePage => 'Rotate page';

  @override
  String pageNumber(int number) {
    return 'Page $number';
  }

  @override
  String get cropTop => 'Crop from top';

  @override
  String get cropBottom => 'Crop from bottom';

  @override
  String get cropLeft => 'Crop from left';

  @override
  String get cropRight => 'Crop from right';

  @override
  String get enhanceDocument => 'Enhance document contrast';

  @override
  String get saveScan => 'Save scan as PDF';

  @override
  String get scanName => 'Document name';

  @override
  String get noPages => 'Add at least one page.';

  @override
  String get desktopScanHelp =>
      'Select images saved by your scanner or camera. Direct scanner hardware control is not required.';

  @override
  String get attachmentType => 'Attachment type';

  @override
  String get previousPage => 'Previous page';

  @override
  String get nextPage => 'Next page';

  @override
  String get processingDocument => 'Processing document on this device';

  @override
  String get readOnlyDetails => 'Warranty details';

  @override
  String get selectWarranty => 'Select a warranty to view its details.';
}
