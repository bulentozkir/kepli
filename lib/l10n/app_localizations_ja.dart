// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'あなたの保証。あなたの領収書。あなたの手元に。';

  @override
  String get warranties => '保証';

  @override
  String get backups => 'バックアップ';

  @override
  String get settings => '設定';

  @override
  String get addWarranty => '保証を追加';

  @override
  String get editWarranty => '保証を編集';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get close => '閉じる';

  @override
  String get edit => '編集';

  @override
  String get searchHint => '名前、店舗、カテゴリで検索';

  @override
  String get all => 'すべて';

  @override
  String get active => '有効';

  @override
  String get expiringSoon => 'まもなく期限切れ';

  @override
  String get expired => '期限切れ';

  @override
  String get claimed => '保証申請済み';

  @override
  String get noWarranties => '保証はまだありません';

  @override
  String get getStarted => '購入品を追加して、領収書、保証書、連絡先をまとめて保管しましょう。';

  @override
  String get noMatches => '一致する保証はありません';

  @override
  String get clearFilters => '絞り込みを解除';

  @override
  String get purchaseDate => '購入日';

  @override
  String get expiryDate => '保証終了日';

  @override
  String get warrantyLength => '保証期間';

  @override
  String get months => 'か月';

  @override
  String get years => '年';

  @override
  String get name => '名前';

  @override
  String get nameHint => '例：キッチンの冷蔵庫';

  @override
  String get category => 'カテゴリ';

  @override
  String get vendor => '店舗または販売元';

  @override
  String get price => '価格（任意）';

  @override
  String get currency => '通貨コード';

  @override
  String get notes => 'メモ';

  @override
  String get productPhoto => '製品の写真';

  @override
  String get receipt => '領収書';

  @override
  String get warrantyPaper => '保証書';

  @override
  String get attachments => '添付ファイル';

  @override
  String get addFiles => 'ファイルを追加';

  @override
  String get takePhoto => '写真を撮影';

  @override
  String get choosePhoto => '写真を選択';

  @override
  String get removeAttachment => '添付ファイルを削除';

  @override
  String get openAttachment => '添付ファイルを開く';

  @override
  String get markClaimed => '保証申請済みにする';

  @override
  String get markActive => '保証申請済みの状態を解除';

  @override
  String get exportPdf => '保証をPDFに書き出す';

  @override
  String get deleteWarranty => '保証を削除しますか？';

  @override
  String deleteWarrantyWarning(String name) {
    return '$nameとすべての添付ファイルをこの端末から削除しますか？この操作は取り消せません。';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '残り$count日',
      one: '残り1日',
      zero: '本日期限切れ',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '保証$count件',
      one: '保証1件',
      zero: '保証なし',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'この項目は必須です。';

  @override
  String get invalidDuration => '1〜1,200か月の範囲で入力してください。';

  @override
  String get invalidPrice => '小数点以下2桁までの金額を入力してください。';

  @override
  String get invalidCurrency => 'USDなど、3文字の通貨コードを入力してください。';

  @override
  String get invalidEmail => '有効なメールアドレスを入力してください。';

  @override
  String get discardChanges => '保存していない変更を破棄しますか？';

  @override
  String get discard => '破棄';

  @override
  String get keepEditing => '編集を続ける';

  @override
  String get restoreBackup => 'バックアップを復元';

  @override
  String get exportBackup => 'バックアップを書き出す';

  @override
  String get exportCsv => 'CSVを書き出す';

  @override
  String get backupExplanation =>
      '保証、連絡先、設定、元の添付ファイルを1つのZIPファイルにまとめます。別の端末に移して、そこで復元できます。これは手動での移行であり、自動同期ではありません。';

  @override
  String get backupPrivacy =>
      'バックアップは暗号化されません。安全な場所に保管してください。Kepliにクラウドサービスはありません。システムの共有シートで選ぶ共有先はご自身で管理してください。';

  @override
  String get chooseBackup => 'バックアップファイルを選択';

  @override
  String get backupPreview => 'バックアップを確認';

  @override
  String backupSummary(int items, int files) {
    return '保証$items件、添付ファイル$files件';
  }

  @override
  String exportedOn(String date, String platform) {
    return '$dateに$platformで書き出し';
  }

  @override
  String get merge => '統合';

  @override
  String get mergeHelp => '新しい保証を追加し、一致する保証は更新日時が新しいものを残します。現在の設定は維持されます。';

  @override
  String get replaceAll => 'すべて置き換える';

  @override
  String get replaceHelp => 'この端末の保証と設定をバックアップの内容に置き換えます。';

  @override
  String replaceConfirmation(int count) {
    return 'この端末の保証$count件をすべて完全に置き換えますか？現在のデータを残す場合は、先にバックアップを書き出してください。';
  }

  @override
  String get confirmReplace => 'すべての保証を置き換える';

  @override
  String get conflicts => '一致する保証';

  @override
  String get keepLocal => 'この端末のデータを残す';

  @override
  String get useBackup => 'バックアップの新しいデータを使う';

  @override
  String get newerWinsHelp =>
      '通常は更新日時が新しいデータを優先します。同じ日時の場合はこの端末のデータを残します。代わりにこの端末のデータを残したい保証を下から選択してください。';

  @override
  String get restore => '復元';

  @override
  String get notifications => 'リマインダー';

  @override
  String get enableReminders => '保証期限のリマインダーを有効にする';

  @override
  String get reminderDays => '期限の何日前に通知するか';

  @override
  String get reminderDaysHelp => '30, 7, 1のようにカンマで区切ってください。期限当日は0を指定します。';

  @override
  String get reminderHour => '通知する時刻（0〜23時）';

  @override
  String get reminderLimit =>
      'OSの通知待ちリストには、直近のリマインダーだけが登録されます。定期的にKepliを開いて、次のリマインダーを補充してください。';

  @override
  String get notificationPrivacy =>
      'リマインダーは端末内で設定されます。権限、バッテリー設定、OSによって通知が遅れたり届かなかったりすることがあります。まもなく期限切れになる保証の一覧はいつでも確認できます。';

  @override
  String get permissionRequired => '通知の許可が必要です。';

  @override
  String get requestPermission => '許可をリクエスト';

  @override
  String get remindersOff => 'リマインダーはオフです。';

  @override
  String get remindersUnavailable =>
      'システムのリマインダーは利用できません。まもなく期限切れになる保証の一覧をご利用ください。';

  @override
  String remindersScheduled(int count) {
    return 'リマインダーを$count件設定しました。';
  }

  @override
  String get linuxReminderHelp =>
      'Linuxでは、Kepliが開いていて通知サービスが利用可能な場合にのみリマインダーが動作します。';

  @override
  String get accessibility => 'アクセシビリティ';

  @override
  String get highContrast => 'コントラストを上げる';

  @override
  String get reduceMotion => '視覚効果を減らす';

  @override
  String get accessibilityHelp =>
      'Kepliは、文字サイズ、スクリーンリーダー、コントラスト、視覚効果の軽減についてもシステム設定に従います。すべての操作はジェスチャーなしで行えます。';

  @override
  String get language => '言語';

  @override
  String get languageHelp => '画面の表示言語を選択してください。初期設定は英語です。保存済みの項目の文章は翻訳されません。';

  @override
  String get categories => 'カテゴリ';

  @override
  String get addCategory => 'カテゴリを追加';

  @override
  String get renameCategory => 'カテゴリ名を変更';

  @override
  String get deleteCategory => 'カテゴリを削除';

  @override
  String get categoryInUse => 'このカテゴリは保証で使用されています。先にその保証のカテゴリを変更してください。';

  @override
  String get newCategory => 'カテゴリ名';

  @override
  String get categoryExists => 'そのカテゴリはすでに存在します。';

  @override
  String get categoryElectronics => '電子機器';

  @override
  String get categoryAppliances => '家電';

  @override
  String get categoryTools => '工具';

  @override
  String get categoryOther => 'その他';

  @override
  String get exportReports => 'レポート';

  @override
  String get about => 'Kepliについて';

  @override
  String get privacyTitle => '端末内で。非公開で。あなたのもの。';

  @override
  String get privacyBody =>
      'アカウント、定期購入、利用状況の分析、Kepliのクラウドはありません。書き出しや共有をするまでは、記録はこのアプリの保存領域内に留まります。定期的にバックアップを書き出してください。アプリのアンインストールや端末の紛失でデータが失われる可能性があります。';

  @override
  String get appVersion => 'バージョン';

  @override
  String get operationFailed => '操作を完了できませんでした。';

  @override
  String get technicalDetails => '技術的な詳細';

  @override
  String get saved => '保証をこの端末に保存しました。';

  @override
  String get deleted => '保証と添付ファイルを削除しました。';

  @override
  String get restored => 'バックアップを復元しました。参照されている添付ファイルをすべて検証しました。';

  @override
  String get settingsSaved => '設定を保存しました。';

  @override
  String get exportReady => '書き出しの準備ができました。';

  @override
  String get exportCancelled => '書き出しをキャンセルしました。';

  @override
  String fileSavedTo(String path) {
    return 'ファイルを$pathに保存しました';
  }

  @override
  String get shareOpened => '共有シートでファイルの保存先または送信先を選択してください。';

  @override
  String get loading => '読み込み中';

  @override
  String get retry => '再試行';

  @override
  String get startupError => 'Kepliは端末内のデータを開けませんでした。既存のファイルは初期化されていません。';

  @override
  String get unavailableImage => '画像のプレビューは利用できません。元のファイルは開けます。';

  @override
  String get largeAttachmentTitle => '大きな添付ファイル';

  @override
  String largeAttachmentWarning(String size) {
    return 'このファイルは$size MBです。大きな添付ファイルはバックアップに時間がかかり、保存容量も多く使用します。';
  }

  @override
  String get continueAction => '続ける';

  @override
  String get recoverPhoto => '復元された写真を使う';

  @override
  String get recoveredPhotoHelp =>
      'カメラによってアプリが再起動した後、写真が復元されました。失われないように保証に追加してください。';

  @override
  String get dismiss => '閉じる';

  @override
  String get busy => '処理中です。お待ちください。';

  @override
  String get menu => 'メニュー';

  @override
  String get sortHint => '保証終了日が近い順に表示';

  @override
  String get requiredFields => '名前、カテゴリ、購入日、保証期間は必須です。';

  @override
  String get chooseDate => '購入日を選択';

  @override
  String get selected => '選択済み';

  @override
  String get notSet => '未設定';

  @override
  String get reportTitle => '保証レポート';

  @override
  String get pdfReferences =>
      'PDF形式の領収書と保証書はファイル名で一覧表示されます。必要に応じて元のファイルを別途共有してください。';

  @override
  String get documentFooter => 'Kepliが端末内で作成しました。このレポートは復元可能なバックアップではありません。';

  @override
  String get notificationTitle => '保証期限が近づいています';

  @override
  String notificationBody(String name, String date) {
    return '$name：保証は$dateに終了します。';
  }

  @override
  String get contacts => '販売・修理窓口の連絡先';

  @override
  String get addContact => '連絡先を追加';

  @override
  String get editContact => '連絡先を編集';

  @override
  String get removeContact => '連絡先を削除';

  @override
  String get salesContact => '販売';

  @override
  String get serviceContact => '修理・サポート';

  @override
  String get contactName => '担当者';

  @override
  String get organization => '会社または組織';

  @override
  String get phone => '電話';

  @override
  String get email => 'メール';

  @override
  String get contactNotes => '連絡先のメモ';

  @override
  String get noContacts => '連絡先はまだありません';

  @override
  String get businessCard => '名刺';

  @override
  String get scanBusinessCard => '名刺をスキャン';

  @override
  String get addBusinessCard => '名刺を追加';

  @override
  String get businessCardHelp =>
      '名刺を撮影または読み込んで、この連絡先に添付してください。担当者の情報は下に入力してください。Kepliはクラウドでの文字認識を使用しません。';

  @override
  String get businessCardNeedsContact => '名刺を添付する前に、連絡先の名前を保存してください。';

  @override
  String get scanDocument => '書類をスキャン';

  @override
  String get scanHelp =>
      'ページを撮影または画像を選択し、切り取りや回転を行って1つのPDFとして保存します。処理はこの端末内で行われ、文字は自動抽出されません。';

  @override
  String get addPage => 'ページを追加';

  @override
  String get removePage => 'ページを削除';

  @override
  String get rotatePage => 'ページを回転';

  @override
  String pageNumber(int number) {
    return '$numberページ';
  }

  @override
  String get cropTop => '上から切り取る';

  @override
  String get cropBottom => '下から切り取る';

  @override
  String get cropLeft => '左から切り取る';

  @override
  String get cropRight => '右から切り取る';

  @override
  String get enhanceDocument => '書類のコントラストを強調';

  @override
  String get saveScan => 'スキャンをPDFとして保存';

  @override
  String get scanName => '書類名';

  @override
  String get noPages => '少なくとも1ページ追加してください。';

  @override
  String get desktopScanHelp =>
      'スキャナーやカメラで保存した画像を選択してください。スキャナー本体を直接操作する機能は必要ありません。';

  @override
  String get attachmentType => '添付ファイルの種類';

  @override
  String get previousPage => '前のページ';

  @override
  String get nextPage => '次のページ';

  @override
  String get processingDocument => 'この端末で書類を処理中';

  @override
  String get readOnlyDetails => '保証の詳細';

  @override
  String get selectWarranty => '保証を選択すると詳細を表示します。';
}
