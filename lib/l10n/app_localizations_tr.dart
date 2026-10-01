// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Garantileriniz. Fişleriniz. Size ait.';

  @override
  String get warranties => 'Garantiler';

  @override
  String get backups => 'Yedekler';

  @override
  String get settings => 'Ayarlar';

  @override
  String get addWarranty => 'Garanti ekle';

  @override
  String get editWarranty => 'Garantiyi düzenle';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get close => 'Kapat';

  @override
  String get edit => 'Düzenle';

  @override
  String get searchHint => 'Ad, mağaza veya kategori ara';

  @override
  String get all => 'Tümü';

  @override
  String get active => 'Geçerli';

  @override
  String get expiringSoon => 'Yakında sona erecek';

  @override
  String get expired => 'Süresi dolmuş';

  @override
  String get claimed => 'Garanti talebi yapıldı';

  @override
  String get noWarranties => 'Henüz garanti yok';

  @override
  String get getStarted =>
      'Bir satın alma ekleyin; fişini, garanti belgelerini ve iletişim bilgilerini bir arada tutun.';

  @override
  String get noMatches => 'Eşleşen garanti yok';

  @override
  String get clearFilters => 'Filtreleri temizle';

  @override
  String get purchaseDate => 'Satın alma tarihi';

  @override
  String get expiryDate => 'Bitiş tarihi';

  @override
  String get warrantyLength => 'Garanti süresi';

  @override
  String get months => 'Ay';

  @override
  String get years => 'Yıl';

  @override
  String get name => 'Ad';

  @override
  String get nameHint => 'Örneğin, mutfak buzdolabı';

  @override
  String get category => 'Kategori';

  @override
  String get vendor => 'Mağaza veya satıcı';

  @override
  String get price => 'Fiyat (isteğe bağlı)';

  @override
  String get currency => 'Para birimi kodu';

  @override
  String get notes => 'Notlar';

  @override
  String get productPhoto => 'Ürün fotoğrafı';

  @override
  String get receipt => 'Fiş';

  @override
  String get warrantyPaper => 'Garanti belgesi';

  @override
  String get attachments => 'Ekler';

  @override
  String get addFiles => 'Dosya ekle';

  @override
  String get takePhoto => 'Fotoğraf çek';

  @override
  String get choosePhoto => 'Fotoğraf seç';

  @override
  String get removeAttachment => 'Eki kaldır';

  @override
  String get openAttachment => 'Eki aç';

  @override
  String get markClaimed => 'Garanti talebi yapıldı olarak işaretle';

  @override
  String get markActive => 'Garanti talebi durumunu temizle';

  @override
  String get exportPdf => 'Garantiyi PDF olarak dışa aktar';

  @override
  String get deleteWarranty => 'Garanti silinsin mi?';

  @override
  String deleteWarrantyWarning(String name) {
    return '$name ve tüm ekleri bu cihazdan silinsin mi? Bu işlem geri alınamaz.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün kaldı',
      one: '1 gün kaldı',
      zero: 'Bugün sona eriyor',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garanti',
      one: '1 garanti',
      zero: 'Garanti yok',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Bu alan zorunludur.';

  @override
  String get invalidDuration => '1 ile 1.200 ay arasında bir süre girin.';

  @override
  String get invalidPrice => 'En fazla iki ondalık basamaklı bir tutar girin.';

  @override
  String get invalidCurrency =>
      'USD gibi üç harfli bir para birimi kodu girin.';

  @override
  String get invalidEmail => 'Geçerli bir e-posta adresi girin.';

  @override
  String get discardChanges => 'Kaydedilmemiş değişiklikler silinsin mi?';

  @override
  String get discard => 'Değişiklikleri sil';

  @override
  String get keepEditing => 'Düzenlemeye devam et';

  @override
  String get restoreBackup => 'Yedeği geri yükle';

  @override
  String get exportBackup => 'Yedeği dışa aktar';

  @override
  String get exportCsv => 'CSV olarak dışa aktar';

  @override
  String get backupExplanation =>
      'Tek bir ZIP dosyası garantilerinizi, kişilerinizi, tercihlerinizi ve özgün eklerinizi içerir. Dosyayı başka bir cihaza taşıyıp orada geri yükleyin. Bu, otomatik eşitleme değil, elle aktarımdır.';

  @override
  String get backupPrivacy =>
      'Yedekler şifrelenmez. Bunları güvenli bir yerde saklayın. Kepli’nin bulut hizmeti yoktur; sistemin paylaşım panelinde seçtiğiniz hedefler sizin kontrolünüzdedir.';

  @override
  String get chooseBackup => 'Yedek dosyası seç';

  @override
  String get backupPreview => 'Yedeği incele';

  @override
  String backupSummary(int items, int files) {
    return '$items garanti ve $files ek';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$date tarihinde $platform üzerinde dışa aktarıldı';
  }

  @override
  String get merge => 'Birleştir';

  @override
  String get mergeHelp =>
      'Yeni garantileri ekler ve eşleşen garantilerin daha yeni sürümünü korur. Mevcut tercihler korunur.';

  @override
  String get replaceAll => 'Tümünü değiştir';

  @override
  String get replaceHelp =>
      'Bu cihazdaki garantileri ve tercihleri yedektekilerle değiştirir.';

  @override
  String replaceConfirmation(int count) {
    return 'Bu cihazdaki $count garantinin tümü kalıcı olarak değiştirilsin mi? Bunları korumak istiyorsanız önce bir yedeği dışa aktarın.';
  }

  @override
  String get confirmReplace => 'Tüm garantileri değiştir';

  @override
  String get conflicts => 'Eşleşen garantiler';

  @override
  String get keepLocal => 'Bu cihazdaki sürümü koru';

  @override
  String get useBackup => 'Yedekteki daha yeni sürümü kullan';

  @override
  String get newerWinsHelp =>
      'Normalde daha yeni güncelleme esas alınır. Zaman damgaları eşitse bu cihazdaki sürüm korunur. Bunun yerine yerel sürümünü korumak istediğiniz garantileri aşağıdan seçin.';

  @override
  String get restore => 'Geri yükle';

  @override
  String get notifications => 'Hatırlatıcılar';

  @override
  String get enableReminders => 'Garanti bitişi hatırlatıcılarını etkinleştir';

  @override
  String get reminderDays => 'Bitişten kaç gün önce';

  @override
  String get reminderDaysHelp =>
      'Değerleri virgülle ayırın; örneğin 30, 7, 1. Bitiş tarihi için 0 kullanın.';

  @override
  String get reminderHour => 'Hatırlatma saati (0-23)';

  @override
  String get reminderLimit =>
      'İşletim sisteminin kuyruğuna yalnızca en yakın hatırlatıcılar sığar. Kuyruğu yenilemek için Kepli’yi düzenli olarak açın.';

  @override
  String get notificationPrivacy =>
      'Hatırlatıcılar yerel olarak planlanır. İzinler, pil ayarları ve işletim sistemi bunları geciktirebilir veya engelleyebilir. Yakında sona erecek garantiler listeniz her zaman kullanılabilir.';

  @override
  String get permissionRequired => 'Bildirim izni gereklidir.';

  @override
  String get requestPermission => 'İzin iste';

  @override
  String get remindersOff => 'Hatırlatıcılar kapalı.';

  @override
  String get remindersUnavailable =>
      'Sistem hatırlatıcıları kullanılamıyor. Yakında sona erecek garantiler listesini kullanın.';

  @override
  String remindersScheduled(int count) {
    return '$count hatırlatıcı planlandı.';
  }

  @override
  String get linuxReminderHelp =>
      'Linux’ta hatırlatıcılar yalnızca Kepli açıkken ve bir bildirim hizmeti kullanılabilir durumdayken çalışır.';

  @override
  String get accessibility => 'Erişilebilirlik';

  @override
  String get highContrast => 'Kontrastı artır';

  @override
  String get reduceMotion => 'Hareketi azalt';

  @override
  String get accessibilityHelp =>
      'Kepli ayrıca sisteminizin metin boyutu, ekran okuyucu, kontrast ve azaltılmış hareket ayarlarına uyar. Tüm işlemler hareket kontrolleri olmadan da kullanılabilir.';

  @override
  String get language => 'Dil';

  @override
  String get languageHelp =>
      'Arayüz dilini seçin. Varsayılan dil İngilizcedir. Kaydedilmiş öğelerinizin metni çevrilmez.';

  @override
  String get categories => 'Kategoriler';

  @override
  String get addCategory => 'Kategori ekle';

  @override
  String get renameCategory => 'Kategoriyi yeniden adlandır';

  @override
  String get deleteCategory => 'Kategoriyi sil';

  @override
  String get categoryInUse =>
      'Bu kategori bir garanti tarafından kullanılıyor. Önce o garantinin kategorisini değiştirin.';

  @override
  String get newCategory => 'Kategori adı';

  @override
  String get categoryExists => 'Bu kategori zaten var.';

  @override
  String get categoryElectronics => 'Elektronik';

  @override
  String get categoryAppliances => 'Ev aletleri';

  @override
  String get categoryTools => 'Aletler';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get exportReports => 'Raporlar';

  @override
  String get about => 'Kepli hakkında';

  @override
  String get privacyTitle => 'Yerel. Özel. Size ait.';

  @override
  String get privacyBody =>
      'Hesap, abonelik, kullanım analizi veya Kepli bulutu yok. Kayıtlarınız, siz dışa aktarıncaya veya paylaşıncaya kadar bu uygulamanın depolama alanında kalır. Yedekleri düzenli olarak dışa aktarın: uygulamayı kaldırmak veya bir cihazı kaybetmek veri kaybına neden olabilir.';

  @override
  String get appVersion => 'Sürüm';

  @override
  String get operationFailed => 'İşlem tamamlanamadı.';

  @override
  String get technicalDetails => 'Teknik ayrıntılar';

  @override
  String get saved => 'Garanti bu cihaza kaydedildi.';

  @override
  String get deleted => 'Garanti ve ekleri silindi.';

  @override
  String get restored =>
      'Yedek geri yüklendi. Başvurulan tüm ekler doğrulandı.';

  @override
  String get settingsSaved => 'Ayarlar kaydedildi.';

  @override
  String get exportReady => 'Dışa aktarım hazır.';

  @override
  String get exportCancelled => 'Dışa aktarım iptal edildi.';

  @override
  String fileSavedTo(String path) {
    return 'Dosya $path konumuna kaydedildi';
  }

  @override
  String get shareOpened =>
      'Paylaşım panelinde dosyayı nereye kaydedeceğinizi veya göndereceğinizi seçin.';

  @override
  String get loading => 'Yükleniyor';

  @override
  String get retry => 'Yeniden dene';

  @override
  String get startupError =>
      'Kepli yerel verilerinizi açamadı. Mevcut dosyalarınız sıfırlanmadı.';

  @override
  String get unavailableImage =>
      'Görsel önizlemesi kullanılamıyor. Özgün dosyayı yine de açabilirsiniz.';

  @override
  String get largeAttachmentTitle => 'Büyük ek';

  @override
  String largeAttachmentWarning(String size) {
    return 'Bu dosya $size MB. Büyük ekler yedeklemeleri yavaşlatır ve daha fazla depolama alanı kullanır.';
  }

  @override
  String get continueAction => 'Devam et';

  @override
  String get recoverPhoto => 'Kurtarılan fotoğrafı kullan';

  @override
  String get recoveredPhotoHelp =>
      'Kamera uygulamayı yeniden başlattıktan sonra bir fotoğraf kurtarıldı. Kaybolmaması için onu bir garantiye ekleyin.';

  @override
  String get dismiss => 'Kapat';

  @override
  String get busy => 'İşlem sürüyor. Lütfen bekleyin.';

  @override
  String get menu => 'Menü';

  @override
  String get sortHint => 'En yakın bitiş tarihine göre sıralı';

  @override
  String get requiredFields =>
      'Ad, kategori, satın alma tarihi ve garanti süresi zorunludur.';

  @override
  String get chooseDate => 'Satın alma tarihi seç';

  @override
  String get selected => 'Seçili';

  @override
  String get notSet => 'Belirlenmedi';

  @override
  String get reportTitle => 'Garanti raporu';

  @override
  String get pdfReferences =>
      'PDF fişleri ve garanti belgeleri dosya adına göre listelenir. Gerektiğinde özgün dosyalarını ayrıca paylaşın.';

  @override
  String get documentFooter =>
      'Kepli tarafından yerel olarak oluşturuldu. Bu rapor geri yüklenebilir bir yedek değildir.';

  @override
  String get notificationTitle => 'Garanti sona eriyor';

  @override
  String notificationBody(String name, String date) {
    return '$name: garanti $date tarihinde sona eriyor.';
  }

  @override
  String get contacts => 'Satış ve servis iletişim bilgileri';

  @override
  String get addContact => 'Kişi ekle';

  @override
  String get editContact => 'Kişiyi düzenle';

  @override
  String get removeContact => 'Kişiyi kaldır';

  @override
  String get salesContact => 'Satış';

  @override
  String get serviceContact => 'Servis';

  @override
  String get contactName => 'İlgili kişi';

  @override
  String get organization => 'Şirket veya kuruluş';

  @override
  String get phone => 'Telefon';

  @override
  String get email => 'E-posta';

  @override
  String get contactNotes => 'Kişi notları';

  @override
  String get noContacts => 'Kişi eklenmedi';

  @override
  String get businessCard => 'Kartvizit';

  @override
  String get scanBusinessCard => 'Kartvizit tara';

  @override
  String get addBusinessCard => 'Kartvizit ekle';

  @override
  String get businessCardHelp =>
      'Kartvizitin fotoğrafını çekin veya içe aktarın ve bu kişiye ekleyin. Kişinin bilgilerini aşağıya girin; Kepli bulut tabanlı optik karakter tanıma kullanmaz.';

  @override
  String get businessCardNeedsContact =>
      'Kartvizit eklemeden önce kişinin adını kaydedin.';

  @override
  String get scanDocument => 'Belge tara';

  @override
  String get scanHelp =>
      'Sayfaların fotoğrafını çekin veya görsel seçin; ardından bunları kırpın, döndürün ve tek bir PDF olarak kaydedin. İşleme bu cihazda yapılır; metin otomatik olarak çıkarılmaz.';

  @override
  String get addPage => 'Sayfa ekle';

  @override
  String get removePage => 'Sayfayı kaldır';

  @override
  String get rotatePage => 'Sayfayı döndür';

  @override
  String pageNumber(int number) {
    return 'Sayfa $number';
  }

  @override
  String get cropTop => 'Üstten kırp';

  @override
  String get cropBottom => 'Alttan kırp';

  @override
  String get cropLeft => 'Soldan kırp';

  @override
  String get cropRight => 'Sağdan kırp';

  @override
  String get enhanceDocument => 'Belge kontrastını artır';

  @override
  String get saveScan => 'Taramayı PDF olarak kaydet';

  @override
  String get scanName => 'Belge adı';

  @override
  String get noPages => 'En az bir sayfa ekleyin.';

  @override
  String get desktopScanHelp =>
      'Tarayıcınızın veya kameranızın kaydettiği görselleri seçin. Tarayıcı donanımını doğrudan kontrol etmek gerekmez.';

  @override
  String get attachmentType => 'Ek türü';

  @override
  String get previousPage => 'Önceki sayfa';

  @override
  String get nextPage => 'Sonraki sayfa';

  @override
  String get processingDocument => 'Belge bu cihazda işleniyor';

  @override
  String get readOnlyDetails => 'Garanti ayrıntıları';

  @override
  String get selectWarranty => 'Ayrıntılarını görmek için bir garanti seçin.';
}
