// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Ваші гарантії. Ваші чеки. Усе ваше.';

  @override
  String get warranties => 'Гарантії';

  @override
  String get backups => 'Резервні копії';

  @override
  String get settings => 'Налаштування';

  @override
  String get addWarranty => 'Додати гарантію';

  @override
  String get editWarranty => 'Редагувати гарантію';

  @override
  String get save => 'Зберегти';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get close => 'Закрити';

  @override
  String get edit => 'Редагувати';

  @override
  String get searchHint => 'Пошук за назвою, магазином або категорією';

  @override
  String get all => 'Усі';

  @override
  String get active => 'Чинні';

  @override
  String get expiringSoon => 'Скоро закінчуються';

  @override
  String get expired => 'Строк минув';

  @override
  String get claimed => 'Заявку подано';

  @override
  String get status => 'Статус';

  @override
  String get noWarranties => 'Гарантій поки немає';

  @override
  String get getStarted =>
      'Додайте покупку та зберігайте її чек, гарантійні документи й контакти разом.';

  @override
  String get noMatches => 'Відповідних гарантій немає';

  @override
  String get clearFilters => 'Скинути фільтри';

  @override
  String get purchaseDate => 'Дата покупки';

  @override
  String get expiryDate => 'Дата закінчення';

  @override
  String get warrantyLength => 'Строк гарантії';

  @override
  String get months => 'Місяці';

  @override
  String get years => 'Роки';

  @override
  String get customDuration => 'Довільний строк';

  @override
  String get name => 'Назва';

  @override
  String get nameHint => 'Наприклад, холодильник на кухні';

  @override
  String get category => 'Категорія';

  @override
  String get vendor => 'Магазин або продавець';

  @override
  String get price => 'Ціна (необов’язково)';

  @override
  String get currency => 'Код валюти';

  @override
  String get notes => 'Нотатки';

  @override
  String get productPhoto => 'Фото товару';

  @override
  String get receipt => 'Чек';

  @override
  String get warrantyPaper => 'Гарантійний документ';

  @override
  String get attachments => 'Вкладення';

  @override
  String get addFiles => 'Додати файли';

  @override
  String get takePhoto => 'Зробити фото';

  @override
  String get choosePhoto => 'Вибрати фотографії';

  @override
  String get removeAttachment => 'Видалити вкладення';

  @override
  String get openAttachment => 'Відкрити вкладення';

  @override
  String get markClaimed => 'Позначити подання заявки';

  @override
  String get markActive => 'Зняти позначку про подання заявки';

  @override
  String get exportPdf => 'Експортувати гарантію в PDF';

  @override
  String get deleteWarranty => 'Видалити гарантію?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Видалити $name та всі пов’язані вкладення з цього пристрою? Цю дію неможливо скасувати.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Залишилося $count дня',
      many: 'Залишилося $count днів',
      few: 'Залишилося $count дні',
      one: 'Залишився $count день',
      zero: 'Спливає сьогодні',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count гарантії',
      many: '$count гарантій',
      few: '$count гарантії',
      one: '$count гарантія',
      zero: 'Немає гарантій',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Це поле обов’язкове.';

  @override
  String get invalidDuration => 'Введіть від 1 до 1 200 місяців.';

  @override
  String get invalidPrice =>
      'Введіть суму щонайбільше з двома знаками після коми.';

  @override
  String get invalidCurrency =>
      'Введіть трилітерний код валюти, наприклад USD.';

  @override
  String get invalidEmail => 'Введіть дійсну адресу електронної пошти.';

  @override
  String get discardChanges => 'Відкинути незбережені зміни?';

  @override
  String get discard => 'Відкинути';

  @override
  String get keepEditing => 'Продовжити редагування';

  @override
  String get restoreBackup => 'Відновити з резервної копії';

  @override
  String get exportBackup => 'Експортувати резервну копію';

  @override
  String get exportCsv => 'Експортувати в CSV';

  @override
  String get backupExplanation =>
      'Один ZIP-файл містить ваші гарантії, контакти, налаштування та оригінальні вкладення. Перенесіть його на інший пристрій і відновіть там. Це перенесення вручну, а не автоматична синхронізація.';

  @override
  String get backupPrivacy =>
      'Резервні копії не зашифровані. Зберігайте їх у безпечному місці. Kepli не має хмарного сервісу; ви самі обираєте, куди надсилати файли через системне меню поширення.';

  @override
  String get chooseBackup => 'Вибрати файл резервної копії';

  @override
  String get backupPreview => 'Переглянути резервну копію';

  @override
  String get newWarranties => 'Нові гарантії';

  @override
  String backupSummary(int items, int files) {
    return 'Гарантії: $items; вкладення: $files';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Експортовано $date на платформі $platform';
  }

  @override
  String get merge => 'Об’єднати';

  @override
  String get mergeHelp =>
      'Додає нові гарантії та зберігає новішу версію гарантій, що збігаються. Поточні налаштування зберігаються.';

  @override
  String get replaceAll => 'Замінити все';

  @override
  String get replaceHelp =>
      'Замінює гарантії та налаштування цього пристрою даними з резервної копії.';

  @override
  String replaceConfirmation(int count) {
    return 'Назавжди замінити всі гарантії на цьому пристрої ($count)? Спочатку експортуйте резервну копію, якщо хочете їх зберегти.';
  }

  @override
  String get confirmReplace => 'Замінити всі гарантії';

  @override
  String get conflicts => 'Гарантії, що збігаються';

  @override
  String get keepLocal => 'Зберегти версію з цього пристрою';

  @override
  String get useBackup => 'Використати новішу версію з резервної копії';

  @override
  String get newerWinsHelp =>
      'Зазвичай обирається новіше оновлення. Якщо часові позначки однакові, зберігається версія з цього пристрою. Виберіть гарантії нижче, щоб натомість залишити їхню локальну версію.';

  @override
  String get restore => 'Відновити';

  @override
  String get notifications => 'Нагадування';

  @override
  String get enableReminders => 'Увімкнути нагадування про закінчення гарантії';

  @override
  String get reminderDays => 'Днів до закінчення';

  @override
  String get reminderDaysHelp =>
      'Відокремлюйте значення комами, наприклад 30, 7, 1. Використовуйте 0 для дати закінчення.';

  @override
  String get invalidReminderDays =>
      'Введіть від 1 до 12 значень без повторів, кожне в діапазоні від 0 до 3 650 днів.';

  @override
  String get reminderHour => 'Година нагадування (0–23)';

  @override
  String get invalidReminderHour => 'Введіть годину від 0 до 23.';

  @override
  String get reminderLimit =>
      'У черзі операційної системи вміщуються лише найближчі нагадування. Регулярно відкривайте Kepli, щоб поповнювати її.';

  @override
  String get notificationPrivacy =>
      'Нагадування плануються локально. Дозволи, налаштування батареї та операційна система можуть затримати або заблокувати їх. Перелік гарантій, що скоро закінчуються, доступний завжди.';

  @override
  String get permissionRequired => 'Потрібен дозвіл на сповіщення.';

  @override
  String get requestPermission => 'Запитати дозвіл';

  @override
  String get remindersOff => 'Нагадування вимкнено.';

  @override
  String get remindersUnavailable =>
      'Системні нагадування недоступні. Скористайтеся переліком гарантій, що скоро закінчуються.';

  @override
  String remindersScheduled(int count) {
    return 'Заплановано нагадувань: $count.';
  }

  @override
  String get linuxReminderHelp =>
      'У Linux нагадування працюють лише тоді, коли Kepli відкрито й доступна служба сповіщень.';

  @override
  String get accessibility => 'Спеціальні можливості';

  @override
  String get highContrast => 'Підвищити контрастність';

  @override
  String get reduceMotion => 'Зменшити рух';

  @override
  String get accessibilityHelp =>
      'Kepli також враховує системні налаштування розміру тексту, зчитувача екрана, контрастності та зменшення руху. Усі дії доступні без жестів.';

  @override
  String get language => 'Мова';

  @override
  String get languageHelp =>
      'Виберіть мову інтерфейсу. Типова мова — англійська. Текст збережених записів не перекладається.';

  @override
  String get categories => 'Категорії';

  @override
  String get addCategory => 'Додати категорію';

  @override
  String get renameCategory => 'Перейменувати категорію';

  @override
  String get deleteCategory => 'Видалити категорію';

  @override
  String get categoryInUse =>
      'Цю категорію використовує гарантія. Спочатку змініть категорію тієї гарантії.';

  @override
  String get newCategory => 'Назва категорії';

  @override
  String get categoryExists => 'Така категорія вже існує.';

  @override
  String get categoryElectronics => 'Електроніка';

  @override
  String get categoryAppliances => 'Побутова техніка';

  @override
  String get categoryTools => 'Інструменти';

  @override
  String get categoryOther => 'Інше';

  @override
  String get exportReports => 'Звіти';

  @override
  String get about => 'Про Kepli';

  @override
  String get privacyTitle => 'Локально. Приватно. Ваше.';

  @override
  String get privacyBody =>
      'Без облікового запису, підписки, аналітики чи хмари Kepli. Ваші записи залишаються в сховищі застосунку, доки ви не експортуєте їх або не поділитеся ними. Регулярно експортуйте резервні копії: видалення застосунку або втрата пристрою можуть призвести до втрати даних.';

  @override
  String get appVersion => 'Версія';

  @override
  String get operationFailed => 'Не вдалося завершити операцію.';

  @override
  String get technicalDetails => 'Технічні відомості';

  @override
  String get saved => 'Гарантію збережено на цьому пристрої.';

  @override
  String get deleted => 'Гарантію та її вкладення видалено.';

  @override
  String get restored =>
      'Резервну копію відновлено. Усі вкладення, на які є посилання, перевірено.';

  @override
  String get settingsSaved => 'Налаштування збережено.';

  @override
  String get exportReady => 'Експорт готовий.';

  @override
  String get exportCancelled => 'Експорт скасовано.';

  @override
  String fileSavedTo(String path) {
    return 'Файл збережено в $path';
  }

  @override
  String get shareOpened =>
      'У меню поширення виберіть, куди зберегти або надіслати файл.';

  @override
  String get loading => 'Завантаження';

  @override
  String get retry => 'Спробувати ще раз';

  @override
  String get startupError =>
      'Kepli не вдалося відкрити ваші локальні дані. Наявні файли не було скинуто.';

  @override
  String get unavailableImage =>
      'Попередній перегляд зображення недоступний. Ви все ще можете відкрити оригінальний файл.';

  @override
  String get largeAttachmentTitle => 'Велике вкладення';

  @override
  String largeAttachmentWarning(String size) {
    return 'Розмір цього файлу — $size МБ. Великі вкладення уповільнюють резервне копіювання та займають більше місця.';
  }

  @override
  String get continueAction => 'Продовжити';

  @override
  String get recoverPhoto => 'Використати відновлене фото';

  @override
  String get recoveredPhotoHelp =>
      'Після перезапуску застосунку камерою було відновлено фотографію. Додайте її до гарантії, щоб не втратити.';

  @override
  String get dismiss => 'Закрити';

  @override
  String get busy => 'Триває операція. Зачекайте.';

  @override
  String get menu => 'Меню';

  @override
  String get sortHint => 'Відсортовано за найближчою датою закінчення';

  @override
  String get requiredFields =>
      'Назва, категорія, дата покупки та строк гарантії обов’язкові.';

  @override
  String get chooseDate => 'Вибрати дату покупки';

  @override
  String get selected => 'Вибрано';

  @override
  String get notSet => 'Не задано';

  @override
  String get reportTitle => 'Звіт про гарантії';

  @override
  String get pdfReferences =>
      'Чеки та гарантійні документи у форматі PDF перелічено за назвами файлів. За потреби надсилайте оригінальні файли окремо.';

  @override
  String get documentFooter =>
      'Створено локально в Kepli. Цей звіт не є резервною копією для відновлення.';

  @override
  String get notificationTitle => 'Гарантія скоро закінчується';

  @override
  String notificationBody(String name, String date) {
    return '$name: гарантія закінчується $date.';
  }

  @override
  String get contacts => 'Контакти відділу продажів і сервісної служби';

  @override
  String get addContact => 'Додати контакт';

  @override
  String get editContact => 'Редагувати контакт';

  @override
  String get removeContact => 'Видалити контакт';

  @override
  String get salesContact => 'Продажі';

  @override
  String get serviceContact => 'Сервіс';

  @override
  String get contactName => 'Контактна особа';

  @override
  String get organization => 'Компанія або організація';

  @override
  String get phone => 'Телефон';

  @override
  String get email => 'Електронна пошта';

  @override
  String get contactNotes => 'Нотатки про контакт';

  @override
  String get noContacts => 'Контакти не додано';

  @override
  String get businessCard => 'Візитівка';

  @override
  String get scanBusinessCard => 'Сканувати візитівку';

  @override
  String get addBusinessCard => 'Додати візитівку';

  @override
  String get businessCardHelp =>
      'Сфотографуйте або імпортуйте візитівку та прикріпіть її до цього контакту. Введіть дані особи нижче; Kepli не використовує хмарне розпізнавання тексту.';

  @override
  String get businessCardNeedsContact =>
      'Збережіть ім’я контакту, перш ніж прикріпити візитівку.';

  @override
  String get scanDocument => 'Сканувати документ';

  @override
  String get scanHelp =>
      'Сфотографуйте сторінки або виберіть зображення, а потім обріжте, поверніть і збережіть їх як один PDF-файл. Обробка відбувається на цьому пристрої; текст не видобувається автоматично.';

  @override
  String get addPage => 'Додати сторінку';

  @override
  String get removePage => 'Видалити сторінку';

  @override
  String get rotatePage => 'Повернути сторінку';

  @override
  String pageNumber(int number) {
    return 'Сторінка $number';
  }

  @override
  String get cropTop => 'Обрізати зверху';

  @override
  String get cropBottom => 'Обрізати знизу';

  @override
  String get cropLeft => 'Обрізати зліва';

  @override
  String get cropRight => 'Обрізати справа';

  @override
  String get enhanceDocument => 'Підвищити контрастність документа';

  @override
  String get saveScan => 'Зберегти скан як PDF';

  @override
  String get scanName => 'Назва документа';

  @override
  String get noPages => 'Додайте принаймні одну сторінку.';

  @override
  String get desktopScanHelp =>
      'Виберіть зображення, збережені сканером або камерою. Безпосередньо керувати обладнанням сканера не потрібно.';

  @override
  String get attachmentType => 'Тип вкладення';

  @override
  String get previousPage => 'Попередня сторінка';

  @override
  String get nextPage => 'Наступна сторінка';

  @override
  String get processingDocument => 'Обробка документа на цьому пристрої';

  @override
  String get readOnlyDetails => 'Відомості про гарантію';

  @override
  String get selectWarranty =>
      'Виберіть гарантію, щоб переглянути відомості про неї.';
}
