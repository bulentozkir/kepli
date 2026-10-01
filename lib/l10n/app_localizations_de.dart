// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Deine Garantien. Deine Belege. Ganz deine.';

  @override
  String get warranties => 'Garantien';

  @override
  String get backups => 'Sicherungen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get addWarranty => 'Garantie hinzufügen';

  @override
  String get editWarranty => 'Garantie bearbeiten';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get close => 'Schließen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get searchHint => 'Nach Bezeichnung, Geschäft oder Kategorie suchen';

  @override
  String get all => 'Alle';

  @override
  String get active => 'Aktiv';

  @override
  String get expiringSoon => 'Bald ablaufend';

  @override
  String get expired => 'Abgelaufen';

  @override
  String get claimed => 'In Anspruch genommen';

  @override
  String get noWarranties => 'Noch keine Garantien';

  @override
  String get getStarted =>
      'Füge einen Kauf hinzu und bewahre Beleg, Garantieunterlagen und Kontakte zusammen auf.';

  @override
  String get noMatches => 'Keine passenden Garantien';

  @override
  String get clearFilters => 'Filter zurücksetzen';

  @override
  String get purchaseDate => 'Kaufdatum';

  @override
  String get expiryDate => 'Ablaufdatum';

  @override
  String get warrantyLength => 'Garantiedauer';

  @override
  String get months => 'Monate';

  @override
  String get years => 'Jahre';

  @override
  String get name => 'Bezeichnung';

  @override
  String get nameHint => 'Zum Beispiel Kühlschrank in der Küche';

  @override
  String get category => 'Kategorie';

  @override
  String get vendor => 'Geschäft oder Händler';

  @override
  String get price => 'Preis (optional)';

  @override
  String get currency => 'Währungscode';

  @override
  String get notes => 'Notizen';

  @override
  String get productPhoto => 'Produktfoto';

  @override
  String get receipt => 'Kaufbeleg';

  @override
  String get warrantyPaper => 'Garantieunterlage';

  @override
  String get attachments => 'Anhänge';

  @override
  String get addFiles => 'Dateien hinzufügen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get choosePhoto => 'Fotos auswählen';

  @override
  String get removeAttachment => 'Anhang entfernen';

  @override
  String get openAttachment => 'Anhang öffnen';

  @override
  String get markClaimed => 'Als in Anspruch genommen markieren';

  @override
  String get markActive => 'Status „in Anspruch genommen“ zurücksetzen';

  @override
  String get exportPdf => 'Garantie als PDF exportieren';

  @override
  String get deleteWarranty => 'Garantie löschen?';

  @override
  String deleteWarrantyWarning(String name) {
    return '$name und alle zugehörigen Anhänge von diesem Gerät löschen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Noch $count Tage',
      one: 'Noch 1 Tag',
      zero: 'Läuft heute ab',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Garantien',
      one: '1 Garantie',
      zero: 'Keine Garantien',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Dieses Feld ist erforderlich.';

  @override
  String get invalidDuration =>
      'Gib eine Dauer zwischen 1 und 1.200 Monaten ein.';

  @override
  String get invalidPrice =>
      'Gib einen Betrag mit höchstens zwei Nachkommastellen ein.';

  @override
  String get invalidCurrency =>
      'Gib einen dreistelligen Währungscode ein, zum Beispiel USD.';

  @override
  String get invalidEmail => 'Gib eine gültige E-Mail-Adresse ein.';

  @override
  String get discardChanges => 'Ungespeicherte Änderungen verwerfen?';

  @override
  String get discard => 'Verwerfen';

  @override
  String get keepEditing => 'Weiter bearbeiten';

  @override
  String get restoreBackup => 'Sicherung wiederherstellen';

  @override
  String get exportBackup => 'Sicherung exportieren';

  @override
  String get exportCsv => 'Als CSV exportieren';

  @override
  String get backupExplanation =>
      'Eine einzelne ZIP-Datei enthält deine Garantien, Kontakte, Einstellungen und Originalanhänge. Übertrage sie auf ein anderes Gerät und stelle sie dort wieder her. Dies ist eine manuelle Übertragung, keine automatische Synchronisierung.';

  @override
  String get backupPrivacy =>
      'Sicherungen sind nicht verschlüsselt. Bewahre sie an einem sicheren Ort auf. Kepli hat keinen Cloud-Dienst; du bestimmst die Ziele, die du im Teilen-Dialog des Systems auswählst.';

  @override
  String get chooseBackup => 'Sicherungsdatei auswählen';

  @override
  String get backupPreview => 'Sicherung prüfen';

  @override
  String backupSummary(int items, int files) {
    return '$items Garantien und $files Anhänge';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Am $date auf $platform exportiert';
  }

  @override
  String get merge => 'Zusammenführen';

  @override
  String get mergeHelp =>
      'Fügt neue Garantien hinzu und behält bei übereinstimmenden Garantien die neuere Version. Die aktuellen Einstellungen bleiben erhalten.';

  @override
  String get replaceAll => 'Alles ersetzen';

  @override
  String get replaceHelp =>
      'Ersetzt die Garantien und Einstellungen auf diesem Gerät durch die Sicherung.';

  @override
  String replaceConfirmation(int count) {
    return 'Alle $count Garantien auf diesem Gerät dauerhaft ersetzen? Exportiere zuerst eine Sicherung, wenn du sie behalten möchtest.';
  }

  @override
  String get confirmReplace => 'Alle Garantien ersetzen';

  @override
  String get conflicts => 'Übereinstimmende Garantien';

  @override
  String get keepLocal => 'Version dieses Geräts behalten';

  @override
  String get useBackup => 'Neuere Version aus der Sicherung verwenden';

  @override
  String get newerWinsHelp =>
      'Normalerweise wird die neuere Aktualisierung übernommen. Bei gleichen Zeitstempeln bleibt die Version dieses Geräts erhalten. Wähle unten Garantien aus, um stattdessen deren lokale Version zu behalten.';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get notifications => 'Erinnerungen';

  @override
  String get enableReminders => 'Erinnerungen an den Garantieablauf aktivieren';

  @override
  String get reminderDays => 'Tage vor Ablauf';

  @override
  String get reminderDaysHelp =>
      'Trenne die Werte durch Kommas, zum Beispiel 30, 7, 1. Verwende 0 für den Ablauftag.';

  @override
  String get reminderHour => 'Uhrzeit der Erinnerung (0–23)';

  @override
  String get reminderLimit =>
      'In die Warteschlange des Betriebssystems passen nur die nächsten Erinnerungen. Öffne Kepli regelmäßig, um weitere einzuplanen.';

  @override
  String get notificationPrivacy =>
      'Erinnerungen werden lokal geplant. Berechtigungen, Akkueinstellungen und das Betriebssystem können sie verzögern oder verhindern. Die Liste der bald ablaufenden Garantien ist immer verfügbar.';

  @override
  String get permissionRequired =>
      'Die Berechtigung für Benachrichtigungen ist erforderlich.';

  @override
  String get requestPermission => 'Berechtigung anfordern';

  @override
  String get remindersOff => 'Erinnerungen sind deaktiviert.';

  @override
  String get remindersUnavailable =>
      'Systemerinnerungen sind nicht verfügbar. Verwende die Liste der bald ablaufenden Garantien.';

  @override
  String remindersScheduled(int count) {
    return '$count Erinnerungen geplant.';
  }

  @override
  String get linuxReminderHelp =>
      'Unter Linux funktionieren Erinnerungen nur, solange Kepli geöffnet ist und ein Benachrichtigungsdienst verfügbar ist.';

  @override
  String get accessibility => 'Barrierefreiheit';

  @override
  String get highContrast => 'Kontrast erhöhen';

  @override
  String get reduceMotion => 'Bewegung reduzieren';

  @override
  String get accessibilityHelp =>
      'Kepli berücksichtigt auch die Systemeinstellungen für Textgröße, Sprachausgabe, Kontrast und reduzierte Bewegung. Alle Aktionen sind ohne Gesten verfügbar.';

  @override
  String get language => 'Sprache';

  @override
  String get languageHelp =>
      'Wähle die Sprache der Benutzeroberfläche. Englisch ist die Standardsprache. Texte deiner gespeicherten Einträge werden nicht übersetzt.';

  @override
  String get categories => 'Kategorien';

  @override
  String get addCategory => 'Kategorie hinzufügen';

  @override
  String get renameCategory => 'Kategorie umbenennen';

  @override
  String get deleteCategory => 'Kategorie löschen';

  @override
  String get categoryInUse =>
      'Diese Kategorie wird von einer Garantie verwendet. Ändere zuerst die Kategorie dieser Garantie.';

  @override
  String get newCategory => 'Kategoriename';

  @override
  String get categoryExists => 'Diese Kategorie ist bereits vorhanden.';

  @override
  String get categoryElectronics => 'Elektronik';

  @override
  String get categoryAppliances => 'Haushaltsgeräte';

  @override
  String get categoryTools => 'Werkzeuge';

  @override
  String get categoryOther => 'Sonstiges';

  @override
  String get exportReports => 'Berichte';

  @override
  String get about => 'Über Kepli';

  @override
  String get privacyTitle => 'Lokal. Privat. Deins.';

  @override
  String get privacyBody =>
      'Kein Konto, kein Abo, keine Nutzungsanalyse und keine Kepli-Cloud. Deine Einträge bleiben im Speicher dieser App, bis du sie exportierst oder teilst. Exportiere regelmäßig Sicherungen: Durch das Deinstallieren der App oder den Verlust eines Geräts können deine Daten verloren gehen.';

  @override
  String get appVersion => 'App-Version';

  @override
  String get operationFailed =>
      'Der Vorgang konnte nicht abgeschlossen werden.';

  @override
  String get technicalDetails => 'Technische Details';

  @override
  String get saved => 'Garantie auf diesem Gerät gespeichert.';

  @override
  String get deleted => 'Garantie und zugehörige Anhänge gelöscht.';

  @override
  String get restored =>
      'Sicherung wiederhergestellt. Alle referenzierten Anhänge wurden überprüft.';

  @override
  String get settingsSaved => 'Einstellungen gespeichert.';

  @override
  String get exportReady => 'Export bereit.';

  @override
  String get exportCancelled => 'Export abgebrochen.';

  @override
  String fileSavedTo(String path) {
    return 'Datei unter $path gespeichert';
  }

  @override
  String get shareOpened =>
      'Wähle im Teilen-Dialog aus, wo du die Datei speichern oder wohin du sie senden möchtest.';

  @override
  String get loading => 'Wird geladen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get startupError =>
      'Kepli konnte deine lokalen Daten nicht öffnen. Deine vorhandenen Dateien wurden nicht zurückgesetzt.';

  @override
  String get unavailableImage =>
      'Keine Bildvorschau verfügbar. Du kannst die Originaldatei weiterhin öffnen.';

  @override
  String get largeAttachmentTitle => 'Großer Anhang';

  @override
  String largeAttachmentWarning(String size) {
    return 'Diese Datei ist $size MB groß. Große Anhänge verlangsamen Sicherungen und benötigen mehr Speicherplatz.';
  }

  @override
  String get continueAction => 'Weiter';

  @override
  String get recoverPhoto => 'Wiederhergestelltes Foto verwenden';

  @override
  String get recoveredPhotoHelp =>
      'Ein Foto wurde wiederhergestellt, nachdem die Kamera die App neu gestartet hat. Füge es einer Garantie hinzu, damit es nicht verloren geht.';

  @override
  String get dismiss => 'Schließen';

  @override
  String get busy => 'Vorgang läuft. Bitte warten.';

  @override
  String get menu => 'Menü';

  @override
  String get sortHint => 'Nach nächstem Ablaufdatum sortiert';

  @override
  String get requiredFields =>
      'Bezeichnung, Kategorie, Kaufdatum und Garantiedauer sind erforderlich.';

  @override
  String get chooseDate => 'Kaufdatum auswählen';

  @override
  String get selected => 'Ausgewählt';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get reportTitle => 'Garantiebericht';

  @override
  String get pdfReferences =>
      'PDF-Belege und Garantieunterlagen werden mit ihrem Dateinamen aufgeführt. Teile die Originaldateien bei Bedarf separat.';

  @override
  String get documentFooter =>
      'Lokal von Kepli erstellt. Dieser Bericht ist keine wiederherstellbare Sicherung.';

  @override
  String get notificationTitle => 'Garantie läuft bald ab';

  @override
  String notificationBody(String name, String date) {
    return '$name: Die Garantie läuft am $date ab.';
  }

  @override
  String get contacts => 'Verkaufs- und Servicekontakte';

  @override
  String get addContact => 'Kontakt hinzufügen';

  @override
  String get editContact => 'Kontakt bearbeiten';

  @override
  String get removeContact => 'Kontakt entfernen';

  @override
  String get salesContact => 'Verkauf';

  @override
  String get serviceContact => 'Kundendienst';

  @override
  String get contactName => 'Kontaktperson';

  @override
  String get organization => 'Unternehmen oder Organisation';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-Mail';

  @override
  String get contactNotes => 'Kontaktnotizen';

  @override
  String get noContacts => 'Keine Kontakte hinzugefügt';

  @override
  String get businessCard => 'Visitenkarte';

  @override
  String get scanBusinessCard => 'Visitenkarte scannen';

  @override
  String get addBusinessCard => 'Visitenkarte hinzufügen';

  @override
  String get businessCardHelp =>
      'Fotografiere oder importiere die Karte und hänge sie an diesen Kontakt an. Gib unten die Angaben zur Person ein; Kepli verwendet keine cloudbasierte Texterkennung.';

  @override
  String get businessCardNeedsContact =>
      'Speichere den Namen des Kontakts, bevor du eine Visitenkarte anhängst.';

  @override
  String get scanDocument => 'Dokument scannen';

  @override
  String get scanHelp =>
      'Fotografiere Seiten oder wähle Bilder aus. Anschließend kannst du sie zuschneiden, drehen und als eine PDF-Datei speichern. Die Verarbeitung bleibt auf diesem Gerät; Text wird nicht automatisch extrahiert.';

  @override
  String get addPage => 'Seite hinzufügen';

  @override
  String get removePage => 'Seite entfernen';

  @override
  String get rotatePage => 'Seite drehen';

  @override
  String pageNumber(int number) {
    return 'Seite $number';
  }

  @override
  String get cropTop => 'Oben zuschneiden';

  @override
  String get cropBottom => 'Unten zuschneiden';

  @override
  String get cropLeft => 'Links zuschneiden';

  @override
  String get cropRight => 'Rechts zuschneiden';

  @override
  String get enhanceDocument => 'Dokumentkontrast verbessern';

  @override
  String get saveScan => 'Scan als PDF speichern';

  @override
  String get scanName => 'Dokumentname';

  @override
  String get noPages => 'Füge mindestens eine Seite hinzu.';

  @override
  String get desktopScanHelp =>
      'Wähle Bilder aus, die dein Scanner oder deine Kamera gespeichert hat. Eine direkte Steuerung des Scanners ist nicht erforderlich.';

  @override
  String get attachmentType => 'Anhangstyp';

  @override
  String get previousPage => 'Vorherige Seite';

  @override
  String get nextPage => 'Nächste Seite';

  @override
  String get processingDocument => 'Dokument wird auf diesem Gerät verarbeitet';

  @override
  String get readOnlyDetails => 'Garantiedetails';

  @override
  String get selectWarranty =>
      'Wähle eine Garantie aus, um ihre Details anzuzeigen.';
}
