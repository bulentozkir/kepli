// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'การรับประกันของคุณ ใบเสร็จของคุณ อยู่ในมือคุณ';

  @override
  String get warranties => 'การรับประกัน';

  @override
  String get backups => 'ข้อมูลสำรอง';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get addWarranty => 'เพิ่มการรับประกัน';

  @override
  String get editWarranty => 'แก้ไขการรับประกัน';

  @override
  String get save => 'บันทึก';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get delete => 'ลบ';

  @override
  String get close => 'ปิด';

  @override
  String get edit => 'แก้ไข';

  @override
  String get searchHint => 'ค้นหาชื่อ ร้านค้า หรือหมวดหมู่';

  @override
  String get all => 'ทั้งหมด';

  @override
  String get active => 'ยังอยู่ในประกัน';

  @override
  String get expiringSoon => 'ใกล้หมดอายุ';

  @override
  String get expired => 'หมดอายุแล้ว';

  @override
  String get claimed => 'เคลมแล้ว';

  @override
  String get status => 'สถานะ';

  @override
  String get noWarranties => 'ยังไม่มีการรับประกัน';

  @override
  String get getStarted =>
      'เพิ่มรายการซื้อและเก็บใบเสร็จ เอกสารรับประกัน และผู้ติดต่อไว้ด้วยกัน';

  @override
  String get noMatches => 'ไม่พบการรับประกันที่ตรงกัน';

  @override
  String get clearFilters => 'ล้างตัวกรอง';

  @override
  String get purchaseDate => 'วันที่ซื้อ';

  @override
  String get expiryDate => 'วันหมดอายุ';

  @override
  String get warrantyLength => 'ระยะเวลารับประกัน';

  @override
  String get months => 'เดือน';

  @override
  String get years => 'ปี';

  @override
  String get customDuration => 'กำหนดระยะเวลาเอง';

  @override
  String get name => 'ชื่อ';

  @override
  String get nameHint => 'ตัวอย่างเช่น ตู้เย็นในห้องครัว';

  @override
  String get category => 'หมวดหมู่';

  @override
  String get vendor => 'ร้านค้าหรือผู้ขาย';

  @override
  String get price => 'ราคา (ไม่บังคับ)';

  @override
  String get currency => 'รหัสสกุลเงิน';

  @override
  String get notes => 'บันทึกย่อ';

  @override
  String get productPhoto => 'รูปสินค้า';

  @override
  String get receipt => 'ใบเสร็จ';

  @override
  String get warrantyPaper => 'เอกสารรับประกัน';

  @override
  String get attachments => 'ไฟล์แนบ';

  @override
  String get addFiles => 'เพิ่มไฟล์';

  @override
  String get takePhoto => 'ถ่ายรูป';

  @override
  String get choosePhoto => 'เลือกรูปภาพ';

  @override
  String get removeAttachment => 'นำไฟล์แนบออก';

  @override
  String get openAttachment => 'เปิดไฟล์แนบ';

  @override
  String get markClaimed => 'ทำเครื่องหมายว่าเคลมแล้ว';

  @override
  String get markActive => 'ล้างสถานะเคลมแล้ว';

  @override
  String get exportPdf => 'ส่งออกการรับประกันเป็น PDF';

  @override
  String get deleteWarranty => 'ลบการรับประกันหรือไม่?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'ลบ $name และไฟล์แนบทั้งหมดออกจากอุปกรณ์นี้หรือไม่? การดำเนินการนี้ไม่สามารถย้อนกลับได้';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'เหลือ $count วัน',
      one: 'เหลือ 1 วัน',
      zero: 'หมดอายุวันนี้',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'การรับประกัน $count รายการ',
      one: 'การรับประกัน 1 รายการ',
      zero: 'ไม่มีการรับประกัน',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'จำเป็นต้องกรอกช่องนี้';

  @override
  String get invalidDuration => 'กรอกระยะเวลา 1 ถึง 1,200 เดือน';

  @override
  String get invalidPrice => 'กรอกจำนวนเงินที่มีทศนิยมไม่เกินสองตำแหน่ง';

  @override
  String get invalidCurrency => 'กรอกรหัสสกุลเงินสามตัวอักษร เช่น USD';

  @override
  String get invalidEmail => 'กรอกที่อยู่อีเมลที่ถูกต้อง';

  @override
  String get discardChanges => 'ทิ้งการเปลี่ยนแปลงที่ยังไม่ได้บันทึกหรือไม่?';

  @override
  String get discard => 'ทิ้งการเปลี่ยนแปลง';

  @override
  String get keepEditing => 'แก้ไขต่อ';

  @override
  String get restoreBackup => 'กู้คืนข้อมูลสำรอง';

  @override
  String get exportBackup => 'ส่งออกข้อมูลสำรอง';

  @override
  String get exportCsv => 'ส่งออก CSV';

  @override
  String get backupExplanation =>
      'ไฟล์ ZIP ไฟล์เดียวมีการรับประกัน ผู้ติดต่อ ค่ากำหนด และไฟล์แนบต้นฉบับของคุณ ย้ายไฟล์ไปยังอุปกรณ์อื่นแล้วกู้คืนที่นั่น นี่เป็นการโอนด้วยตนเอง ไม่ใช่การซิงค์อัตโนมัติ';

  @override
  String get backupPrivacy =>
      'ข้อมูลสำรองไม่ได้เข้ารหัส โปรดเก็บไว้ในที่ปลอดภัย Kepli ไม่มีบริการคลาวด์ คุณเป็นผู้ควบคุมปลายทางที่เลือกในแผงแชร์ของระบบ';

  @override
  String get chooseBackup => 'เลือกไฟล์ข้อมูลสำรอง';

  @override
  String get backupPreview => 'ตรวจสอบข้อมูลสำรอง';

  @override
  String get newWarranties => 'การรับประกันใหม่';

  @override
  String backupSummary(int items, int files) {
    return 'การรับประกัน $items รายการ และไฟล์แนบ $files ไฟล์';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'ส่งออกเมื่อ $date บน $platform';
  }

  @override
  String get merge => 'รวมข้อมูล';

  @override
  String get mergeHelp =>
      'เพิ่มการรับประกันใหม่และเก็บเวอร์ชันที่ใหม่กว่าสำหรับรายการที่ตรงกัน โดยคงค่ากำหนดปัจจุบันไว้';

  @override
  String get replaceAll => 'แทนที่ทั้งหมด';

  @override
  String get replaceHelp =>
      'แทนที่การรับประกันและค่ากำหนดของอุปกรณ์นี้ด้วยข้อมูลสำรอง';

  @override
  String replaceConfirmation(int count) {
    return 'แทนที่การรับประกันทั้ง $count รายการบนอุปกรณ์นี้อย่างถาวรหรือไม่? ส่งออกข้อมูลสำรองก่อนหากต้องการเก็บข้อมูลเดิมไว้';
  }

  @override
  String get confirmReplace => 'แทนที่การรับประกันทั้งหมด';

  @override
  String get conflicts => 'การรับประกันที่ตรงกัน';

  @override
  String get keepLocal => 'เก็บเวอร์ชันของอุปกรณ์นี้';

  @override
  String get useBackup => 'ใช้เวอร์ชันที่ใหม่กว่าในข้อมูลสำรอง';

  @override
  String get newerWinsHelp =>
      'โดยปกติจะใช้ข้อมูลที่อัปเดตล่าสุด หากเวลาตรงกันจะเก็บเวอร์ชันของอุปกรณ์นี้ เลือกการรับประกันด้านล่างหากต้องการเก็บเวอร์ชันในอุปกรณ์แทน';

  @override
  String get restore => 'กู้คืน';

  @override
  String get notifications => 'การเตือน';

  @override
  String get enableReminders => 'เปิดการเตือนก่อนหมดอายุ';

  @override
  String get reminderDays => 'จำนวนวันก่อนหมดอายุ';

  @override
  String get reminderDaysHelp =>
      'คั่นค่าด้วยจุลภาค เช่น 30, 7, 1 ใช้ 0 สำหรับวันหมดอายุ';

  @override
  String get invalidReminderDays =>
      'กรอกค่าที่ไม่ซ้ำกัน 1 ถึง 12 ค่า โดยแต่ละค่าอยู่ระหว่าง 0 ถึง 3,650 วัน';

  @override
  String get reminderHour => 'ชั่วโมงที่ให้เตือน (0–23)';

  @override
  String get invalidReminderHour => 'กรอกชั่วโมงระหว่าง 0 ถึง 23';

  @override
  String get reminderLimit =>
      'คิวของระบบปฏิบัติการรองรับเฉพาะการเตือนที่ใกล้ถึงที่สุด เปิด Kepli เป็นประจำเพื่อเพิ่มการเตือนถัดไปในคิว';

  @override
  String get notificationPrivacy =>
      'การเตือนจะตั้งเวลาไว้ในอุปกรณ์ สิทธิ์ การตั้งค่าแบตเตอรี่ และระบบปฏิบัติการอาจทำให้การเตือนล่าช้าหรือไม่ทำงาน คุณดูรายการใกล้หมดอายุได้เสมอ';

  @override
  String get permissionRequired => 'ต้องได้รับสิทธิ์การแจ้งเตือน';

  @override
  String get requestPermission => 'ขอสิทธิ์';

  @override
  String get remindersOff => 'ปิดการเตือนอยู่';

  @override
  String get remindersUnavailable =>
      'ไม่สามารถใช้การเตือนของระบบได้ โปรดใช้รายการใกล้หมดอายุ';

  @override
  String remindersScheduled(int count) {
    return 'ตั้งเวลาการเตือนแล้ว $count รายการ';
  }

  @override
  String get linuxReminderHelp =>
      'บน Linux การเตือนจะทำงานเฉพาะเมื่อเปิด Kepli และมีบริการแจ้งเตือนพร้อมใช้งาน';

  @override
  String get accessibility => 'การช่วยการเข้าถึง';

  @override
  String get highContrast => 'เพิ่มความเปรียบต่าง';

  @override
  String get reduceMotion => 'ลดการเคลื่อนไหว';

  @override
  String get accessibilityHelp =>
      'Kepli ยังทำตามการตั้งค่าขนาดข้อความ โปรแกรมอ่านหน้าจอ ความเปรียบต่าง และการลดการเคลื่อนไหวของระบบด้วย ทุกการทำงานใช้งานได้โดยไม่ต้องใช้ท่าทางสัมผัส';

  @override
  String get language => 'ภาษา';

  @override
  String get languageHelp =>
      'เลือกภาษาของส่วนติดต่อ ค่าเริ่มต้นคือภาษาอังกฤษ ข้อความในรายการที่บันทึกไว้จะไม่ถูกแปล';

  @override
  String get categories => 'หมวดหมู่';

  @override
  String get addCategory => 'เพิ่มหมวดหมู่';

  @override
  String get renameCategory => 'เปลี่ยนชื่อหมวดหมู่';

  @override
  String get deleteCategory => 'ลบหมวดหมู่';

  @override
  String get categoryInUse =>
      'มีการรับประกันที่ใช้หมวดหมู่นี้อยู่ โปรดเปลี่ยนหมวดหมู่ของรายการนั้นก่อน';

  @override
  String get newCategory => 'ชื่อหมวดหมู่';

  @override
  String get categoryExists => 'มีหมวดหมู่นี้อยู่แล้ว';

  @override
  String get categoryElectronics => 'อุปกรณ์อิเล็กทรอนิกส์';

  @override
  String get categoryAppliances => 'เครื่องใช้ในบ้าน';

  @override
  String get categoryTools => 'เครื่องมือ';

  @override
  String get categoryOther => 'อื่น ๆ';

  @override
  String get exportReports => 'รายงาน';

  @override
  String get about => 'เกี่ยวกับ Kepli';

  @override
  String get privacyTitle => 'ในอุปกรณ์ เป็นส่วนตัว เป็นของคุณ';

  @override
  String get privacyBody =>
      'ไม่มีบัญชี การสมัครสมาชิก การวิเคราะห์การใช้งาน หรือคลาวด์ของ Kepli ข้อมูลของคุณจะอยู่ในพื้นที่จัดเก็บของแอปนี้จนกว่าคุณจะส่งออกหรือแชร์ โปรดส่งออกข้อมูลสำรองเป็นประจำ การถอนการติดตั้งแอปหรือทำอุปกรณ์สูญหายอาจทำให้ข้อมูลของคุณหายไป';

  @override
  String get appVersion => 'เวอร์ชัน';

  @override
  String get operationFailed => 'ไม่สามารถดำเนินการให้เสร็จสมบูรณ์ได้';

  @override
  String get technicalDetails => 'รายละเอียดทางเทคนิค';

  @override
  String get saved => 'บันทึกการรับประกันบนอุปกรณ์นี้แล้ว';

  @override
  String get deleted => 'ลบการรับประกันและไฟล์แนบแล้ว';

  @override
  String get restored =>
      'กู้คืนข้อมูลสำรองแล้ว และตรวจสอบไฟล์แนบที่อ้างอิงทั้งหมดแล้ว';

  @override
  String get settingsSaved => 'บันทึกการตั้งค่าแล้ว';

  @override
  String get exportReady => 'พร้อมส่งออก';

  @override
  String get exportCancelled => 'ยกเลิกการส่งออกแล้ว';

  @override
  String fileSavedTo(String path) {
    return 'บันทึกไฟล์ไว้ที่ $path';
  }

  @override
  String get shareOpened => 'เลือกตำแหน่งที่จะบันทึกหรือส่งไฟล์ในแผงแชร์';

  @override
  String get loading => 'กำลังโหลด';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get startupError =>
      'Kepli ไม่สามารถเปิดข้อมูลในอุปกรณ์ของคุณได้ ไฟล์ที่มีอยู่ยังไม่ได้ถูกรีเซ็ต';

  @override
  String get unavailableImage =>
      'ไม่สามารถแสดงตัวอย่างรูปภาพได้ คุณยังเปิดไฟล์ต้นฉบับได้';

  @override
  String get largeAttachmentTitle => 'ไฟล์แนบขนาดใหญ่';

  @override
  String largeAttachmentWarning(String size) {
    return 'ไฟล์นี้มีขนาด $size MB ไฟล์แนบขนาดใหญ่ทำให้การสำรองข้อมูลช้าลงและใช้พื้นที่จัดเก็บมากขึ้น';
  }

  @override
  String get continueAction => 'ดำเนินการต่อ';

  @override
  String get recoverPhoto => 'ใช้รูปภาพที่กู้คืน';

  @override
  String get recoveredPhotoHelp =>
      'กู้คืนรูปภาพได้หลังจากกล้องทำให้แอปเริ่มใหม่ เพิ่มรูปภาพนี้ลงในการรับประกันเพื่อไม่ให้สูญหาย';

  @override
  String get dismiss => 'ปิดข้อความ';

  @override
  String get busy => 'กำลังดำเนินการ โปรดรอสักครู่';

  @override
  String get menu => 'เมนู';

  @override
  String get sortHint => 'เรียงตามวันหมดอายุที่ใกล้ที่สุด';

  @override
  String get requiredFields =>
      'ต้องระบุชื่อ หมวดหมู่ วันที่ซื้อ และระยะเวลารับประกัน';

  @override
  String get chooseDate => 'เลือกวันที่ซื้อ';

  @override
  String get selected => 'เลือกแล้ว';

  @override
  String get notSet => 'ยังไม่ได้ตั้งค่า';

  @override
  String get reportTitle => 'รายงานการรับประกัน';

  @override
  String get pdfReferences =>
      'ใบเสร็จและเอกสารรับประกันที่เป็น PDF จะแสดงตามชื่อไฟล์ โปรดแชร์ไฟล์ต้นฉบับแยกต่างหากเมื่อต้องการ';

  @override
  String get documentFooter =>
      'สร้างในอุปกรณ์โดย Kepli รายงานนี้ไม่ใช่ข้อมูลสำรองที่นำมากู้คืนได้';

  @override
  String get notificationTitle => 'การรับประกันใกล้หมดอายุ';

  @override
  String notificationBody(String name, String date) {
    return '$name: การรับประกันหมดอายุวันที่ $date';
  }

  @override
  String get contacts => 'ผู้ติดต่อฝ่ายขายและบริการ';

  @override
  String get addContact => 'เพิ่มผู้ติดต่อ';

  @override
  String get editContact => 'แก้ไขผู้ติดต่อ';

  @override
  String get removeContact => 'นำผู้ติดต่อออก';

  @override
  String get salesContact => 'ฝ่ายขาย';

  @override
  String get serviceContact => 'ฝ่ายบริการ';

  @override
  String get contactName => 'บุคคลที่ติดต่อ';

  @override
  String get organization => 'บริษัทหรือองค์กร';

  @override
  String get phone => 'โทรศัพท์';

  @override
  String get email => 'อีเมล';

  @override
  String get contactNotes => 'บันทึกย่อผู้ติดต่อ';

  @override
  String get noContacts => 'ยังไม่ได้เพิ่มผู้ติดต่อ';

  @override
  String get businessCard => 'นามบัตร';

  @override
  String get scanBusinessCard => 'สแกนนามบัตร';

  @override
  String get addBusinessCard => 'เพิ่มนามบัตร';

  @override
  String get businessCardHelp =>
      'ถ่ายรูปหรือนำเข้านามบัตรแล้วแนบกับผู้ติดต่อนี้ กรอกรายละเอียดของบุคคลด้านล่าง Kepli ไม่ใช้การรู้จำตัวอักษรบนคลาวด์';

  @override
  String get businessCardNeedsContact => 'บันทึกชื่อผู้ติดต่อก่อนแนบนามบัตร';

  @override
  String get scanDocument => 'สแกนเอกสาร';

  @override
  String get scanHelp =>
      'ถ่ายรูปหน้ากระดาษหรือเลือกรูปภาพ จากนั้นครอบตัด หมุน และบันทึกรวมเป็น PDF เดียว การประมวลผลทำในอุปกรณ์นี้ และไม่มีการดึงข้อความโดยอัตโนมัติ';

  @override
  String get addPage => 'เพิ่มหน้า';

  @override
  String get removePage => 'นำหน้าออก';

  @override
  String get rotatePage => 'หมุนหน้า';

  @override
  String pageNumber(int number) {
    return 'หน้า $number';
  }

  @override
  String get cropTop => 'ครอบตัดจากด้านบน';

  @override
  String get cropBottom => 'ครอบตัดจากด้านล่าง';

  @override
  String get cropLeft => 'ครอบตัดจากด้านซ้าย';

  @override
  String get cropRight => 'ครอบตัดจากด้านขวา';

  @override
  String get enhanceDocument => 'เพิ่มความเปรียบต่างของเอกสาร';

  @override
  String get saveScan => 'บันทึกผลสแกนเป็น PDF';

  @override
  String get scanName => 'ชื่อเอกสาร';

  @override
  String get noPages => 'เพิ่มอย่างน้อยหนึ่งหน้า';

  @override
  String get desktopScanHelp =>
      'เลือกรูปภาพที่บันทึกจากสแกนเนอร์หรือกล้อง ไม่จำเป็นต้องควบคุมฮาร์ดแวร์สแกนเนอร์โดยตรง';

  @override
  String get attachmentType => 'ประเภทไฟล์แนบ';

  @override
  String get previousPage => 'หน้าก่อนหน้า';

  @override
  String get nextPage => 'หน้าถัดไป';

  @override
  String get processingDocument => 'กำลังประมวลผลเอกสารบนอุปกรณ์นี้';

  @override
  String get readOnlyDetails => 'รายละเอียดการรับประกัน';

  @override
  String get selectWarranty => 'เลือกการรับประกันเพื่อดูรายละเอียด';
}
