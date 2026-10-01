// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Jouw garanties. Jouw bonnen. Van jou.';

  @override
  String get warranties => 'Garanties';

  @override
  String get backups => 'Reservekopieën';

  @override
  String get settings => 'Instellingen';

  @override
  String get addWarranty => 'Garantie toevoegen';

  @override
  String get editWarranty => 'Garantie bewerken';

  @override
  String get save => 'Opslaan';

  @override
  String get cancel => 'Annuleren';

  @override
  String get delete => 'Verwijderen';

  @override
  String get close => 'Sluiten';

  @override
  String get edit => 'Bewerken';

  @override
  String get searchHint => 'Zoeken op naam, winkel of categorie';

  @override
  String get all => 'Alle';

  @override
  String get active => 'Actief';

  @override
  String get expiringSoon => 'Verloopt binnenkort';

  @override
  String get expired => 'Verlopen';

  @override
  String get claimed => 'Ingeroepen';

  @override
  String get noWarranties => 'Nog geen garanties';

  @override
  String get getStarted =>
      'Voeg een aankoop toe en bewaar de bon, garantiedocumenten en contactgegevens bij elkaar.';

  @override
  String get noMatches => 'Geen overeenkomende garanties';

  @override
  String get clearFilters => 'Filters wissen';

  @override
  String get purchaseDate => 'Aankoopdatum';

  @override
  String get expiryDate => 'Vervaldatum';

  @override
  String get warrantyLength => 'Garantieduur';

  @override
  String get months => 'Maanden';

  @override
  String get years => 'Jaren';

  @override
  String get name => 'Naam';

  @override
  String get nameHint => 'Bijvoorbeeld koelkast in de keuken';

  @override
  String get category => 'Categorie';

  @override
  String get vendor => 'Winkel of verkoper';

  @override
  String get price => 'Prijs (optioneel)';

  @override
  String get currency => 'Valutacode';

  @override
  String get notes => 'Notities';

  @override
  String get productPhoto => 'Productfoto';

  @override
  String get receipt => 'Bon';

  @override
  String get warrantyPaper => 'Garantiebewijs';

  @override
  String get attachments => 'Bijlagen';

  @override
  String get addFiles => 'Bestanden toevoegen';

  @override
  String get takePhoto => 'Foto maken';

  @override
  String get choosePhoto => 'Foto’s kiezen';

  @override
  String get removeAttachment => 'Bijlage verwijderen';

  @override
  String get openAttachment => 'Bijlage openen';

  @override
  String get markClaimed => 'Markeren als ingeroepen';

  @override
  String get markActive => 'Status ‘ingeroepen’ wissen';

  @override
  String get exportPdf => 'Garantie als PDF exporteren';

  @override
  String get deleteWarranty => 'Garantie verwijderen?';

  @override
  String deleteWarrantyWarning(String name) {
    return '$name en alle bijbehorende bijlagen van dit apparaat verwijderen? Dit kan niet ongedaan worden gemaakt.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nog $count dagen',
      one: 'Nog 1 dag',
      zero: 'Verloopt vandaag',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garanties',
      one: '1 garantie',
      zero: 'Geen garanties',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Dit veld is verplicht.';

  @override
  String get invalidDuration => 'Voer een duur van 1 tot 1.200 maanden in.';

  @override
  String get invalidPrice => 'Voer een bedrag met maximaal twee decimalen in.';

  @override
  String get invalidCurrency =>
      'Voer een valutacode van drie letters in, zoals USD.';

  @override
  String get invalidEmail => 'Voer een geldig e-mailadres in.';

  @override
  String get discardChanges => 'Niet-opgeslagen wijzigingen verwerpen?';

  @override
  String get discard => 'Verwerpen';

  @override
  String get keepEditing => 'Doorgaan met bewerken';

  @override
  String get restoreBackup => 'Reservekopie herstellen';

  @override
  String get exportBackup => 'Reservekopie exporteren';

  @override
  String get exportCsv => 'CSV exporteren';

  @override
  String get backupExplanation =>
      'Eén ZIP-bestand bevat je garanties, contacten, voorkeuren en oorspronkelijke bijlagen. Zet het over naar een ander apparaat en herstel het daar. Dit is handmatige overdracht, geen automatische synchronisatie.';

  @override
  String get backupPrivacy =>
      'Reservekopieën zijn niet versleuteld. Bewaar ze op een veilige plek. Kepli heeft geen clouddienst; je bepaalt zelf welke bestemmingen je in het deelvenster van het systeem kiest.';

  @override
  String get chooseBackup => 'Reservekopiebestand kiezen';

  @override
  String get backupPreview => 'Reservekopie controleren';

  @override
  String backupSummary(int items, int files) {
    return '$items garanties en $files bijlagen';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Geëxporteerd op $date via $platform';
  }

  @override
  String get merge => 'Samenvoegen';

  @override
  String get mergeHelp =>
      'Voegt nieuwe garanties toe en bewaart de nieuwere versie van overeenkomende garanties. De huidige voorkeuren blijven behouden.';

  @override
  String get replaceAll => 'Alles vervangen';

  @override
  String get replaceHelp =>
      'Vervangt de garanties en voorkeuren van dit apparaat door die uit de reservekopie.';

  @override
  String replaceConfirmation(int count) {
    return 'Alle $count garanties op dit apparaat definitief vervangen? Exporteer eerst een reservekopie als je ze wilt bewaren.';
  }

  @override
  String get confirmReplace => 'Alle garanties vervangen';

  @override
  String get conflicts => 'Overeenkomende garanties';

  @override
  String get keepLocal => 'Versie van dit apparaat behouden';

  @override
  String get useBackup => 'Nieuwere versie uit de reservekopie gebruiken';

  @override
  String get newerWinsHelp =>
      'Normaal wordt de nieuwste wijziging overgenomen. Bij gelijke tijdstempels blijft de versie van dit apparaat behouden. Selecteer hieronder garanties om in plaats daarvan de lokale versie te behouden.';

  @override
  String get restore => 'Herstellen';

  @override
  String get notifications => 'Herinneringen';

  @override
  String get enableReminders =>
      'Herinneringen voor aflopende garanties inschakelen';

  @override
  String get reminderDays => 'Dagen voor het verlopen';

  @override
  String get reminderDaysHelp =>
      'Scheid de waarden met komma’s, bijvoorbeeld 30, 7, 1. Gebruik 0 voor de vervaldatum.';

  @override
  String get reminderHour => 'Uur van de herinnering (0-23)';

  @override
  String get reminderLimit =>
      'Alleen de eerstvolgende herinneringen passen in de wachtrij van het besturingssysteem. Open Kepli regelmatig om deze aan te vullen.';

  @override
  String get notificationPrivacy =>
      'Herinneringen worden lokaal ingepland. Machtigingen, batterij-instellingen en het besturingssysteem kunnen ze vertragen of verhinderen. De lijst met garanties die binnenkort verlopen is altijd beschikbaar.';

  @override
  String get permissionRequired => 'Toestemming voor meldingen is vereist.';

  @override
  String get requestPermission => 'Toestemming vragen';

  @override
  String get remindersOff => 'Herinneringen zijn uitgeschakeld.';

  @override
  String get remindersUnavailable =>
      'Systeemherinneringen zijn niet beschikbaar. Gebruik de lijst met garanties die binnenkort verlopen.';

  @override
  String remindersScheduled(int count) {
    return '$count herinneringen ingepland.';
  }

  @override
  String get linuxReminderHelp =>
      'Op Linux werken herinneringen alleen zolang Kepli geopend is en er een meldingsdienst beschikbaar is.';

  @override
  String get accessibility => 'Toegankelijkheid';

  @override
  String get highContrast => 'Contrast verhogen';

  @override
  String get reduceMotion => 'Beweging verminderen';

  @override
  String get accessibilityHelp =>
      'Kepli volgt ook de systeeminstellingen voor tekstgrootte, schermlezer, contrast en verminderde beweging. Elke actie is beschikbaar zonder gebaren.';

  @override
  String get language => 'Taal';

  @override
  String get languageHelp =>
      'Kies de taal van de interface. Engels is de standaardtaal. De tekst van je opgeslagen items wordt niet vertaald.';

  @override
  String get categories => 'Categorieën';

  @override
  String get addCategory => 'Categorie toevoegen';

  @override
  String get renameCategory => 'Categorie hernoemen';

  @override
  String get deleteCategory => 'Categorie verwijderen';

  @override
  String get categoryInUse =>
      'Deze categorie wordt door een garantie gebruikt. Wijzig eerst de categorie van die garantie.';

  @override
  String get newCategory => 'Categorienaam';

  @override
  String get categoryExists => 'Die categorie bestaat al.';

  @override
  String get categoryElectronics => 'Elektronica';

  @override
  String get categoryAppliances => 'Huishoudelijke apparaten';

  @override
  String get categoryTools => 'Gereedschap';

  @override
  String get categoryOther => 'Overig';

  @override
  String get exportReports => 'Rapporten';

  @override
  String get about => 'Over Kepli';

  @override
  String get privacyTitle => 'Lokaal. Privé. Van jou.';

  @override
  String get privacyBody =>
      'Geen account, abonnement, gebruiksanalyse of Kepli-cloud. Je gegevens blijven in de opslag van deze app totdat je ze exporteert of deelt. Exporteer regelmatig reservekopieën: als je de app verwijdert of een apparaat kwijtraakt, kunnen je gegevens verloren gaan.';

  @override
  String get appVersion => 'Versie';

  @override
  String get operationFailed => 'De bewerking kon niet worden voltooid.';

  @override
  String get technicalDetails => 'Technische details';

  @override
  String get saved => 'Garantie opgeslagen op dit apparaat.';

  @override
  String get deleted => 'Garantie en bijbehorende bijlagen verwijderd.';

  @override
  String get restored =>
      'Reservekopie hersteld. Alle bijlagen waarnaar wordt verwezen zijn gecontroleerd.';

  @override
  String get settingsSaved => 'Instellingen opgeslagen.';

  @override
  String get exportReady => 'Export gereed.';

  @override
  String get exportCancelled => 'Export geannuleerd.';

  @override
  String fileSavedTo(String path) {
    return 'Bestand opgeslagen in $path';
  }

  @override
  String get shareOpened =>
      'Kies in het deelvenster waar je het bestand wilt opslaan of naartoe wilt sturen.';

  @override
  String get loading => 'Laden';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get startupError =>
      'Kepli kon je lokale gegevens niet openen. Je bestaande bestanden zijn niet opnieuw ingesteld.';

  @override
  String get unavailableImage =>
      'Afbeeldingsvoorbeeld niet beschikbaar. Je kunt het oorspronkelijke bestand nog wel openen.';

  @override
  String get largeAttachmentTitle => 'Grote bijlage';

  @override
  String largeAttachmentWarning(String size) {
    return 'Dit bestand is $size MB groot. Grote bijlagen vertragen het maken van reservekopieën en nemen meer opslagruimte in.';
  }

  @override
  String get continueAction => 'Doorgaan';

  @override
  String get recoverPhoto => 'Herstelde foto gebruiken';

  @override
  String get recoveredPhotoHelp =>
      'Er is een foto hersteld nadat de camera de app opnieuw heeft gestart. Voeg de foto toe aan een garantie zodat deze niet verloren gaat.';

  @override
  String get dismiss => 'Negeren';

  @override
  String get busy => 'Bewerking wordt uitgevoerd. Even geduld.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Gesorteerd op eerstvolgende vervaldatum';

  @override
  String get requiredFields =>
      'Naam, categorie, aankoopdatum en garantieduur zijn verplicht.';

  @override
  String get chooseDate => 'Aankoopdatum kiezen';

  @override
  String get selected => 'Geselecteerd';

  @override
  String get notSet => 'Niet ingesteld';

  @override
  String get reportTitle => 'Garantierapport';

  @override
  String get pdfReferences =>
      'Bonnen en garantiedocumenten in PDF-formaat worden op bestandsnaam vermeld. Deel zo nodig de oorspronkelijke bestanden afzonderlijk.';

  @override
  String get documentFooter =>
      'Lokaal gegenereerd door Kepli. Dit rapport is geen herstelbare reservekopie.';

  @override
  String get notificationTitle => 'Garantie verloopt binnenkort';

  @override
  String notificationBody(String name, String date) {
    return '$name: de garantie verloopt op $date.';
  }

  @override
  String get contacts => 'Contacten voor verkoop en service';

  @override
  String get addContact => 'Contact toevoegen';

  @override
  String get editContact => 'Contact bewerken';

  @override
  String get removeContact => 'Contact verwijderen';

  @override
  String get salesContact => 'Verkoop';

  @override
  String get serviceContact => 'Klantenservice';

  @override
  String get contactName => 'Contactpersoon';

  @override
  String get organization => 'Bedrijf of organisatie';

  @override
  String get phone => 'Telefoon';

  @override
  String get email => 'E-mailadres';

  @override
  String get contactNotes => 'Contactnotities';

  @override
  String get noContacts => 'Geen contacten toegevoegd';

  @override
  String get businessCard => 'Visitekaartje';

  @override
  String get scanBusinessCard => 'Visitekaartje scannen';

  @override
  String get addBusinessCard => 'Visitekaartje toevoegen';

  @override
  String get businessCardHelp =>
      'Fotografeer of importeer het kaartje en voeg het aan dit contact toe. Vul hieronder de gegevens van de persoon in; Kepli gebruikt geen tekstherkenning in de cloud.';

  @override
  String get businessCardNeedsContact =>
      'Sla de naam van het contact op voordat je een visitekaartje toevoegt.';

  @override
  String get scanDocument => 'Document scannen';

  @override
  String get scanHelp =>
      'Fotografeer pagina’s of selecteer afbeeldingen. Snijd ze vervolgens bij, draai ze en sla ze op als één PDF. De verwerking blijft op dit apparaat; tekst wordt niet automatisch uitgelezen.';

  @override
  String get addPage => 'Pagina toevoegen';

  @override
  String get removePage => 'Pagina verwijderen';

  @override
  String get rotatePage => 'Pagina draaien';

  @override
  String pageNumber(int number) {
    return 'Pagina $number';
  }

  @override
  String get cropTop => 'Bovenkant bijsnijden';

  @override
  String get cropBottom => 'Onderkant bijsnijden';

  @override
  String get cropLeft => 'Linkerkant bijsnijden';

  @override
  String get cropRight => 'Rechterkant bijsnijden';

  @override
  String get enhanceDocument => 'Documentcontrast verbeteren';

  @override
  String get saveScan => 'Scan opslaan als PDF';

  @override
  String get scanName => 'Documentnaam';

  @override
  String get noPages => 'Voeg minstens één pagina toe.';

  @override
  String get desktopScanHelp =>
      'Selecteer afbeeldingen die door je scanner of camera zijn opgeslagen. Directe aansturing van de scannerhardware is niet nodig.';

  @override
  String get attachmentType => 'Type bijlage';

  @override
  String get previousPage => 'Vorige pagina';

  @override
  String get nextPage => 'Volgende pagina';

  @override
  String get processingDocument => 'Document wordt op dit apparaat verwerkt';

  @override
  String get readOnlyDetails => 'Garantiedetails';

  @override
  String get selectWarranty =>
      'Selecteer een garantie om de details te bekijken.';
}
