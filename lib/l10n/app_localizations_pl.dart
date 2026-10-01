// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Twoje gwarancje. Twoje paragony. Twoja własność.';

  @override
  String get warranties => 'Gwarancje';

  @override
  String get backups => 'Kopie zapasowe';

  @override
  String get settings => 'Ustawienia';

  @override
  String get addWarranty => 'Dodaj gwarancję';

  @override
  String get editWarranty => 'Edytuj gwarancję';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get close => 'Zamknij';

  @override
  String get edit => 'Edytuj';

  @override
  String get searchHint => 'Szukaj według nazwy, sklepu lub kategorii';

  @override
  String get all => 'Wszystkie';

  @override
  String get active => 'Aktywne';

  @override
  String get expiringSoon => 'Wkrótce wygasają';

  @override
  String get expired => 'Wygasłe';

  @override
  String get claimed => 'Reklamacja złożona';

  @override
  String get status => 'Status';

  @override
  String get noWarranties => 'Nie ma jeszcze gwarancji';

  @override
  String get getStarted =>
      'Dodaj zakup i przechowuj razem jego paragon, dokumenty gwarancyjne oraz kontakty.';

  @override
  String get noMatches => 'Brak pasujących gwarancji';

  @override
  String get clearFilters => 'Wyczyść filtry';

  @override
  String get purchaseDate => 'Data zakupu';

  @override
  String get expiryDate => 'Data wygaśnięcia';

  @override
  String get warrantyLength => 'Okres gwarancji';

  @override
  String get months => 'Miesiące';

  @override
  String get years => 'Lata';

  @override
  String get customDuration => 'Niestandardowy okres';

  @override
  String get name => 'Nazwa';

  @override
  String get nameHint => 'Na przykład lodówka w kuchni';

  @override
  String get category => 'Kategoria';

  @override
  String get vendor => 'Sklep lub sprzedawca';

  @override
  String get price => 'Cena (opcjonalnie)';

  @override
  String get currency => 'Kod waluty';

  @override
  String get notes => 'Notatki';

  @override
  String get productPhoto => 'Zdjęcie produktu';

  @override
  String get receipt => 'Paragon';

  @override
  String get warrantyPaper => 'Dokument gwarancyjny';

  @override
  String get attachments => 'Załączniki';

  @override
  String get addFiles => 'Dodaj pliki';

  @override
  String get takePhoto => 'Zrób zdjęcie';

  @override
  String get choosePhoto => 'Wybierz zdjęcia';

  @override
  String get removeAttachment => 'Usuń załącznik';

  @override
  String get openAttachment => 'Otwórz załącznik';

  @override
  String get markClaimed => 'Oznacz złożenie reklamacji';

  @override
  String get markActive => 'Usuń oznaczenie złożonej reklamacji';

  @override
  String get exportPdf => 'Eksportuj gwarancję do PDF';

  @override
  String get deleteWarranty => 'Usunąć gwarancję?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Usunąć $name i wszystkie powiązane załączniki z tego urządzenia? Tej operacji nie można cofnąć.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Pozostało $count dnia',
      many: 'Pozostało $count dni',
      few: 'Pozostały $count dni',
      one: 'Pozostał $count dzień',
      zero: 'Wygasa dzisiaj',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gwarancji',
      many: '$count gwarancji',
      few: '$count gwarancje',
      one: '$count gwarancja',
      zero: 'Brak gwarancji',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'To pole jest wymagane.';

  @override
  String get invalidDuration => 'Wpisz okres od 1 do 1200 miesięcy.';

  @override
  String get invalidPrice =>
      'Wpisz kwotę z najwyżej dwoma miejscami po przecinku.';

  @override
  String get invalidCurrency =>
      'Wpisz trzyliterowy kod waluty, na przykład USD.';

  @override
  String get invalidEmail => 'Wpisz prawidłowy adres e-mail.';

  @override
  String get discardChanges => 'Odrzucić niezapisane zmiany?';

  @override
  String get discard => 'Odrzuć';

  @override
  String get keepEditing => 'Kontynuuj edycję';

  @override
  String get restoreBackup => 'Przywróć kopię zapasową';

  @override
  String get exportBackup => 'Eksportuj kopię zapasową';

  @override
  String get exportCsv => 'Eksportuj CSV';

  @override
  String get backupExplanation =>
      'Jeden plik ZIP zawiera Twoje gwarancje, kontakty, preferencje i oryginalne załączniki. Przenieś go na inne urządzenie i przywróć tam dane. To ręczny transfer, a nie automatyczna synchronizacja.';

  @override
  String get backupPrivacy =>
      'Kopie zapasowe nie są szyfrowane. Przechowuj je w bezpiecznym miejscu. Kepli nie ma usługi w chmurze; samodzielnie wybierasz miejsca docelowe w systemowym panelu udostępniania.';

  @override
  String get chooseBackup => 'Wybierz plik kopii zapasowej';

  @override
  String get backupPreview => 'Sprawdź kopię zapasową';

  @override
  String get newWarranties => 'Nowe gwarancje';

  @override
  String backupSummary(int items, int files) {
    return 'Gwarancje: $items; załączniki: $files';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Wyeksportowano $date na platformie $platform';
  }

  @override
  String get merge => 'Scal';

  @override
  String get mergeHelp =>
      'Dodaje nowe gwarancje i zachowuje nowszą wersję pasujących gwarancji. Bieżące preferencje zostają zachowane.';

  @override
  String get replaceAll => 'Zastąp wszystko';

  @override
  String get replaceHelp =>
      'Zastępuje gwarancje i preferencje na tym urządzeniu danymi z kopii zapasowej.';

  @override
  String replaceConfirmation(int count) {
    return 'Trwale zastąpić wszystkie gwarancje na tym urządzeniu ($count)? Najpierw wyeksportuj kopię zapasową, jeśli chcesz je zachować.';
  }

  @override
  String get confirmReplace => 'Zastąp wszystkie gwarancje';

  @override
  String get conflicts => 'Pasujące gwarancje';

  @override
  String get keepLocal => 'Zachowaj wersję z tego urządzenia';

  @override
  String get useBackup => 'Użyj nowszej wersji z kopii zapasowej';

  @override
  String get newerWinsHelp =>
      'Zazwyczaj wybierana jest nowsza aktualizacja. Gdy znaczniki czasu są takie same, zachowywana jest wersja z tego urządzenia. Wybierz gwarancje poniżej, aby zamiast tego zachować ich lokalną wersję.';

  @override
  String get restore => 'Przywróć';

  @override
  String get notifications => 'Przypomnienia';

  @override
  String get enableReminders => 'Włącz przypomnienia o wygaśnięciu';

  @override
  String get reminderDays => 'Dni przed wygaśnięciem';

  @override
  String get reminderDaysHelp =>
      'Oddziel wartości przecinkami, na przykład 30, 7, 1. Użyj 0 dla dnia wygaśnięcia.';

  @override
  String get invalidReminderDays =>
      'Wpisz od 1 do 12 różnych wartości, każdą z zakresu od 0 do 3650 dni.';

  @override
  String get reminderHour => 'Godzina przypomnienia (0–23)';

  @override
  String get invalidReminderHour => 'Wpisz godzinę od 0 do 23.';

  @override
  String get reminderLimit =>
      'W kolejce systemu operacyjnego mieszczą się tylko najbliższe przypomnienia. Regularnie otwieraj Kepli, aby ją uzupełniać.';

  @override
  String get notificationPrivacy =>
      'Przypomnienia są planowane lokalnie. Uprawnienia, ustawienia baterii i system operacyjny mogą je opóźnić lub zablokować. Lista gwarancji, które wkrótce wygasną, jest zawsze dostępna.';

  @override
  String get permissionRequired => 'Wymagane jest uprawnienie do powiadomień.';

  @override
  String get requestPermission => 'Poproś o uprawnienie';

  @override
  String get remindersOff => 'Przypomnienia są wyłączone.';

  @override
  String get remindersUnavailable =>
      'Przypomnienia systemowe są niedostępne. Użyj listy gwarancji, które wkrótce wygasną.';

  @override
  String remindersScheduled(int count) {
    return 'Zaplanowane przypomnienia: $count.';
  }

  @override
  String get linuxReminderHelp =>
      'W systemie Linux przypomnienia działają tylko wtedy, gdy Kepli jest otwarte i dostępna jest usługa powiadomień.';

  @override
  String get accessibility => 'Ułatwienia dostępu';

  @override
  String get highContrast => 'Zwiększ kontrast';

  @override
  String get reduceMotion => 'Ogranicz ruch';

  @override
  String get accessibilityHelp =>
      'Kepli uwzględnia też systemowe ustawienia rozmiaru tekstu, czytnika ekranu, kontrastu i ograniczonego ruchu. Wszystkie działania są dostępne bez gestów.';

  @override
  String get language => 'Język';

  @override
  String get languageHelp =>
      'Wybierz język interfejsu. Domyślny język to angielski. Tekst zapisanych elementów nie jest tłumaczony.';

  @override
  String get categories => 'Kategorie';

  @override
  String get addCategory => 'Dodaj kategorię';

  @override
  String get renameCategory => 'Zmień nazwę kategorii';

  @override
  String get deleteCategory => 'Usuń kategorię';

  @override
  String get categoryInUse =>
      'Ta kategoria jest używana przez gwarancję. Najpierw zmień kategorię tej gwarancji.';

  @override
  String get newCategory => 'Nazwa kategorii';

  @override
  String get categoryExists => 'Taka kategoria już istnieje.';

  @override
  String get categoryElectronics => 'Elektronika';

  @override
  String get categoryAppliances => 'Sprzęt AGD';

  @override
  String get categoryTools => 'Narzędzia';

  @override
  String get categoryOther => 'Inne';

  @override
  String get exportReports => 'Raporty';

  @override
  String get about => 'O Kepli';

  @override
  String get privacyTitle => 'Lokalne. Prywatne. Twoje.';

  @override
  String get privacyBody =>
      'Bez konta, subskrypcji, analityki ani chmury Kepli. Twoje dane pozostają w pamięci aplikacji, dopóki ich nie wyeksportujesz lub nie udostępnisz. Regularnie eksportuj kopie zapasowe: odinstalowanie aplikacji lub utrata urządzenia może spowodować utratę danych.';

  @override
  String get appVersion => 'Wersja';

  @override
  String get operationFailed => 'Nie udało się ukończyć operacji.';

  @override
  String get technicalDetails => 'Szczegóły techniczne';

  @override
  String get saved => 'Gwarancja została zapisana na tym urządzeniu.';

  @override
  String get deleted => 'Gwarancja i jej załączniki zostały usunięte.';

  @override
  String get restored =>
      'Kopia zapasowa została przywrócona. Sprawdzono wszystkie załączniki, do których się odwołuje.';

  @override
  String get settingsSaved => 'Ustawienia zostały zapisane.';

  @override
  String get exportReady => 'Eksport jest gotowy.';

  @override
  String get exportCancelled => 'Eksport został anulowany.';

  @override
  String fileSavedTo(String path) {
    return 'Plik zapisano w $path';
  }

  @override
  String get shareOpened =>
      'W panelu udostępniania wybierz, gdzie zapisać lub wysłać plik.';

  @override
  String get loading => 'Ładowanie';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get startupError =>
      'Kepli nie może otworzyć Twoich lokalnych danych. Istniejące pliki nie zostały zresetowane.';

  @override
  String get unavailableImage =>
      'Podgląd obrazu jest niedostępny. Nadal możesz otworzyć oryginalny plik.';

  @override
  String get largeAttachmentTitle => 'Duży załącznik';

  @override
  String largeAttachmentWarning(String size) {
    return 'Ten plik ma $size MB. Duże załączniki spowalniają tworzenie kopii zapasowych i zajmują więcej miejsca.';
  }

  @override
  String get continueAction => 'Kontynuuj';

  @override
  String get recoverPhoto => 'Użyj odzyskanego zdjęcia';

  @override
  String get recoveredPhotoHelp =>
      'Odzyskano zdjęcie po ponownym uruchomieniu aplikacji przez aparat. Dodaj je do gwarancji, aby go nie utracić.';

  @override
  String get dismiss => 'Odrzuć';

  @override
  String get busy => 'Operacja w toku. Poczekaj.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Posortowane według najbliższej daty wygaśnięcia';

  @override
  String get requiredFields =>
      'Nazwa, kategoria, data zakupu i okres gwarancji są wymagane.';

  @override
  String get chooseDate => 'Wybierz datę zakupu';

  @override
  String get selected => 'Wybrano';

  @override
  String get notSet => 'Nie ustawiono';

  @override
  String get reportTitle => 'Raport gwarancji';

  @override
  String get pdfReferences =>
      'Paragony i dokumenty gwarancyjne w formacie PDF są wymienione według nazw plików. W razie potrzeby udostępnij oryginalne pliki osobno.';

  @override
  String get documentFooter =>
      'Wygenerowano lokalnie przez Kepli. Ten raport nie jest kopią zapasową do przywrócenia danych.';

  @override
  String get notificationTitle => 'Gwarancja wkrótce wygasa';

  @override
  String notificationBody(String name, String date) {
    return '$name: gwarancja wygasa $date.';
  }

  @override
  String get contacts => 'Kontakty do sprzedaży i serwisu';

  @override
  String get addContact => 'Dodaj kontakt';

  @override
  String get editContact => 'Edytuj kontakt';

  @override
  String get removeContact => 'Usuń kontakt';

  @override
  String get salesContact => 'Sprzedaż';

  @override
  String get serviceContact => 'Serwis';

  @override
  String get contactName => 'Osoba kontaktowa';

  @override
  String get organization => 'Firma lub organizacja';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'Adres e-mail';

  @override
  String get contactNotes => 'Notatki o kontakcie';

  @override
  String get noContacts => 'Nie dodano kontaktów';

  @override
  String get businessCard => 'Wizytówka';

  @override
  String get scanBusinessCard => 'Zeskanuj wizytówkę';

  @override
  String get addBusinessCard => 'Dodaj wizytówkę';

  @override
  String get businessCardHelp =>
      'Zrób zdjęcie wizytówki lub zaimportuj ją i dołącz do tego kontaktu. Wpisz dane osoby poniżej; Kepli nie korzysta z rozpoznawania tekstu w chmurze.';

  @override
  String get businessCardNeedsContact =>
      'Zapisz nazwę kontaktu przed dołączeniem wizytówki.';

  @override
  String get scanDocument => 'Zeskanuj dokument';

  @override
  String get scanHelp =>
      'Zrób zdjęcia stron lub wybierz obrazy, a następnie przytnij je, obróć i zapisz jako jeden plik PDF. Przetwarzanie odbywa się na tym urządzeniu; tekst nie jest automatycznie wyodrębniany.';

  @override
  String get addPage => 'Dodaj stronę';

  @override
  String get removePage => 'Usuń stronę';

  @override
  String get rotatePage => 'Obróć stronę';

  @override
  String pageNumber(int number) {
    return 'Strona $number';
  }

  @override
  String get cropTop => 'Przytnij od góry';

  @override
  String get cropBottom => 'Przytnij od dołu';

  @override
  String get cropLeft => 'Przytnij od lewej';

  @override
  String get cropRight => 'Przytnij od prawej';

  @override
  String get enhanceDocument => 'Zwiększ kontrast dokumentu';

  @override
  String get saveScan => 'Zapisz skan jako PDF';

  @override
  String get scanName => 'Nazwa dokumentu';

  @override
  String get noPages => 'Dodaj co najmniej jedną stronę.';

  @override
  String get desktopScanHelp =>
      'Wybierz obrazy zapisane przez skaner lub aparat. Bezpośrednie sterowanie sprzętem skanera nie jest wymagane.';

  @override
  String get attachmentType => 'Typ załącznika';

  @override
  String get previousPage => 'Poprzednia strona';

  @override
  String get nextPage => 'Następna strona';

  @override
  String get processingDocument => 'Przetwarzanie dokumentu na tym urządzeniu';

  @override
  String get readOnlyDetails => 'Szczegóły gwarancji';

  @override
  String get selectWarranty =>
      'Wybierz gwarancję, aby wyświetlić jej szczegóły.';
}
