// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => '你的保修，你的收据，由你掌握。';

  @override
  String get warranties => '保修';

  @override
  String get backups => '备份';

  @override
  String get settings => '设置';

  @override
  String get addWarranty => '添加保修';

  @override
  String get editWarranty => '编辑保修';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get close => '关闭';

  @override
  String get edit => '编辑';

  @override
  String get searchHint => '搜索名称、商店或类别';

  @override
  String get all => '全部';

  @override
  String get active => '有效';

  @override
  String get expiringSoon => '即将到期';

  @override
  String get expired => '已到期';

  @override
  String get claimed => '已申请保修';

  @override
  String get noWarranties => '暂无保修';

  @override
  String get getStarted => '添加购买记录，将收据、保修凭证和联系人保存在一起。';

  @override
  String get noMatches => '没有匹配的保修';

  @override
  String get clearFilters => '清除筛选条件';

  @override
  String get purchaseDate => '购买日期';

  @override
  String get expiryDate => '到期日期';

  @override
  String get warrantyLength => '保修期限';

  @override
  String get months => '月';

  @override
  String get years => '年';

  @override
  String get name => '名称';

  @override
  String get nameHint => '例如：厨房冰箱';

  @override
  String get category => '类别';

  @override
  String get vendor => '商店或卖家';

  @override
  String get price => '价格（选填）';

  @override
  String get currency => '货币代码';

  @override
  String get notes => '备注';

  @override
  String get productPhoto => '产品照片';

  @override
  String get receipt => '收据';

  @override
  String get warrantyPaper => '保修凭证';

  @override
  String get attachments => '附件';

  @override
  String get addFiles => '添加文件';

  @override
  String get takePhoto => '拍照';

  @override
  String get choosePhoto => '选择照片';

  @override
  String get removeAttachment => '移除附件';

  @override
  String get openAttachment => '打开附件';

  @override
  String get markClaimed => '标记为已申请保修';

  @override
  String get markActive => '清除已申请保修状态';

  @override
  String get exportPdf => '导出保修 PDF';

  @override
  String get deleteWarranty => '删除保修？';

  @override
  String deleteWarrantyWarning(String name) {
    return '要从此设备删除 $name 及其所有附件吗？此操作无法撤销。';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '剩余 $count 天',
      one: '剩余 1 天',
      zero: '今天到期',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 项保修',
      one: '1 项保修',
      zero: '无保修',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => '此项为必填项。';

  @override
  String get invalidDuration => '请输入 1 至 1,200 个月。';

  @override
  String get invalidPrice => '请输入最多有两位小数的金额。';

  @override
  String get invalidCurrency => '请输入三个字母的货币代码，例如 USD。';

  @override
  String get invalidEmail => '请输入有效的电子邮箱地址。';

  @override
  String get discardChanges => '放弃未保存的更改？';

  @override
  String get discard => '放弃';

  @override
  String get keepEditing => '继续编辑';

  @override
  String get restoreBackup => '恢复备份';

  @override
  String get exportBackup => '导出备份';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get backupExplanation =>
      '一个 ZIP 文件包含你的保修、联系人、偏好设置和原始附件。将其转移到另一台设备后即可在该设备上恢复。这是手动转移，不是自动同步。';

  @override
  String get backupPrivacy => '备份未加密，请妥善保管。Kepli 不提供云服务；系统分享面板中选择的目标位置由你掌控。';

  @override
  String get chooseBackup => '选择备份文件';

  @override
  String get backupPreview => '查看备份';

  @override
  String backupSummary(int items, int files) {
    return '$items 项保修和 $files 个附件';
  }

  @override
  String exportedOn(String date, String platform) {
    return '于 $date 在 $platform 上导出';
  }

  @override
  String get merge => '合并';

  @override
  String get mergeHelp => '添加新的保修，并保留匹配保修的较新版本。保留当前偏好设置。';

  @override
  String get replaceAll => '全部替换';

  @override
  String get replaceHelp => '用备份替换此设备上的保修和偏好设置。';

  @override
  String replaceConfirmation(int count) {
    return '要永久替换此设备上的全部 $count 项保修吗？如果希望保留，请先导出备份。';
  }

  @override
  String get confirmReplace => '替换所有保修';

  @override
  String get conflicts => '匹配的保修';

  @override
  String get keepLocal => '保留此设备上的版本';

  @override
  String get useBackup => '使用备份中的较新版本';

  @override
  String get newerWinsHelp =>
      '通常保留更新时间较晚的版本。时间戳相同则保留此设备上的版本。若想改为保留本地版本，请在下方选择相应保修。';

  @override
  String get restore => '恢复';

  @override
  String get notifications => '提醒';

  @override
  String get enableReminders => '启用到期提醒';

  @override
  String get reminderDays => '到期前天数';

  @override
  String get reminderDaysHelp => '用逗号分隔数值，例如 30, 7, 1。用 0 表示到期当天。';

  @override
  String get reminderHour => '提醒时刻（0–23 时）';

  @override
  String get reminderLimit => '操作系统的队列只能容纳最近的提醒。请定期打开 Kepli 以补充队列。';

  @override
  String get notificationPrivacy =>
      '提醒在本地安排。权限、电池设置和操作系统可能会延迟或阻止提醒。即将到期列表始终可用。';

  @override
  String get permissionRequired => '需要通知权限。';

  @override
  String get requestPermission => '请求权限';

  @override
  String get remindersOff => '提醒已关闭。';

  @override
  String get remindersUnavailable => '系统提醒不可用。请查看即将到期列表。';

  @override
  String remindersScheduled(int count) {
    return '已安排 $count 条提醒。';
  }

  @override
  String get linuxReminderHelp => '在 Linux 上，仅当 Kepli 处于打开状态且通知服务可用时，提醒才会生效。';

  @override
  String get accessibility => '无障碍';

  @override
  String get highContrast => '提高对比度';

  @override
  String get reduceMotion => '减少动态效果';

  @override
  String get accessibilityHelp =>
      'Kepli 也遵循系统的文字大小、屏幕阅读器、对比度和减少动态效果设置。所有操作都可以在不使用手势的情况下完成。';

  @override
  String get language => '语言';

  @override
  String get languageHelp => '选择界面语言。默认为英语。已保存的记录文本不会被翻译。';

  @override
  String get categories => '类别';

  @override
  String get addCategory => '添加类别';

  @override
  String get renameCategory => '重命名类别';

  @override
  String get deleteCategory => '删除类别';

  @override
  String get categoryInUse => '有保修正在使用此类别。请先更改该保修的类别。';

  @override
  String get newCategory => '类别名称';

  @override
  String get categoryExists => '该类别已存在。';

  @override
  String get categoryElectronics => '电子产品';

  @override
  String get categoryAppliances => '家用电器';

  @override
  String get categoryTools => '工具';

  @override
  String get categoryOther => '其他';

  @override
  String get exportReports => '报告';

  @override
  String get about => '关于 Kepli';

  @override
  String get privacyTitle => '本地存储。隐私保护。由你掌控。';

  @override
  String get privacyBody =>
      '无需账户或订阅，没有使用情况分析，也没有 Kepli 云服务。除非你导出或分享，否则记录会保留在此应用的存储空间中。请定期导出备份：卸载应用或丢失设备可能导致数据丢失。';

  @override
  String get appVersion => '版本';

  @override
  String get operationFailed => '无法完成操作。';

  @override
  String get technicalDetails => '技术详情';

  @override
  String get saved => '保修已保存在此设备上。';

  @override
  String get deleted => '保修及其附件已删除。';

  @override
  String get restored => '备份已恢复。所有引用的附件均已验证。';

  @override
  String get settingsSaved => '设置已保存。';

  @override
  String get exportReady => '导出已就绪。';

  @override
  String get exportCancelled => '导出已取消。';

  @override
  String fileSavedTo(String path) {
    return '文件已保存至 $path';
  }

  @override
  String get shareOpened => '在分享面板中选择文件的保存位置或发送目标。';

  @override
  String get loading => '正在加载';

  @override
  String get retry => '重试';

  @override
  String get startupError => 'Kepli 无法打开本地数据。现有文件未被重置。';

  @override
  String get unavailableImage => '无法预览图片，但仍可打开原始文件。';

  @override
  String get largeAttachmentTitle => '大附件';

  @override
  String largeAttachmentWarning(String size) {
    return '此文件大小为 $size MB。大附件会减慢备份速度，并占用更多存储空间。';
  }

  @override
  String get continueAction => '继续';

  @override
  String get recoverPhoto => '使用恢复的照片';

  @override
  String get recoveredPhotoHelp => '相机导致应用重启后恢复了一张照片。请将其添加到保修中，以免丢失。';

  @override
  String get dismiss => '忽略';

  @override
  String get busy => '正在执行操作，请稍候。';

  @override
  String get menu => '菜单';

  @override
  String get sortHint => '按最早到期排序';

  @override
  String get requiredFields => '名称、类别、购买日期和保修期限为必填项。';

  @override
  String get chooseDate => '选择购买日期';

  @override
  String get selected => '已选中';

  @override
  String get notSet => '未设置';

  @override
  String get reportTitle => '保修报告';

  @override
  String get pdfReferences => 'PDF 收据和保修凭证按文件名列出。需要时请单独分享原始文件。';

  @override
  String get documentFooter => '由 Kepli 在本地生成。此报告不是可恢复的备份。';

  @override
  String get notificationTitle => '保修即将到期';

  @override
  String notificationBody(String name, String date) {
    return '$name：保修将于 $date 到期。';
  }

  @override
  String get contacts => '销售和售后服务联系人';

  @override
  String get addContact => '添加联系人';

  @override
  String get editContact => '编辑联系人';

  @override
  String get removeContact => '移除联系人';

  @override
  String get salesContact => '销售';

  @override
  String get serviceContact => '售后服务';

  @override
  String get contactName => '联系人姓名';

  @override
  String get organization => '公司或组织';

  @override
  String get phone => '电话';

  @override
  String get email => '电子邮箱';

  @override
  String get contactNotes => '联系人备注';

  @override
  String get noContacts => '尚未添加联系人';

  @override
  String get businessCard => '名片';

  @override
  String get scanBusinessCard => '扫描名片';

  @override
  String get addBusinessCard => '添加名片';

  @override
  String get businessCardHelp =>
      '拍摄或导入名片，并将其附加到此联系人。在下方输入联系人详情；Kepli 不使用云端文字识别。';

  @override
  String get businessCardNeedsContact => '请先保存联系人姓名，再添加名片。';

  @override
  String get scanDocument => '扫描文档';

  @override
  String get scanHelp => '拍摄页面或选择图片，然后裁剪、旋转并保存为一个 PDF。所有处理均在此设备上完成；不会自动提取文字。';

  @override
  String get addPage => '添加页面';

  @override
  String get removePage => '移除页面';

  @override
  String get rotatePage => '旋转页面';

  @override
  String pageNumber(int number) {
    return '第 $number 页';
  }

  @override
  String get cropTop => '从顶部裁剪';

  @override
  String get cropBottom => '从底部裁剪';

  @override
  String get cropLeft => '从左侧裁剪';

  @override
  String get cropRight => '从右侧裁剪';

  @override
  String get enhanceDocument => '增强文档对比度';

  @override
  String get saveScan => '将扫描件保存为 PDF';

  @override
  String get scanName => '文档名称';

  @override
  String get noPages => '请至少添加一页。';

  @override
  String get desktopScanHelp => '选择扫描仪或相机保存的图片。无需直接控制扫描仪硬件。';

  @override
  String get attachmentType => '附件类型';

  @override
  String get previousPage => '上一页';

  @override
  String get nextPage => '下一页';

  @override
  String get processingDocument => '正在此设备上处理文档';

  @override
  String get readOnlyDetails => '保修详情';

  @override
  String get selectWarranty => '选择一项保修以查看详情。';
}
