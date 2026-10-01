// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Vos garanties. Vos reçus. À vous.';

  @override
  String get warranties => 'Garanties';

  @override
  String get backups => 'Sauvegardes';

  @override
  String get settings => 'Paramètres';

  @override
  String get addWarranty => 'Ajouter une garantie';

  @override
  String get editWarranty => 'Modifier la garantie';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get close => 'Fermer';

  @override
  String get edit => 'Modifier';

  @override
  String get searchHint => 'Rechercher par nom, magasin ou catégorie';

  @override
  String get all => 'Toutes';

  @override
  String get active => 'En cours';

  @override
  String get expiringSoon => 'Expirent bientôt';

  @override
  String get expired => 'Expirées';

  @override
  String get claimed => 'Réclamation effectuée';

  @override
  String get status => 'Statut';

  @override
  String get noWarranties => 'Aucune garantie pour le moment';

  @override
  String get getStarted =>
      'Ajoutez un achat et regroupez son reçu, ses documents de garantie et ses contacts.';

  @override
  String get noMatches => 'Aucune garantie correspondante';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get purchaseDate => 'Date d’achat';

  @override
  String get expiryDate => 'Date d’expiration';

  @override
  String get warrantyLength => 'Durée de la garantie';

  @override
  String get months => 'Mois';

  @override
  String get years => 'Années';

  @override
  String get customDuration => 'Durée personnalisée';

  @override
  String get name => 'Nom';

  @override
  String get nameHint => 'Par exemple, réfrigérateur de la cuisine';

  @override
  String get category => 'Catégorie';

  @override
  String get vendor => 'Magasin ou vendeur';

  @override
  String get price => 'Prix (facultatif)';

  @override
  String get currency => 'Code de devise';

  @override
  String get notes => 'Remarques';

  @override
  String get productPhoto => 'Photo du produit';

  @override
  String get receipt => 'Reçu';

  @override
  String get warrantyPaper => 'Document de garantie';

  @override
  String get attachments => 'Pièces jointes';

  @override
  String get addFiles => 'Ajouter des fichiers';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get choosePhoto => 'Choisir des photos';

  @override
  String get removeAttachment => 'Retirer la pièce jointe';

  @override
  String get openAttachment => 'Ouvrir la pièce jointe';

  @override
  String get markClaimed => 'Marquer comme réclamation effectuée';

  @override
  String get markActive => 'Retirer le statut de réclamation';

  @override
  String get exportPdf => 'Exporter la garantie en PDF';

  @override
  String get deleteWarranty => 'Supprimer la garantie ?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Supprimer $name et toutes ses pièces jointes de cet appareil ? Cette action est irréversible.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours restants',
      one: '1 jour restant',
      zero: 'Expire aujourd’hui',
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
      zero: 'Aucune garantie',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Ce champ est obligatoire.';

  @override
  String get invalidDuration => 'Saisissez une durée de 1 à 1 200 mois.';

  @override
  String get invalidPrice =>
      'Saisissez un montant avec deux décimales au maximum.';

  @override
  String get invalidCurrency =>
      'Saisissez un code de devise à trois lettres, par exemple USD.';

  @override
  String get invalidEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String get discardChanges =>
      'Abandonner les modifications non enregistrées ?';

  @override
  String get discard => 'Abandonner';

  @override
  String get keepEditing => 'Continuer la modification';

  @override
  String get restoreBackup => 'Restaurer une sauvegarde';

  @override
  String get exportBackup => 'Exporter une sauvegarde';

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String get backupExplanation =>
      'Un seul fichier ZIP contient vos garanties, contacts, préférences et pièces jointes d’origine. Transférez-le sur un autre appareil pour y restaurer son contenu. Il s’agit d’un transfert manuel, pas d’une synchronisation automatique.';

  @override
  String get backupPrivacy =>
      'Les sauvegardes ne sont pas chiffrées. Conservez-les en lieu sûr. Kepli ne dispose d’aucun service cloud ; vous contrôlez les destinations choisies dans le panneau de partage du système.';

  @override
  String get chooseBackup => 'Choisir un fichier de sauvegarde';

  @override
  String get backupPreview => 'Examiner la sauvegarde';

  @override
  String get newWarranties => 'Nouvelles garanties';

  @override
  String backupSummary(int items, int files) {
    return '$items garanties et $files pièces jointes';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Exporté le $date sur $platform';
  }

  @override
  String get merge => 'Fusionner';

  @override
  String get mergeHelp =>
      'Ajoute les nouvelles garanties et conserve la version la plus récente des garanties correspondantes. Les préférences actuelles sont conservées.';

  @override
  String get replaceAll => 'Tout remplacer';

  @override
  String get replaceHelp =>
      'Remplace les garanties et les préférences de cet appareil par celles de la sauvegarde.';

  @override
  String replaceConfirmation(int count) {
    return 'Remplacer définitivement les $count garanties de cet appareil ? Exportez d’abord une sauvegarde si vous souhaitez les conserver.';
  }

  @override
  String get confirmReplace => 'Remplacer toutes les garanties';

  @override
  String get conflicts => 'Garanties correspondantes';

  @override
  String get keepLocal => 'Conserver la version de cet appareil';

  @override
  String get useBackup => 'Utiliser la version plus récente de la sauvegarde';

  @override
  String get newerWinsHelp =>
      'La mise à jour la plus récente est normalement retenue. Si les horodatages sont identiques, la version de cet appareil est conservée. Sélectionnez les garanties ci-dessous pour conserver plutôt leur version locale.';

  @override
  String get restore => 'Restaurer';

  @override
  String get notifications => 'Rappels';

  @override
  String get enableReminders => 'Activer les rappels d’expiration';

  @override
  String get reminderDays => 'Jours avant l’expiration';

  @override
  String get reminderDaysHelp =>
      'Séparez les valeurs par des virgules, par exemple 30, 7, 1. Utilisez 0 pour la date d’expiration.';

  @override
  String get invalidReminderDays =>
      'Saisissez de 1 à 12 valeurs distinctes, chacune comprise entre 0 et 3 650 jours.';

  @override
  String get reminderHour => 'Heure du rappel (0-23)';

  @override
  String get invalidReminderHour =>
      'Saisissez une heure comprise entre 0 et 23.';

  @override
  String get reminderLimit =>
      'Seuls les rappels les plus proches tiennent dans la file d’attente du système d’exploitation. Ouvrez régulièrement Kepli pour la réapprovisionner.';

  @override
  String get notificationPrivacy =>
      'Les rappels sont programmés localement. Les autorisations, les paramètres de batterie et le système d’exploitation peuvent les retarder ou les empêcher. La liste des garanties qui expirent bientôt reste toujours disponible.';

  @override
  String get permissionRequired =>
      'L’autorisation d’envoyer des notifications est requise.';

  @override
  String get requestPermission => 'Demander l’autorisation';

  @override
  String get remindersOff => 'Les rappels sont désactivés.';

  @override
  String get remindersUnavailable =>
      'Les rappels système sont indisponibles. Utilisez la liste des garanties qui expirent bientôt.';

  @override
  String remindersScheduled(int count) {
    return '$count rappels programmés.';
  }

  @override
  String get linuxReminderHelp =>
      'Sous Linux, les rappels fonctionnent uniquement lorsque Kepli est ouvert et qu’un service de notifications est disponible.';

  @override
  String get accessibility => 'Accessibilité';

  @override
  String get highContrast => 'Augmenter le contraste';

  @override
  String get reduceMotion => 'Réduire les animations';

  @override
  String get accessibilityHelp =>
      'Kepli respecte également les réglages système de taille du texte, de lecteur d’écran, de contraste et de réduction des animations. Toutes les actions sont accessibles sans gestes.';

  @override
  String get language => 'Langue';

  @override
  String get languageHelp =>
      'Choisissez la langue de l’interface. L’anglais est la langue par défaut. Le texte des éléments enregistrés n’est pas traduit.';

  @override
  String get categories => 'Catégories';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get renameCategory => 'Renommer la catégorie';

  @override
  String get deleteCategory => 'Supprimer la catégorie';

  @override
  String get categoryInUse =>
      'Cette catégorie est utilisée par une garantie. Modifiez d’abord la catégorie de cette garantie.';

  @override
  String get newCategory => 'Nom de la catégorie';

  @override
  String get categoryExists => 'Cette catégorie existe déjà.';

  @override
  String get categoryElectronics => 'Électronique';

  @override
  String get categoryAppliances => 'Électroménager';

  @override
  String get categoryTools => 'Outils';

  @override
  String get categoryOther => 'Autres';

  @override
  String get exportReports => 'Rapports';

  @override
  String get about => 'À propos de Kepli';

  @override
  String get privacyTitle => 'Local. Privé. À vous.';

  @override
  String get privacyBody =>
      'Ni compte, ni abonnement, ni analyse d’utilisation, ni cloud Kepli. Vos données restent dans le stockage de cette application jusqu’à ce que vous les exportiez ou les partagiez. Exportez régulièrement des sauvegardes : désinstaller l’application ou perdre un appareil peut entraîner la perte de vos données.';

  @override
  String get appVersion => 'Version de l’application';

  @override
  String get operationFailed => 'L’opération n’a pas pu être effectuée.';

  @override
  String get technicalDetails => 'Détails techniques';

  @override
  String get saved => 'Garantie enregistrée sur cet appareil.';

  @override
  String get deleted => 'Garantie et pièces jointes supprimées.';

  @override
  String get restored =>
      'Sauvegarde restaurée. Toutes les pièces jointes référencées ont été vérifiées.';

  @override
  String get settingsSaved => 'Paramètres enregistrés.';

  @override
  String get exportReady => 'Exportation prête.';

  @override
  String get exportCancelled => 'Exportation annulée.';

  @override
  String fileSavedTo(String path) {
    return 'Fichier enregistré dans $path';
  }

  @override
  String get shareOpened =>
      'Choisissez où enregistrer ou envoyer le fichier dans le panneau de partage.';

  @override
  String get loading => 'Chargement';

  @override
  String get retry => 'Réessayer';

  @override
  String get startupError =>
      'Kepli n’a pas pu ouvrir vos données locales. Vos fichiers existants n’ont pas été réinitialisés.';

  @override
  String get unavailableImage =>
      'L’aperçu de l’image est indisponible. Vous pouvez toujours ouvrir le fichier d’origine.';

  @override
  String get largeAttachmentTitle => 'Pièce jointe volumineuse';

  @override
  String largeAttachmentWarning(String size) {
    return 'Ce fichier fait $size Mo. Les pièces jointes volumineuses ralentissent les sauvegardes et occupent davantage d’espace.';
  }

  @override
  String get continueAction => 'Continuer';

  @override
  String get recoverPhoto => 'Utiliser la photo récupérée';

  @override
  String get recoveredPhotoHelp =>
      'Une photo a été récupérée après le redémarrage de l’application provoqué par l’appareil photo. Ajoutez-la à une garantie pour ne pas la perdre.';

  @override
  String get dismiss => 'Ignorer';

  @override
  String get busy => 'Opération en cours. Veuillez patienter.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Triées par date d’expiration la plus proche';

  @override
  String get requiredFields =>
      'Le nom, la catégorie, la date d’achat et la durée de la garantie sont obligatoires.';

  @override
  String get chooseDate => 'Choisir la date d’achat';

  @override
  String get selected => 'Sélectionné';

  @override
  String get notSet => 'Non défini';

  @override
  String get reportTitle => 'Rapport des garanties';

  @override
  String get pdfReferences =>
      'Les reçus et documents de garantie au format PDF sont répertoriés par nom de fichier. Partagez leurs fichiers d’origine séparément si nécessaire.';

  @override
  String get documentFooter =>
      'Généré localement par Kepli. Ce rapport n’est pas une sauvegarde pouvant être restaurée.';

  @override
  String get notificationTitle => 'Une garantie expire bientôt';

  @override
  String notificationBody(String name, String date) {
    return '$name : la garantie expire le $date.';
  }

  @override
  String get contacts => 'Contacts commerciaux et de service après-vente';

  @override
  String get addContact => 'Ajouter un contact';

  @override
  String get editContact => 'Modifier le contact';

  @override
  String get removeContact => 'Retirer le contact';

  @override
  String get salesContact => 'Vente';

  @override
  String get serviceContact => 'Service après-vente';

  @override
  String get contactName => 'Personne à contacter';

  @override
  String get organization => 'Entreprise ou organisation';

  @override
  String get phone => 'Téléphone';

  @override
  String get email => 'Adresse e-mail';

  @override
  String get contactNotes => 'Remarques sur le contact';

  @override
  String get noContacts => 'Aucun contact ajouté';

  @override
  String get businessCard => 'Carte de visite';

  @override
  String get scanBusinessCard => 'Numériser une carte de visite';

  @override
  String get addBusinessCard => 'Ajouter une carte de visite';

  @override
  String get businessCardHelp =>
      'Photographiez ou importez la carte et joignez-la à ce contact. Saisissez les coordonnées de la personne ci-dessous ; Kepli n’utilise pas de reconnaissance optique de caractères dans le cloud.';

  @override
  String get businessCardNeedsContact =>
      'Enregistrez le nom du contact avant de joindre une carte de visite.';

  @override
  String get scanDocument => 'Numériser un document';

  @override
  String get scanHelp =>
      'Photographiez des pages ou sélectionnez des images, puis recadrez-les, faites-les pivoter et enregistrez-les dans un seul PDF. Le traitement reste sur cet appareil ; le texte n’est pas extrait automatiquement.';

  @override
  String get addPage => 'Ajouter une page';

  @override
  String get removePage => 'Retirer la page';

  @override
  String get rotatePage => 'Faire pivoter la page';

  @override
  String pageNumber(int number) {
    return 'Page $number';
  }

  @override
  String get cropTop => 'Rogner en haut';

  @override
  String get cropBottom => 'Rogner en bas';

  @override
  String get cropLeft => 'Rogner à gauche';

  @override
  String get cropRight => 'Rogner à droite';

  @override
  String get enhanceDocument => 'Améliorer le contraste du document';

  @override
  String get saveScan => 'Enregistrer la numérisation en PDF';

  @override
  String get scanName => 'Nom du document';

  @override
  String get noPages => 'Ajoutez au moins une page.';

  @override
  String get desktopScanHelp =>
      'Sélectionnez des images enregistrées par votre scanner ou votre appareil photo. Le contrôle direct du scanner n’est pas nécessaire.';

  @override
  String get attachmentType => 'Type de pièce jointe';

  @override
  String get previousPage => 'Page précédente';

  @override
  String get nextPage => 'Page suivante';

  @override
  String get processingDocument => 'Traitement du document sur cet appareil';

  @override
  String get readOnlyDetails => 'Détails de la garantie';

  @override
  String get selectWarranty =>
      'Sélectionnez une garantie pour afficher ses détails.';
}
