// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Bảo hành của bạn. Biên lai của bạn. Thuộc về bạn.';

  @override
  String get warranties => 'Bảo hành';

  @override
  String get backups => 'Bản sao lưu';

  @override
  String get settings => 'Cài đặt';

  @override
  String get addWarranty => 'Thêm bảo hành';

  @override
  String get editWarranty => 'Chỉnh sửa bảo hành';

  @override
  String get save => 'Lưu';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get close => 'Đóng';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get searchHint => 'Tìm theo tên, cửa hàng hoặc danh mục';

  @override
  String get all => 'Tất cả';

  @override
  String get active => 'Còn hạn';

  @override
  String get expiringSoon => 'Sắp hết hạn';

  @override
  String get expired => 'Đã hết hạn';

  @override
  String get claimed => 'Đã yêu cầu bảo hành';

  @override
  String get noWarranties => 'Chưa có bảo hành nào';

  @override
  String get getStarted =>
      'Thêm một giao dịch mua và lưu biên lai, giấy bảo hành cùng thông tin liên hệ ở một nơi.';

  @override
  String get noMatches => 'Không có bảo hành phù hợp';

  @override
  String get clearFilters => 'Xóa bộ lọc';

  @override
  String get purchaseDate => 'Ngày mua';

  @override
  String get expiryDate => 'Ngày hết hạn';

  @override
  String get warrantyLength => 'Thời hạn bảo hành';

  @override
  String get months => 'Tháng';

  @override
  String get years => 'Năm';

  @override
  String get name => 'Tên';

  @override
  String get nameHint => 'Ví dụ: tủ lạnh nhà bếp';

  @override
  String get category => 'Danh mục';

  @override
  String get vendor => 'Cửa hàng hoặc người bán';

  @override
  String get price => 'Giá (không bắt buộc)';

  @override
  String get currency => 'Mã tiền tệ';

  @override
  String get notes => 'Ghi chú';

  @override
  String get productPhoto => 'Ảnh sản phẩm';

  @override
  String get receipt => 'Biên lai';

  @override
  String get warrantyPaper => 'Giấy bảo hành';

  @override
  String get attachments => 'Tệp đính kèm';

  @override
  String get addFiles => 'Thêm tệp';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get choosePhoto => 'Chọn ảnh';

  @override
  String get removeAttachment => 'Xóa tệp đính kèm';

  @override
  String get openAttachment => 'Mở tệp đính kèm';

  @override
  String get markClaimed => 'Đánh dấu đã yêu cầu bảo hành';

  @override
  String get markActive => 'Xóa trạng thái đã yêu cầu bảo hành';

  @override
  String get exportPdf => 'Xuất bảo hành thành PDF';

  @override
  String get deleteWarranty => 'Xóa bảo hành?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Xóa $name và tất cả tệp đính kèm khỏi thiết bị này? Không thể hoàn tác thao tác này.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Còn $count ngày',
      one: 'Còn 1 ngày',
      zero: 'Hết hạn hôm nay',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bảo hành',
      one: '1 bảo hành',
      zero: 'Không có bảo hành',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Trường này là bắt buộc.';

  @override
  String get invalidDuration => 'Nhập từ 1 đến 1.200 tháng.';

  @override
  String get invalidPrice => 'Nhập số tiền có tối đa hai chữ số thập phân.';

  @override
  String get invalidCurrency =>
      'Nhập mã tiền tệ gồm ba chữ cái, chẳng hạn USD.';

  @override
  String get invalidEmail => 'Nhập địa chỉ email hợp lệ.';

  @override
  String get discardChanges => 'Bỏ các thay đổi chưa lưu?';

  @override
  String get discard => 'Bỏ thay đổi';

  @override
  String get keepEditing => 'Tiếp tục chỉnh sửa';

  @override
  String get restoreBackup => 'Khôi phục bản sao lưu';

  @override
  String get exportBackup => 'Xuất bản sao lưu';

  @override
  String get exportCsv => 'Xuất CSV';

  @override
  String get backupExplanation =>
      'Một tệp ZIP duy nhất chứa các bảo hành, thông tin liên hệ, tùy chọn và tệp đính kèm gốc của bạn. Chuyển tệp sang thiết bị khác rồi khôi phục tại đó. Đây là chuyển dữ liệu thủ công, không phải đồng bộ hóa tự động.';

  @override
  String get backupPrivacy =>
      'Bản sao lưu không được mã hóa. Hãy giữ chúng ở nơi an toàn. Kepli không có dịch vụ đám mây; bạn kiểm soát các đích đến được chọn trong bảng chia sẻ của hệ thống.';

  @override
  String get chooseBackup => 'Chọn tệp sao lưu';

  @override
  String get backupPreview => 'Xem lại bản sao lưu';

  @override
  String backupSummary(int items, int files) {
    return '$items bảo hành và $files tệp đính kèm';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Đã xuất ngày $date trên $platform';
  }

  @override
  String get merge => 'Hợp nhất';

  @override
  String get mergeHelp =>
      'Thêm các bảo hành mới và giữ phiên bản mới hơn của những bảo hành trùng khớp. Các tùy chọn hiện tại được giữ nguyên.';

  @override
  String get replaceAll => 'Thay thế tất cả';

  @override
  String get replaceHelp =>
      'Thay thế các bảo hành và tùy chọn trên thiết bị này bằng dữ liệu trong bản sao lưu.';

  @override
  String replaceConfirmation(int count) {
    return 'Thay thế vĩnh viễn toàn bộ $count bảo hành trên thiết bị này? Hãy xuất bản sao lưu trước nếu bạn muốn giữ chúng.';
  }

  @override
  String get confirmReplace => 'Thay thế tất cả bảo hành';

  @override
  String get conflicts => 'Bảo hành trùng khớp';

  @override
  String get keepLocal => 'Giữ phiên bản trên thiết bị này';

  @override
  String get useBackup => 'Dùng phiên bản mới hơn trong bản sao lưu';

  @override
  String get newerWinsHelp =>
      'Thông thường, bản cập nhật mới hơn được ưu tiên. Nếu dấu thời gian giống nhau, phiên bản trên thiết bị này được giữ lại. Chọn các bảo hành bên dưới để giữ phiên bản cục bộ thay thế.';

  @override
  String get restore => 'Khôi phục';

  @override
  String get notifications => 'Lời nhắc';

  @override
  String get enableReminders => 'Bật lời nhắc hết hạn';

  @override
  String get reminderDays => 'Số ngày trước khi hết hạn';

  @override
  String get reminderDaysHelp =>
      'Phân tách các giá trị bằng dấu phẩy, ví dụ 30, 7, 1. Dùng 0 cho ngày hết hạn.';

  @override
  String get reminderHour => 'Giờ nhắc (0-23)';

  @override
  String get reminderLimit =>
      'Hàng đợi của hệ điều hành chỉ chứa được những lời nhắc gần nhất. Hãy mở Kepli thường xuyên để bổ sung lời nhắc vào hàng đợi.';

  @override
  String get notificationPrivacy =>
      'Lời nhắc được lên lịch cục bộ. Quyền truy cập, cài đặt pin và hệ điều hành có thể trì hoãn hoặc ngăn chúng xuất hiện. Danh sách bảo hành sắp hết hạn luôn có sẵn.';

  @override
  String get permissionRequired => 'Cần cấp quyền thông báo.';

  @override
  String get requestPermission => 'Yêu cầu cấp quyền';

  @override
  String get remindersOff => 'Lời nhắc đang tắt.';

  @override
  String get remindersUnavailable =>
      'Lời nhắc hệ thống không khả dụng. Hãy dùng danh sách bảo hành sắp hết hạn.';

  @override
  String remindersScheduled(int count) {
    return 'Đã lên lịch $count lời nhắc.';
  }

  @override
  String get linuxReminderHelp =>
      'Trên Linux, lời nhắc chỉ hoạt động khi Kepli đang mở và có dịch vụ thông báo.';

  @override
  String get accessibility => 'Hỗ trợ tiếp cận';

  @override
  String get highContrast => 'Tăng độ tương phản';

  @override
  String get reduceMotion => 'Giảm chuyển động';

  @override
  String get accessibilityHelp =>
      'Kepli cũng tuân theo cài đặt hệ thống về cỡ chữ, trình đọc màn hình, độ tương phản và giảm chuyển động. Mọi thao tác đều có thể thực hiện mà không cần cử chỉ.';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get languageHelp =>
      'Chọn ngôn ngữ giao diện. Tiếng Anh là ngôn ngữ mặc định. Văn bản trong các mục đã lưu sẽ không được dịch.';

  @override
  String get categories => 'Danh mục';

  @override
  String get addCategory => 'Thêm danh mục';

  @override
  String get renameCategory => 'Đổi tên danh mục';

  @override
  String get deleteCategory => 'Xóa danh mục';

  @override
  String get categoryInUse =>
      'Một bảo hành đang sử dụng danh mục này. Hãy đổi danh mục của bảo hành đó trước.';

  @override
  String get newCategory => 'Tên danh mục';

  @override
  String get categoryExists => 'Danh mục đó đã tồn tại.';

  @override
  String get categoryElectronics => 'Điện tử';

  @override
  String get categoryAppliances => 'Đồ gia dụng';

  @override
  String get categoryTools => 'Dụng cụ';

  @override
  String get categoryOther => 'Khác';

  @override
  String get exportReports => 'Báo cáo';

  @override
  String get about => 'Giới thiệu về Kepli';

  @override
  String get privacyTitle => 'Cục bộ. Riêng tư. Của bạn.';

  @override
  String get privacyBody =>
      'Không tài khoản, không gói thuê bao, không phân tích sử dụng hay đám mây Kepli. Các bản ghi của bạn nằm trong bộ nhớ của ứng dụng này cho đến khi bạn xuất hoặc chia sẻ chúng. Hãy xuất bản sao lưu thường xuyên: gỡ cài đặt ứng dụng hoặc mất thiết bị có thể khiến bạn mất dữ liệu.';

  @override
  String get appVersion => 'Phiên bản';

  @override
  String get operationFailed => 'Không thể hoàn tất thao tác.';

  @override
  String get technicalDetails => 'Chi tiết kỹ thuật';

  @override
  String get saved => 'Đã lưu bảo hành trên thiết bị này.';

  @override
  String get deleted => 'Đã xóa bảo hành và các tệp đính kèm.';

  @override
  String get restored =>
      'Đã khôi phục bản sao lưu. Tất cả tệp đính kèm được tham chiếu đã được xác minh.';

  @override
  String get settingsSaved => 'Đã lưu cài đặt.';

  @override
  String get exportReady => 'Bản xuất đã sẵn sàng.';

  @override
  String get exportCancelled => 'Đã hủy xuất.';

  @override
  String fileSavedTo(String path) {
    return 'Đã lưu tệp vào $path';
  }

  @override
  String get shareOpened => 'Chọn nơi lưu hoặc gửi tệp trong bảng chia sẻ.';

  @override
  String get loading => 'Đang tải';

  @override
  String get retry => 'Thử lại';

  @override
  String get startupError =>
      'Kepli không thể mở dữ liệu cục bộ của bạn. Các tệp hiện có chưa bị đặt lại.';

  @override
  String get unavailableImage =>
      'Không có bản xem trước ảnh. Bạn vẫn có thể mở tệp gốc.';

  @override
  String get largeAttachmentTitle => 'Tệp đính kèm lớn';

  @override
  String largeAttachmentWarning(String size) {
    return 'Tệp này có dung lượng $size MB. Tệp đính kèm lớn làm chậm quá trình sao lưu và chiếm nhiều bộ nhớ hơn.';
  }

  @override
  String get continueAction => 'Tiếp tục';

  @override
  String get recoverPhoto => 'Dùng ảnh đã khôi phục';

  @override
  String get recoveredPhotoHelp =>
      'Một ảnh đã được khôi phục sau khi máy ảnh khởi động lại ứng dụng. Hãy thêm ảnh vào một bảo hành để tránh bị mất.';

  @override
  String get dismiss => 'Bỏ qua';

  @override
  String get busy => 'Đang thực hiện thao tác. Vui lòng chờ.';

  @override
  String get menu => 'Trình đơn';

  @override
  String get sortHint => 'Sắp xếp theo ngày hết hạn gần nhất';

  @override
  String get requiredFields =>
      'Tên, danh mục, ngày mua và thời hạn bảo hành là bắt buộc.';

  @override
  String get chooseDate => 'Chọn ngày mua';

  @override
  String get selected => 'Đã chọn';

  @override
  String get notSet => 'Chưa đặt';

  @override
  String get reportTitle => 'Báo cáo bảo hành';

  @override
  String get pdfReferences =>
      'Biên lai và giấy bảo hành dạng PDF được liệt kê theo tên tệp. Chia sẻ riêng các tệp gốc khi cần.';

  @override
  String get documentFooter =>
      'Được tạo cục bộ bởi Kepli. Báo cáo này không phải là bản sao lưu có thể khôi phục.';

  @override
  String get notificationTitle => 'Bảo hành sắp hết hạn';

  @override
  String notificationBody(String name, String date) {
    return '$name: bảo hành hết hạn vào $date.';
  }

  @override
  String get contacts => 'Liên hệ bán hàng và dịch vụ';

  @override
  String get addContact => 'Thêm liên hệ';

  @override
  String get editContact => 'Chỉnh sửa liên hệ';

  @override
  String get removeContact => 'Xóa liên hệ';

  @override
  String get salesContact => 'Bán hàng';

  @override
  String get serviceContact => 'Dịch vụ';

  @override
  String get contactName => 'Người liên hệ';

  @override
  String get organization => 'Công ty hoặc tổ chức';

  @override
  String get phone => 'Điện thoại';

  @override
  String get email => 'Địa chỉ email';

  @override
  String get contactNotes => 'Ghi chú liên hệ';

  @override
  String get noContacts => 'Chưa thêm liên hệ nào';

  @override
  String get businessCard => 'Danh thiếp';

  @override
  String get scanBusinessCard => 'Quét danh thiếp';

  @override
  String get addBusinessCard => 'Thêm danh thiếp';

  @override
  String get businessCardHelp =>
      'Chụp hoặc nhập ảnh danh thiếp rồi đính kèm vào liên hệ này. Nhập thông tin của người đó bên dưới; Kepli không dùng nhận dạng ký tự quang học trên đám mây.';

  @override
  String get businessCardNeedsContact =>
      'Lưu tên liên hệ trước khi đính kèm danh thiếp.';

  @override
  String get scanDocument => 'Quét tài liệu';

  @override
  String get scanHelp =>
      'Chụp các trang hoặc chọn ảnh, sau đó cắt, xoay và lưu thành một tệp PDF. Quá trình xử lý diễn ra trên thiết bị này; văn bản không được tự động trích xuất.';

  @override
  String get addPage => 'Thêm trang';

  @override
  String get removePage => 'Xóa trang';

  @override
  String get rotatePage => 'Xoay trang';

  @override
  String pageNumber(int number) {
    return 'Trang $number';
  }

  @override
  String get cropTop => 'Cắt từ phía trên';

  @override
  String get cropBottom => 'Cắt từ phía dưới';

  @override
  String get cropLeft => 'Cắt từ bên trái';

  @override
  String get cropRight => 'Cắt từ bên phải';

  @override
  String get enhanceDocument => 'Tăng độ tương phản tài liệu';

  @override
  String get saveScan => 'Lưu bản quét thành PDF';

  @override
  String get scanName => 'Tên tài liệu';

  @override
  String get noPages => 'Thêm ít nhất một trang.';

  @override
  String get desktopScanHelp =>
      'Chọn ảnh được lưu từ máy quét hoặc máy ảnh. Không cần điều khiển trực tiếp phần cứng máy quét.';

  @override
  String get attachmentType => 'Loại tệp đính kèm';

  @override
  String get previousPage => 'Trang trước';

  @override
  String get nextPage => 'Trang sau';

  @override
  String get processingDocument => 'Đang xử lý tài liệu trên thiết bị này';

  @override
  String get readOnlyDetails => 'Chi tiết bảo hành';

  @override
  String get selectWarranty => 'Chọn một bảo hành để xem chi tiết.';
}
