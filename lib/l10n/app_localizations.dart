import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_te.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('mr'),
    Locale('nl'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sw'),
    Locale('te'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Kepli'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Your warranties. Your receipts. Yours.'**
  String get tagline;

  /// No description provided for @warranties.
  ///
  /// In en, this message translates to:
  /// **'Warranties'**
  String get warranties;

  /// No description provided for @backups.
  ///
  /// In en, this message translates to:
  /// **'Backups'**
  String get backups;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @addWarranty.
  ///
  /// In en, this message translates to:
  /// **'Add warranty'**
  String get addWarranty;

  /// No description provided for @editWarranty.
  ///
  /// In en, this message translates to:
  /// **'Edit warranty'**
  String get editWarranty;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search name, store or category'**
  String get searchHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring soon'**
  String get expiringSoon;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @claimed.
  ///
  /// In en, this message translates to:
  /// **'Claimed'**
  String get claimed;

  /// No description provided for @noWarranties.
  ///
  /// In en, this message translates to:
  /// **'No warranties yet'**
  String get noWarranties;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Add a purchase and keep its receipt, warranty papers and contacts together.'**
  String get getStarted;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matching warranties'**
  String get noMatches;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get purchaseDate;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get expiryDate;

  /// No description provided for @warrantyLength.
  ///
  /// In en, this message translates to:
  /// **'Warranty length'**
  String get warrantyLength;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'For example, kitchen refrigerator'**
  String get nameHint;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @vendor.
  ///
  /// In en, this message translates to:
  /// **'Store or vendor'**
  String get vendor;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price (optional)'**
  String get price;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency code'**
  String get currency;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @productPhoto.
  ///
  /// In en, this message translates to:
  /// **'Product photo'**
  String get productPhoto;

  /// No description provided for @receipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receipt;

  /// No description provided for @warrantyPaper.
  ///
  /// In en, this message translates to:
  /// **'Warranty paper'**
  String get warrantyPaper;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @addFiles.
  ///
  /// In en, this message translates to:
  /// **'Add files'**
  String get addFiles;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @choosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose photos'**
  String get choosePhoto;

  /// No description provided for @removeAttachment.
  ///
  /// In en, this message translates to:
  /// **'Remove attachment'**
  String get removeAttachment;

  /// No description provided for @openAttachment.
  ///
  /// In en, this message translates to:
  /// **'Open attachment'**
  String get openAttachment;

  /// No description provided for @markClaimed.
  ///
  /// In en, this message translates to:
  /// **'Mark as claimed'**
  String get markClaimed;

  /// No description provided for @markActive.
  ///
  /// In en, this message translates to:
  /// **'Clear claimed status'**
  String get markActive;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export warranty PDF'**
  String get exportPdf;

  /// No description provided for @deleteWarranty.
  ///
  /// In en, this message translates to:
  /// **'Delete warranty?'**
  String get deleteWarranty;

  /// No description provided for @deleteWarrantyWarning.
  ///
  /// In en, this message translates to:
  /// **'Delete {name} and all its attachments from this device? This cannot be undone.'**
  String deleteWarrantyWarning(String name);

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Expires today} =1{1 day left} other{{count} days left}}'**
  String daysLeft(int count);

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No warranties} =1{1 warranty} other{{count} warranties}}'**
  String itemCount(int count);

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @invalidDuration.
  ///
  /// In en, this message translates to:
  /// **'Enter 1 to 1,200 months.'**
  String get invalidDuration;

  /// No description provided for @invalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount with up to two decimal places.'**
  String get invalidPrice;

  /// No description provided for @invalidCurrency.
  ///
  /// In en, this message translates to:
  /// **'Enter a three-letter currency code, such as USD.'**
  String get invalidCurrency;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard unsaved changes?'**
  String get discardChanges;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @keepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get keepEditing;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore backup'**
  String get restoreBackup;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get exportBackup;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @backupExplanation.
  ///
  /// In en, this message translates to:
  /// **'One ZIP file contains your warranties, contacts, preferences and original attachments. Move it to another device and restore it there. This is manual transfer, not automatic sync.'**
  String get backupExplanation;

  /// No description provided for @backupPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Backups are not encrypted. Keep them somewhere safe. Kepli has no cloud service; destinations you choose in the system share sheet are under your control.'**
  String get backupPrivacy;

  /// No description provided for @chooseBackup.
  ///
  /// In en, this message translates to:
  /// **'Choose backup file'**
  String get chooseBackup;

  /// No description provided for @backupPreview.
  ///
  /// In en, this message translates to:
  /// **'Review backup'**
  String get backupPreview;

  /// No description provided for @backupSummary.
  ///
  /// In en, this message translates to:
  /// **'{items} warranties and {files} attachments'**
  String backupSummary(int items, int files);

  /// No description provided for @exportedOn.
  ///
  /// In en, this message translates to:
  /// **'Exported {date} on {platform}'**
  String exportedOn(String date, String platform);

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @mergeHelp.
  ///
  /// In en, this message translates to:
  /// **'Add new warranties and keep the newer version of matching warranties. Current preferences are kept.'**
  String get mergeHelp;

  /// No description provided for @replaceAll.
  ///
  /// In en, this message translates to:
  /// **'Replace all'**
  String get replaceAll;

  /// No description provided for @replaceHelp.
  ///
  /// In en, this message translates to:
  /// **'Replace this device\'s warranties and preferences with the backup.'**
  String get replaceHelp;

  /// No description provided for @replaceConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Permanently replace all {count} warranties on this device? Export a backup first if you want to keep them.'**
  String replaceConfirmation(int count);

  /// No description provided for @confirmReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace all warranties'**
  String get confirmReplace;

  /// No description provided for @conflicts.
  ///
  /// In en, this message translates to:
  /// **'Matching warranties'**
  String get conflicts;

  /// No description provided for @keepLocal.
  ///
  /// In en, this message translates to:
  /// **'Keep this device\'s version'**
  String get keepLocal;

  /// No description provided for @useBackup.
  ///
  /// In en, this message translates to:
  /// **'Use the newer backup version'**
  String get useBackup;

  /// No description provided for @newerWinsHelp.
  ///
  /// In en, this message translates to:
  /// **'The newer update normally wins. Equal timestamps keep this device\'s version. Select warranties below to keep the local version instead.'**
  String get newerWinsHelp;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get notifications;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable expiry reminders'**
  String get enableReminders;

  /// No description provided for @reminderDays.
  ///
  /// In en, this message translates to:
  /// **'Days before expiry'**
  String get reminderDays;

  /// No description provided for @reminderDaysHelp.
  ///
  /// In en, this message translates to:
  /// **'Separate values with commas, for example 30, 7, 1. Use 0 for the expiry date.'**
  String get reminderDaysHelp;

  /// No description provided for @reminderHour.
  ///
  /// In en, this message translates to:
  /// **'Reminder hour (0-23)'**
  String get reminderHour;

  /// No description provided for @reminderLimit.
  ///
  /// In en, this message translates to:
  /// **'Only the nearest reminders fit in the operating system\'s queue. Open Kepli regularly to replenish it.'**
  String get reminderLimit;

  /// No description provided for @notificationPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Reminders are scheduled locally. Permissions, battery settings and the operating system can delay or prevent them. Your expiring-soon list is always available.'**
  String get notificationPrivacy;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Notification permission is required.'**
  String get permissionRequired;

  /// No description provided for @requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request permission'**
  String get requestPermission;

  /// No description provided for @remindersOff.
  ///
  /// In en, this message translates to:
  /// **'Reminders are off.'**
  String get remindersOff;

  /// No description provided for @remindersUnavailable.
  ///
  /// In en, this message translates to:
  /// **'System reminders are unavailable. Use the expiring-soon list.'**
  String get remindersUnavailable;

  /// No description provided for @remindersScheduled.
  ///
  /// In en, this message translates to:
  /// **'{count} reminders scheduled.'**
  String remindersScheduled(int count);

  /// No description provided for @linuxReminderHelp.
  ///
  /// In en, this message translates to:
  /// **'On Linux, reminders work only while Kepli is open and a notification service is available.'**
  String get linuxReminderHelp;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'Increase contrast'**
  String get highContrast;

  /// No description provided for @reduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reduceMotion;

  /// No description provided for @accessibilityHelp.
  ///
  /// In en, this message translates to:
  /// **'Kepli also respects your system text size, screen reader, contrast and reduced-motion settings. Every action is available without gestures.'**
  String get accessibilityHelp;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose the interface language. English is the default. Your saved item text is not translated.'**
  String get languageHelp;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @renameCategory.
  ///
  /// In en, this message translates to:
  /// **'Rename category'**
  String get renameCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete category'**
  String get deleteCategory;

  /// No description provided for @categoryInUse.
  ///
  /// In en, this message translates to:
  /// **'This category is used by a warranty. Change that warranty\'s category first.'**
  String get categoryInUse;

  /// No description provided for @newCategory.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get newCategory;

  /// No description provided for @categoryExists.
  ///
  /// In en, this message translates to:
  /// **'That category already exists.'**
  String get categoryExists;

  /// No description provided for @categoryElectronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get categoryElectronics;

  /// No description provided for @categoryAppliances.
  ///
  /// In en, this message translates to:
  /// **'Appliances'**
  String get categoryAppliances;

  /// No description provided for @categoryTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get categoryTools;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @exportReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get exportReports;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Kepli'**
  String get about;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Local. Private. Yours.'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'No account, subscription, analytics or Kepli cloud. Your records stay in this app\'s storage until you export or share them. Export backups regularly: uninstalling the app or losing a device can erase your data.'**
  String get privacyBody;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'The operation could not be completed.'**
  String get operationFailed;

  /// No description provided for @technicalDetails.
  ///
  /// In en, this message translates to:
  /// **'Technical details'**
  String get technicalDetails;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Warranty saved on this device.'**
  String get saved;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Warranty and its attachments deleted.'**
  String get deleted;

  /// No description provided for @restored.
  ///
  /// In en, this message translates to:
  /// **'Backup restored. All referenced attachments verified.'**
  String get restored;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved.'**
  String get settingsSaved;

  /// No description provided for @exportReady.
  ///
  /// In en, this message translates to:
  /// **'Export ready.'**
  String get exportReady;

  /// No description provided for @exportCancelled.
  ///
  /// In en, this message translates to:
  /// **'Export cancelled.'**
  String get exportCancelled;

  /// No description provided for @fileSavedTo.
  ///
  /// In en, this message translates to:
  /// **'File saved to {path}'**
  String fileSavedTo(String path);

  /// No description provided for @shareOpened.
  ///
  /// In en, this message translates to:
  /// **'Choose where to save or send the file in the share sheet.'**
  String get shareOpened;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @startupError.
  ///
  /// In en, this message translates to:
  /// **'Kepli could not open your local data. Your existing files have not been reset.'**
  String get startupError;

  /// No description provided for @unavailableImage.
  ///
  /// In en, this message translates to:
  /// **'Image preview unavailable. You can still open the original file.'**
  String get unavailableImage;

  /// No description provided for @largeAttachmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Large attachment'**
  String get largeAttachmentTitle;

  /// No description provided for @largeAttachmentWarning.
  ///
  /// In en, this message translates to:
  /// **'This file is {size} MB. Large attachments make backups slower and take more storage.'**
  String largeAttachmentWarning(String size);

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @recoverPhoto.
  ///
  /// In en, this message translates to:
  /// **'Use recovered photo'**
  String get recoverPhoto;

  /// No description provided for @recoveredPhotoHelp.
  ///
  /// In en, this message translates to:
  /// **'A photo was recovered after the camera restarted the app. Add it to a warranty so it is not lost.'**
  String get recoveredPhotoHelp;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @busy.
  ///
  /// In en, this message translates to:
  /// **'Operation in progress. Please wait.'**
  String get busy;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @sortHint.
  ///
  /// In en, this message translates to:
  /// **'Sorted by soonest expiry'**
  String get sortHint;

  /// No description provided for @requiredFields.
  ///
  /// In en, this message translates to:
  /// **'Name, category, purchase date and warranty length are required.'**
  String get requiredFields;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose purchase date'**
  String get chooseDate;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty report'**
  String get reportTitle;

  /// No description provided for @pdfReferences.
  ///
  /// In en, this message translates to:
  /// **'PDF receipts and warranty papers are listed by filename. Share their original files separately when required.'**
  String get pdfReferences;

  /// No description provided for @documentFooter.
  ///
  /// In en, this message translates to:
  /// **'Generated locally by Kepli. This report is not a restorable backup.'**
  String get documentFooter;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty expiring'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'{name}: warranty expires on {date}.'**
  String notificationBody(String name, String date);

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'Sales and service contacts'**
  String get contacts;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add contact'**
  String get addContact;

  /// No description provided for @editContact.
  ///
  /// In en, this message translates to:
  /// **'Edit contact'**
  String get editContact;

  /// No description provided for @removeContact.
  ///
  /// In en, this message translates to:
  /// **'Remove contact'**
  String get removeContact;

  /// No description provided for @salesContact.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get salesContact;

  /// No description provided for @serviceContact.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get serviceContact;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact person'**
  String get contactName;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Company or organization'**
  String get organization;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @contactNotes.
  ///
  /// In en, this message translates to:
  /// **'Contact notes'**
  String get contactNotes;

  /// No description provided for @noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts added'**
  String get noContacts;

  /// No description provided for @businessCard.
  ///
  /// In en, this message translates to:
  /// **'Business card'**
  String get businessCard;

  /// No description provided for @scanBusinessCard.
  ///
  /// In en, this message translates to:
  /// **'Scan business card'**
  String get scanBusinessCard;

  /// No description provided for @addBusinessCard.
  ///
  /// In en, this message translates to:
  /// **'Add business card'**
  String get addBusinessCard;

  /// No description provided for @businessCardHelp.
  ///
  /// In en, this message translates to:
  /// **'Photograph or import the card and attach it to this contact. Enter the person\'s details below; Kepli does not use cloud OCR.'**
  String get businessCardHelp;

  /// No description provided for @businessCardNeedsContact.
  ///
  /// In en, this message translates to:
  /// **'Save the contact\'s name before attaching a business card.'**
  String get businessCardNeedsContact;

  /// No description provided for @scanDocument.
  ///
  /// In en, this message translates to:
  /// **'Scan document'**
  String get scanDocument;

  /// No description provided for @scanHelp.
  ///
  /// In en, this message translates to:
  /// **'Photograph pages or select images, then crop, rotate and save them as one PDF. Processing stays on this device; text is not automatically extracted.'**
  String get scanHelp;

  /// No description provided for @addPage.
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get addPage;

  /// No description provided for @removePage.
  ///
  /// In en, this message translates to:
  /// **'Remove page'**
  String get removePage;

  /// No description provided for @rotatePage.
  ///
  /// In en, this message translates to:
  /// **'Rotate page'**
  String get rotatePage;

  /// No description provided for @pageNumber.
  ///
  /// In en, this message translates to:
  /// **'Page {number}'**
  String pageNumber(int number);

  /// No description provided for @cropTop.
  ///
  /// In en, this message translates to:
  /// **'Crop from top'**
  String get cropTop;

  /// No description provided for @cropBottom.
  ///
  /// In en, this message translates to:
  /// **'Crop from bottom'**
  String get cropBottom;

  /// No description provided for @cropLeft.
  ///
  /// In en, this message translates to:
  /// **'Crop from left'**
  String get cropLeft;

  /// No description provided for @cropRight.
  ///
  /// In en, this message translates to:
  /// **'Crop from right'**
  String get cropRight;

  /// No description provided for @enhanceDocument.
  ///
  /// In en, this message translates to:
  /// **'Enhance document contrast'**
  String get enhanceDocument;

  /// No description provided for @saveScan.
  ///
  /// In en, this message translates to:
  /// **'Save scan as PDF'**
  String get saveScan;

  /// No description provided for @scanName.
  ///
  /// In en, this message translates to:
  /// **'Document name'**
  String get scanName;

  /// No description provided for @noPages.
  ///
  /// In en, this message translates to:
  /// **'Add at least one page.'**
  String get noPages;

  /// No description provided for @desktopScanHelp.
  ///
  /// In en, this message translates to:
  /// **'Select images saved by your scanner or camera. Direct scanner hardware control is not required.'**
  String get desktopScanHelp;

  /// No description provided for @attachmentType.
  ///
  /// In en, this message translates to:
  /// **'Attachment type'**
  String get attachmentType;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get previousPage;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// No description provided for @processingDocument.
  ///
  /// In en, this message translates to:
  /// **'Processing document on this device'**
  String get processingDocument;

  /// No description provided for @readOnlyDetails.
  ///
  /// In en, this message translates to:
  /// **'Warranty details'**
  String get readOnlyDetails;

  /// No description provided for @selectWarranty.
  ///
  /// In en, this message translates to:
  /// **'Select a warranty to view its details.'**
  String get selectWarranty;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'mr',
    'nl',
    'pa',
    'pl',
    'pt',
    'ru',
    'sw',
    'te',
    'tr',
    'uk',
    'ur',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'mr':
      return AppLocalizationsMr();
    case 'nl':
      return AppLocalizationsNl();
    case 'pa':
      return AppLocalizationsPa();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'te':
      return AppLocalizationsTe();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
