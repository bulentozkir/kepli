// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Garansi Anda. Struk Anda. Milik Anda.';

  @override
  String get warranties => 'Garansi';

  @override
  String get backups => 'Cadangan';

  @override
  String get settings => 'Pengaturan';

  @override
  String get addWarranty => 'Tambah garansi';

  @override
  String get editWarranty => 'Sunting garansi';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get close => 'Tutup';

  @override
  String get edit => 'Sunting';

  @override
  String get searchHint => 'Cari nama, toko, atau kategori';

  @override
  String get all => 'Semua';

  @override
  String get active => 'Aktif';

  @override
  String get expiringSoon => 'Segera berakhir';

  @override
  String get expired => 'Kedaluwarsa';

  @override
  String get claimed => 'Sudah diklaim';

  @override
  String get status => 'Status';

  @override
  String get noWarranties => 'Belum ada garansi';

  @override
  String get getStarted =>
      'Tambahkan pembelian dan simpan struk, dokumen garansi, serta kontaknya di satu tempat.';

  @override
  String get noMatches => 'Tidak ada garansi yang cocok';

  @override
  String get clearFilters => 'Hapus filter';

  @override
  String get purchaseDate => 'Tanggal pembelian';

  @override
  String get expiryDate => 'Tanggal berakhir';

  @override
  String get warrantyLength => 'Masa garansi';

  @override
  String get months => 'Bulan';

  @override
  String get years => 'Tahun';

  @override
  String get customDuration => 'Durasi khusus';

  @override
  String get name => 'Nama';

  @override
  String get nameHint => 'Misalnya, kulkas dapur';

  @override
  String get category => 'Kategori';

  @override
  String get vendor => 'Toko atau penjual';

  @override
  String get price => 'Harga (opsional)';

  @override
  String get currency => 'Kode mata uang';

  @override
  String get notes => 'Catatan';

  @override
  String get productPhoto => 'Foto produk';

  @override
  String get receipt => 'Struk';

  @override
  String get warrantyPaper => 'Dokumen garansi';

  @override
  String get attachments => 'Lampiran';

  @override
  String get addFiles => 'Tambah berkas';

  @override
  String get takePhoto => 'Ambil foto';

  @override
  String get choosePhoto => 'Pilih foto';

  @override
  String get removeAttachment => 'Hapus lampiran';

  @override
  String get openAttachment => 'Buka lampiran';

  @override
  String get markClaimed => 'Tandai sudah diklaim';

  @override
  String get markActive => 'Hapus status klaim';

  @override
  String get exportPdf => 'Ekspor garansi ke PDF';

  @override
  String get deleteWarranty => 'Hapus garansi?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Hapus $name dan semua lampirannya dari perangkat ini? Tindakan ini tidak dapat dibatalkan.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tersisa $count hari',
      one: 'Tersisa 1 hari',
      zero: 'Berakhir hari ini',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garansi',
      one: '1 garansi',
      zero: 'Tidak ada garansi',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Kolom ini wajib diisi.';

  @override
  String get invalidDuration => 'Masukkan 1 hingga 1.200 bulan.';

  @override
  String get invalidPrice =>
      'Masukkan jumlah dengan maksimal dua angka desimal.';

  @override
  String get invalidCurrency =>
      'Masukkan kode mata uang tiga huruf, seperti USD.';

  @override
  String get invalidEmail => 'Masukkan alamat email yang valid.';

  @override
  String get discardChanges => 'Buang perubahan yang belum disimpan?';

  @override
  String get discard => 'Buang';

  @override
  String get keepEditing => 'Lanjutkan penyuntingan';

  @override
  String get restoreBackup => 'Pulihkan cadangan';

  @override
  String get exportBackup => 'Ekspor cadangan';

  @override
  String get exportCsv => 'Ekspor CSV';

  @override
  String get backupExplanation =>
      'Satu berkas ZIP berisi garansi, kontak, preferensi, dan lampiran asli Anda. Pindahkan ke perangkat lain dan pulihkan di sana. Ini adalah pemindahan manual, bukan sinkronisasi otomatis.';

  @override
  String get backupPrivacy =>
      'Cadangan tidak dienkripsi. Simpan di tempat yang aman. Kepli tidak memiliki layanan awan; tujuan yang Anda pilih di panel berbagi sistem berada dalam kendali Anda.';

  @override
  String get chooseBackup => 'Pilih berkas cadangan';

  @override
  String get backupPreview => 'Tinjau cadangan';

  @override
  String get newWarranties => 'Garansi baru';

  @override
  String backupSummary(int items, int files) {
    return '$items garansi dan $files lampiran';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Diekspor pada $date di $platform';
  }

  @override
  String get merge => 'Gabungkan';

  @override
  String get mergeHelp =>
      'Menambahkan garansi baru dan mempertahankan versi yang lebih baru dari garansi yang cocok. Preferensi saat ini dipertahankan.';

  @override
  String get replaceAll => 'Ganti semua';

  @override
  String get replaceHelp =>
      'Mengganti garansi dan preferensi perangkat ini dengan yang ada dalam cadangan.';

  @override
  String replaceConfirmation(int count) {
    return 'Ganti secara permanen seluruh $count garansi di perangkat ini? Ekspor cadangan terlebih dahulu jika ingin menyimpannya.';
  }

  @override
  String get confirmReplace => 'Ganti semua garansi';

  @override
  String get conflicts => 'Garansi yang cocok';

  @override
  String get keepLocal => 'Pertahankan versi perangkat ini';

  @override
  String get useBackup => 'Gunakan versi cadangan yang lebih baru';

  @override
  String get newerWinsHelp =>
      'Biasanya pembaruan yang lebih baru dipilih. Jika stempel waktu sama, versi perangkat ini dipertahankan. Pilih garansi di bawah untuk mempertahankan versi lokalnya sebagai gantinya.';

  @override
  String get restore => 'Pulihkan';

  @override
  String get notifications => 'Pengingat';

  @override
  String get enableReminders => 'Aktifkan pengingat akhir masa garansi';

  @override
  String get reminderDays => 'Hari sebelum berakhir';

  @override
  String get reminderDaysHelp =>
      'Pisahkan nilai dengan koma, misalnya 30, 7, 1. Gunakan 0 untuk tanggal berakhir.';

  @override
  String get invalidReminderDays =>
      'Masukkan 1 hingga 12 nilai yang berbeda, masing-masing antara 0 dan 3.650 hari.';

  @override
  String get reminderHour => 'Jam pengingat (0-23)';

  @override
  String get invalidReminderHour => 'Masukkan jam antara 0 dan 23.';

  @override
  String get reminderLimit =>
      'Hanya pengingat terdekat yang muat dalam antrean sistem operasi. Buka Kepli secara berkala untuk mengisi kembali antrean.';

  @override
  String get notificationPrivacy =>
      'Pengingat dijadwalkan secara lokal. Izin, pengaturan baterai, dan sistem operasi dapat menunda atau mencegahnya. Daftar garansi yang segera berakhir selalu tersedia.';

  @override
  String get permissionRequired => 'Izin notifikasi diperlukan.';

  @override
  String get requestPermission => 'Minta izin';

  @override
  String get remindersOff => 'Pengingat dinonaktifkan.';

  @override
  String get remindersUnavailable =>
      'Pengingat sistem tidak tersedia. Gunakan daftar garansi yang segera berakhir.';

  @override
  String remindersScheduled(int count) {
    return '$count pengingat dijadwalkan.';
  }

  @override
  String get linuxReminderHelp =>
      'Di Linux, pengingat hanya berfungsi saat Kepli terbuka dan layanan notifikasi tersedia.';

  @override
  String get accessibility => 'Aksesibilitas';

  @override
  String get highContrast => 'Tingkatkan kontras';

  @override
  String get reduceMotion => 'Kurangi gerakan';

  @override
  String get accessibilityHelp =>
      'Kepli juga mengikuti pengaturan sistem untuk ukuran teks, pembaca layar, kontras, dan pengurangan gerakan. Semua tindakan dapat dilakukan tanpa gestur.';

  @override
  String get language => 'Bahasa';

  @override
  String get languageHelp =>
      'Pilih bahasa antarmuka. Bahasa Inggris adalah bahasa bawaan. Teks item yang Anda simpan tidak diterjemahkan.';

  @override
  String get categories => 'Kategori';

  @override
  String get addCategory => 'Tambah kategori';

  @override
  String get renameCategory => 'Ubah nama kategori';

  @override
  String get deleteCategory => 'Hapus kategori';

  @override
  String get categoryInUse =>
      'Kategori ini digunakan oleh sebuah garansi. Ubah kategori garansi tersebut terlebih dahulu.';

  @override
  String get newCategory => 'Nama kategori';

  @override
  String get categoryExists => 'Kategori tersebut sudah ada.';

  @override
  String get categoryElectronics => 'Elektronik';

  @override
  String get categoryAppliances => 'Peralatan rumah tangga';

  @override
  String get categoryTools => 'Perkakas';

  @override
  String get categoryOther => 'Lainnya';

  @override
  String get exportReports => 'Laporan';

  @override
  String get about => 'Tentang Kepli';

  @override
  String get privacyTitle => 'Lokal. Pribadi. Milik Anda.';

  @override
  String get privacyBody =>
      'Tanpa akun, langganan, analitik, atau awan Kepli. Catatan Anda tetap berada di penyimpanan aplikasi ini hingga Anda mengekspor atau membagikannya. Ekspor cadangan secara berkala: menghapus aplikasi atau kehilangan perangkat dapat menghilangkan data Anda.';

  @override
  String get appVersion => 'Versi';

  @override
  String get operationFailed => 'Operasi tidak dapat diselesaikan.';

  @override
  String get technicalDetails => 'Rincian teknis';

  @override
  String get saved => 'Garansi disimpan di perangkat ini.';

  @override
  String get deleted => 'Garansi dan lampirannya dihapus.';

  @override
  String get restored =>
      'Cadangan dipulihkan. Semua lampiran yang dirujuk telah diverifikasi.';

  @override
  String get settingsSaved => 'Pengaturan disimpan.';

  @override
  String get exportReady => 'Ekspor siap.';

  @override
  String get exportCancelled => 'Ekspor dibatalkan.';

  @override
  String fileSavedTo(String path) {
    return 'Berkas disimpan di $path';
  }

  @override
  String get shareOpened =>
      'Pilih tempat menyimpan atau tujuan pengiriman berkas di panel berbagi.';

  @override
  String get loading => 'Memuat';

  @override
  String get retry => 'Coba lagi';

  @override
  String get startupError =>
      'Kepli tidak dapat membuka data lokal Anda. Berkas yang sudah ada tidak diatur ulang.';

  @override
  String get unavailableImage =>
      'Pratinjau gambar tidak tersedia. Anda tetap dapat membuka berkas aslinya.';

  @override
  String get largeAttachmentTitle => 'Lampiran besar';

  @override
  String largeAttachmentWarning(String size) {
    return 'Berkas ini berukuran $size MB. Lampiran besar memperlambat pencadangan dan membutuhkan lebih banyak ruang penyimpanan.';
  }

  @override
  String get continueAction => 'Lanjutkan';

  @override
  String get recoverPhoto => 'Gunakan foto yang dipulihkan';

  @override
  String get recoveredPhotoHelp =>
      'Sebuah foto dipulihkan setelah kamera memulai ulang aplikasi. Tambahkan ke garansi agar tidak hilang.';

  @override
  String get dismiss => 'Abaikan';

  @override
  String get busy => 'Operasi sedang berlangsung. Harap tunggu.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Diurutkan berdasarkan tanggal berakhir terdekat';

  @override
  String get requiredFields =>
      'Nama, kategori, tanggal pembelian, dan masa garansi wajib diisi.';

  @override
  String get chooseDate => 'Pilih tanggal pembelian';

  @override
  String get selected => 'Dipilih';

  @override
  String get notSet => 'Belum diatur';

  @override
  String get reportTitle => 'Laporan garansi';

  @override
  String get pdfReferences =>
      'Struk dan dokumen garansi berformat PDF dicantumkan menurut nama berkas. Bagikan berkas aslinya secara terpisah bila diperlukan.';

  @override
  String get documentFooter =>
      'Dibuat secara lokal oleh Kepli. Laporan ini bukan cadangan yang dapat dipulihkan.';

  @override
  String get notificationTitle => 'Garansi segera berakhir';

  @override
  String notificationBody(String name, String date) {
    return '$name: garansi berakhir pada $date.';
  }

  @override
  String get contacts => 'Kontak penjualan dan servis';

  @override
  String get addContact => 'Tambah kontak';

  @override
  String get editContact => 'Sunting kontak';

  @override
  String get removeContact => 'Hapus kontak';

  @override
  String get salesContact => 'Penjualan';

  @override
  String get serviceContact => 'Servis';

  @override
  String get contactName => 'Narahubung';

  @override
  String get organization => 'Perusahaan atau organisasi';

  @override
  String get phone => 'Telepon';

  @override
  String get email => 'Alamat email';

  @override
  String get contactNotes => 'Catatan kontak';

  @override
  String get noContacts => 'Belum ada kontak yang ditambahkan';

  @override
  String get businessCard => 'Kartu nama';

  @override
  String get scanBusinessCard => 'Pindai kartu nama';

  @override
  String get addBusinessCard => 'Tambah kartu nama';

  @override
  String get businessCardHelp =>
      'Foto atau impor kartu lalu lampirkan ke kontak ini. Masukkan rincian orang tersebut di bawah; Kepli tidak menggunakan pengenalan karakter optis berbasis awan.';

  @override
  String get businessCardNeedsContact =>
      'Simpan nama kontak sebelum melampirkan kartu nama.';

  @override
  String get scanDocument => 'Pindai dokumen';

  @override
  String get scanHelp =>
      'Foto halaman atau pilih gambar, lalu pangkas, putar, dan simpan sebagai satu PDF. Pemrosesan tetap dilakukan di perangkat ini; teks tidak diekstrak secara otomatis.';

  @override
  String get addPage => 'Tambah halaman';

  @override
  String get removePage => 'Hapus halaman';

  @override
  String get rotatePage => 'Putar halaman';

  @override
  String pageNumber(int number) {
    return 'Halaman $number';
  }

  @override
  String get cropTop => 'Pangkas dari atas';

  @override
  String get cropBottom => 'Pangkas dari bawah';

  @override
  String get cropLeft => 'Pangkas dari kiri';

  @override
  String get cropRight => 'Pangkas dari kanan';

  @override
  String get enhanceDocument => 'Tingkatkan kontras dokumen';

  @override
  String get saveScan => 'Simpan hasil pindai sebagai PDF';

  @override
  String get scanName => 'Nama dokumen';

  @override
  String get noPages => 'Tambahkan setidaknya satu halaman.';

  @override
  String get desktopScanHelp =>
      'Pilih gambar yang disimpan oleh pemindai atau kamera Anda. Kontrol langsung atas perangkat keras pemindai tidak diperlukan.';

  @override
  String get attachmentType => 'Jenis lampiran';

  @override
  String get previousPage => 'Halaman sebelumnya';

  @override
  String get nextPage => 'Halaman berikutnya';

  @override
  String get processingDocument => 'Memproses dokumen di perangkat ini';

  @override
  String get readOnlyDetails => 'Rincian garansi';

  @override
  String get selectWarranty => 'Pilih garansi untuk melihat rinciannya.';
}
