// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Le tue garanzie. Le tue ricevute. Solo tue.';

  @override
  String get warranties => 'Garanzie';

  @override
  String get backups => 'Copie di sicurezza';

  @override
  String get settings => 'Impostazioni';

  @override
  String get addWarranty => 'Aggiungi garanzia';

  @override
  String get editWarranty => 'Modifica garanzia';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get close => 'Chiudi';

  @override
  String get edit => 'Modifica';

  @override
  String get searchHint => 'Cerca per nome, negozio o categoria';

  @override
  String get all => 'Tutte';

  @override
  String get active => 'Attive';

  @override
  String get expiringSoon => 'In scadenza';

  @override
  String get expired => 'Scadute';

  @override
  String get claimed => 'Richiesta in garanzia presentata';

  @override
  String get noWarranties => 'Non ci sono ancora garanzie';

  @override
  String get getStarted =>
      'Aggiungi un acquisto e conserva insieme la ricevuta, i documenti di garanzia e i contatti.';

  @override
  String get noMatches => 'Nessuna garanzia corrispondente';

  @override
  String get clearFilters => 'Cancella filtri';

  @override
  String get purchaseDate => 'Data di acquisto';

  @override
  String get expiryDate => 'Data di scadenza';

  @override
  String get warrantyLength => 'Durata della garanzia';

  @override
  String get months => 'Mesi';

  @override
  String get years => 'Anni';

  @override
  String get name => 'Nome';

  @override
  String get nameHint => 'Ad esempio, frigorifero della cucina';

  @override
  String get category => 'Categoria';

  @override
  String get vendor => 'Negozio o venditore';

  @override
  String get price => 'Prezzo (facoltativo)';

  @override
  String get currency => 'Codice valuta';

  @override
  String get notes => 'Note';

  @override
  String get productPhoto => 'Foto del prodotto';

  @override
  String get receipt => 'Ricevuta';

  @override
  String get warrantyPaper => 'Documento di garanzia';

  @override
  String get attachments => 'Allegati';

  @override
  String get addFiles => 'Aggiungi file';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get choosePhoto => 'Scegli foto';

  @override
  String get removeAttachment => 'Rimuovi allegato';

  @override
  String get openAttachment => 'Apri allegato';

  @override
  String get markClaimed => 'Segna come richiesta in garanzia presentata';

  @override
  String get markActive => 'Rimuovi lo stato di richiesta in garanzia';

  @override
  String get exportPdf => 'Esporta garanzia in PDF';

  @override
  String get deleteWarranty => 'Eliminare la garanzia?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Eliminare $name e tutti i suoi allegati da questo dispositivo? L’operazione non può essere annullata.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restano $count giorni',
      one: 'Resta 1 giorno',
      zero: 'Scade oggi',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garanzie',
      one: '1 garanzia',
      zero: 'Nessuna garanzia',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Questo campo è obbligatorio.';

  @override
  String get invalidDuration => 'Inserisci una durata da 1 a 1.200 mesi.';

  @override
  String get invalidPrice =>
      'Inserisci un importo con al massimo due cifre decimali.';

  @override
  String get invalidCurrency =>
      'Inserisci un codice valuta di tre lettere, ad esempio USD.';

  @override
  String get invalidEmail => 'Inserisci un indirizzo e-mail valido.';

  @override
  String get discardChanges => 'Scartare le modifiche non salvate?';

  @override
  String get discard => 'Scarta';

  @override
  String get keepEditing => 'Continua a modificare';

  @override
  String get restoreBackup => 'Ripristina copia di sicurezza';

  @override
  String get exportBackup => 'Esporta copia di sicurezza';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get backupExplanation =>
      'Un unico file ZIP contiene le tue garanzie, i contatti, le preferenze e gli allegati originali. Trasferiscilo su un altro dispositivo e ripristinalo lì. È un trasferimento manuale, non una sincronizzazione automatica.';

  @override
  String get backupPrivacy =>
      'Le copie di sicurezza non sono crittografate. Conservale in un luogo sicuro. Kepli non ha un servizio cloud; hai il controllo delle destinazioni che scegli nel pannello di condivisione del sistema.';

  @override
  String get chooseBackup => 'Scegli file di copia di sicurezza';

  @override
  String get backupPreview => 'Controlla copia di sicurezza';

  @override
  String backupSummary(int items, int files) {
    return '$items garanzie e $files allegati';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Esportato il $date su $platform';
  }

  @override
  String get merge => 'Unisci';

  @override
  String get mergeHelp =>
      'Aggiunge le nuove garanzie e mantiene la versione più recente di quelle corrispondenti. Le preferenze attuali vengono mantenute.';

  @override
  String get replaceAll => 'Sostituisci tutto';

  @override
  String get replaceHelp =>
      'Sostituisce le garanzie e le preferenze di questo dispositivo con quelle della copia di sicurezza.';

  @override
  String replaceConfirmation(int count) {
    return 'Sostituire definitivamente tutte le $count garanzie su questo dispositivo? Esporta prima una copia di sicurezza se vuoi conservarle.';
  }

  @override
  String get confirmReplace => 'Sostituisci tutte le garanzie';

  @override
  String get conflicts => 'Garanzie corrispondenti';

  @override
  String get keepLocal => 'Mantieni la versione di questo dispositivo';

  @override
  String get useBackup =>
      'Usa la versione più recente della copia di sicurezza';

  @override
  String get newerWinsHelp =>
      'Di norma viene mantenuto l’aggiornamento più recente. Se data e ora coincidono, viene mantenuta la versione di questo dispositivo. Seleziona le garanzie qui sotto per mantenere invece la versione locale.';

  @override
  String get restore => 'Ripristina';

  @override
  String get notifications => 'Promemoria';

  @override
  String get enableReminders => 'Attiva promemoria di scadenza';

  @override
  String get reminderDays => 'Giorni prima della scadenza';

  @override
  String get reminderDaysHelp =>
      'Separa i valori con virgole, ad esempio 30, 7, 1. Usa 0 per la data di scadenza.';

  @override
  String get reminderHour => 'Ora del promemoria (0-23)';

  @override
  String get reminderLimit =>
      'Nella coda del sistema operativo c’è spazio solo per i promemoria più vicini. Apri Kepli regolarmente per aggiungerne altri.';

  @override
  String get notificationPrivacy =>
      'I promemoria sono programmati localmente. Le autorizzazioni, le impostazioni della batteria e il sistema operativo possono ritardarli o impedirli. L’elenco delle garanzie in scadenza è sempre disponibile.';

  @override
  String get permissionRequired =>
      'È necessaria l’autorizzazione per le notifiche.';

  @override
  String get requestPermission => 'Richiedi autorizzazione';

  @override
  String get remindersOff => 'I promemoria sono disattivati.';

  @override
  String get remindersUnavailable =>
      'I promemoria di sistema non sono disponibili. Usa l’elenco delle garanzie in scadenza.';

  @override
  String remindersScheduled(int count) {
    return '$count promemoria programmati.';
  }

  @override
  String get linuxReminderHelp =>
      'Su Linux, i promemoria funzionano solo mentre Kepli è aperto ed è disponibile un servizio di notifiche.';

  @override
  String get accessibility => 'Accessibilità';

  @override
  String get highContrast => 'Aumenta contrasto';

  @override
  String get reduceMotion => 'Riduci movimento';

  @override
  String get accessibilityHelp =>
      'Kepli rispetta anche le impostazioni di sistema per dimensione del testo, lettore di schermo, contrasto e riduzione del movimento. Ogni azione è disponibile senza gesti.';

  @override
  String get language => 'Lingua';

  @override
  String get languageHelp =>
      'Scegli la lingua dell’interfaccia. L’inglese è la lingua predefinita. Il testo degli elementi salvati non viene tradotto.';

  @override
  String get categories => 'Categorie';

  @override
  String get addCategory => 'Aggiungi categoria';

  @override
  String get renameCategory => 'Rinomina categoria';

  @override
  String get deleteCategory => 'Elimina categoria';

  @override
  String get categoryInUse =>
      'Questa categoria è usata da una garanzia. Cambia prima la categoria di quella garanzia.';

  @override
  String get newCategory => 'Nome della categoria';

  @override
  String get categoryExists => 'Questa categoria esiste già.';

  @override
  String get categoryElectronics => 'Elettronica';

  @override
  String get categoryAppliances => 'Elettrodomestici';

  @override
  String get categoryTools => 'Utensili';

  @override
  String get categoryOther => 'Altro';

  @override
  String get exportReports => 'Resoconti';

  @override
  String get about => 'Informazioni su Kepli';

  @override
  String get privacyTitle => 'Locale. Privato. Tuo.';

  @override
  String get privacyBody =>
      'Nessun account, abbonamento, analisi dell’utilizzo o cloud Kepli. I tuoi dati restano nell’archivio di questa app finché non li esporti o condividi. Esporta regolarmente copie di sicurezza: disinstallare l’app o perdere un dispositivo può cancellare i tuoi dati.';

  @override
  String get appVersion => 'Versione';

  @override
  String get operationFailed => 'Impossibile completare l’operazione.';

  @override
  String get technicalDetails => 'Dettagli tecnici';

  @override
  String get saved => 'Garanzia salvata su questo dispositivo.';

  @override
  String get deleted => 'Garanzia e relativi allegati eliminati.';

  @override
  String get restored =>
      'Copia di sicurezza ripristinata. Tutti gli allegati a cui fa riferimento sono stati verificati.';

  @override
  String get settingsSaved => 'Impostazioni salvate.';

  @override
  String get exportReady => 'Esportazione pronta.';

  @override
  String get exportCancelled => 'Esportazione annullata.';

  @override
  String fileSavedTo(String path) {
    return 'File salvato in $path';
  }

  @override
  String get shareOpened =>
      'Scegli dove salvare o inviare il file nel pannello di condivisione.';

  @override
  String get loading => 'Caricamento';

  @override
  String get retry => 'Riprova';

  @override
  String get startupError =>
      'Kepli non ha potuto aprire i tuoi dati locali. I file esistenti non sono stati reimpostati.';

  @override
  String get unavailableImage =>
      'Anteprima dell’immagine non disponibile. Puoi comunque aprire il file originale.';

  @override
  String get largeAttachmentTitle => 'Allegato di grandi dimensioni';

  @override
  String largeAttachmentWarning(String size) {
    return 'Questo file occupa $size MB. Gli allegati grandi rallentano le copie di sicurezza e occupano più spazio.';
  }

  @override
  String get continueAction => 'Continua';

  @override
  String get recoverPhoto => 'Usa foto recuperata';

  @override
  String get recoveredPhotoHelp =>
      'È stata recuperata una foto dopo che la fotocamera ha riavviato l’app. Aggiungila a una garanzia per non perderla.';

  @override
  String get dismiss => 'Ignora';

  @override
  String get busy => 'Operazione in corso. Attendi.';

  @override
  String get menu => 'Menù';

  @override
  String get sortHint => 'Ordinate per scadenza più vicina';

  @override
  String get requiredFields =>
      'Nome, categoria, data di acquisto e durata della garanzia sono obbligatori.';

  @override
  String get chooseDate => 'Scegli data di acquisto';

  @override
  String get selected => 'Selezionato';

  @override
  String get notSet => 'Non impostato';

  @override
  String get reportTitle => 'Resoconto delle garanzie';

  @override
  String get pdfReferences =>
      'Le ricevute e i documenti di garanzia in PDF sono elencati per nome del file. Condividi separatamente i file originali quando necessario.';

  @override
  String get documentFooter =>
      'Generato localmente da Kepli. Questo resoconto non è una copia di sicurezza ripristinabile.';

  @override
  String get notificationTitle => 'Garanzia in scadenza';

  @override
  String notificationBody(String name, String date) {
    return '$name: la garanzia scade il $date.';
  }

  @override
  String get contacts => 'Contatti di vendita e assistenza';

  @override
  String get addContact => 'Aggiungi contatto';

  @override
  String get editContact => 'Modifica contatto';

  @override
  String get removeContact => 'Rimuovi contatto';

  @override
  String get salesContact => 'Vendite';

  @override
  String get serviceContact => 'Assistenza';

  @override
  String get contactName => 'Persona di riferimento';

  @override
  String get organization => 'Azienda o organizzazione';

  @override
  String get phone => 'Telefono';

  @override
  String get email => 'Indirizzo e-mail';

  @override
  String get contactNotes => 'Note sul contatto';

  @override
  String get noContacts => 'Nessun contatto aggiunto';

  @override
  String get businessCard => 'Biglietto da visita';

  @override
  String get scanBusinessCard => 'Scansiona biglietto da visita';

  @override
  String get addBusinessCard => 'Aggiungi biglietto da visita';

  @override
  String get businessCardHelp =>
      'Fotografa o importa il biglietto e allegalo a questo contatto. Inserisci i dati della persona qui sotto; Kepli non usa il riconoscimento ottico dei caratteri nel cloud.';

  @override
  String get businessCardNeedsContact =>
      'Salva il nome del contatto prima di allegare un biglietto da visita.';

  @override
  String get scanDocument => 'Scansiona documento';

  @override
  String get scanHelp =>
      'Fotografa le pagine o seleziona le immagini, poi ritagliale, ruotale e salvale in un unico PDF. L’elaborazione resta su questo dispositivo; il testo non viene estratto automaticamente.';

  @override
  String get addPage => 'Aggiungi pagina';

  @override
  String get removePage => 'Rimuovi pagina';

  @override
  String get rotatePage => 'Ruota pagina';

  @override
  String pageNumber(int number) {
    return 'Pagina $number';
  }

  @override
  String get cropTop => 'Ritaglia dall’alto';

  @override
  String get cropBottom => 'Ritaglia dal basso';

  @override
  String get cropLeft => 'Ritaglia da sinistra';

  @override
  String get cropRight => 'Ritaglia da destra';

  @override
  String get enhanceDocument => 'Migliora contrasto del documento';

  @override
  String get saveScan => 'Salva scansione in PDF';

  @override
  String get scanName => 'Nome del documento';

  @override
  String get noPages => 'Aggiungi almeno una pagina.';

  @override
  String get desktopScanHelp =>
      'Seleziona le immagini salvate dallo scanner o dalla fotocamera. Non è necessario controllare direttamente lo scanner.';

  @override
  String get attachmentType => 'Tipo di allegato';

  @override
  String get previousPage => 'Pagina precedente';

  @override
  String get nextPage => 'Pagina successiva';

  @override
  String get processingDocument =>
      'Elaborazione del documento su questo dispositivo';

  @override
  String get readOnlyDetails => 'Dettagli della garanzia';

  @override
  String get selectWarranty =>
      'Seleziona una garanzia per visualizzarne i dettagli.';
}
