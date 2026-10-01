// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Ваши гарантии. Ваши чеки. Всё ваше.';

  @override
  String get warranties => 'Гарантии';

  @override
  String get backups => 'Резервные копии';

  @override
  String get settings => 'Настройки';

  @override
  String get addWarranty => 'Добавить гарантию';

  @override
  String get editWarranty => 'Изменить гарантию';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get close => 'Закрыть';

  @override
  String get edit => 'Изменить';

  @override
  String get searchHint => 'Поиск по названию, магазину или категории';

  @override
  String get all => 'Все';

  @override
  String get active => 'Действующие';

  @override
  String get expiringSoon => 'Скоро истекают';

  @override
  String get expired => 'Истёкшие';

  @override
  String get claimed => 'Заявка подана';

  @override
  String get status => 'Статус';

  @override
  String get noWarranties => 'Гарантий пока нет';

  @override
  String get getStarted =>
      'Добавьте покупку и храните её чек, гарантийные документы и контакты вместе.';

  @override
  String get noMatches => 'Подходящих гарантий нет';

  @override
  String get clearFilters => 'Сбросить фильтры';

  @override
  String get purchaseDate => 'Дата покупки';

  @override
  String get expiryDate => 'Дата окончания';

  @override
  String get warrantyLength => 'Срок гарантии';

  @override
  String get months => 'Месяцы';

  @override
  String get years => 'Годы';

  @override
  String get customDuration => 'Произвольный срок';

  @override
  String get name => 'Название';

  @override
  String get nameHint => 'Например, холодильник на кухне';

  @override
  String get category => 'Категория';

  @override
  String get vendor => 'Магазин или продавец';

  @override
  String get price => 'Цена (необязательно)';

  @override
  String get currency => 'Код валюты';

  @override
  String get notes => 'Заметки';

  @override
  String get productPhoto => 'Фото товара';

  @override
  String get receipt => 'Чек';

  @override
  String get warrantyPaper => 'Гарантийный документ';

  @override
  String get attachments => 'Вложения';

  @override
  String get addFiles => 'Добавить файлы';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get choosePhoto => 'Выбрать фотографии';

  @override
  String get removeAttachment => 'Удалить вложение';

  @override
  String get openAttachment => 'Открыть вложение';

  @override
  String get markClaimed => 'Отметить подачу заявки';

  @override
  String get markActive => 'Снять отметку о подаче заявки';

  @override
  String get exportPdf => 'Экспортировать гарантию в PDF';

  @override
  String get deleteWarranty => 'Удалить гарантию?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Удалить $name и все связанные вложения с этого устройства? Это действие нельзя отменить.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Осталось $count дня',
      many: 'Осталось $count дней',
      few: 'Осталось $count дня',
      one: 'Остался $count день',
      zero: 'Истекает сегодня',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count гарантии',
      many: '$count гарантий',
      few: '$count гарантии',
      one: '$count гарантия',
      zero: 'Нет гарантий',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Это поле обязательно.';

  @override
  String get invalidDuration => 'Введите срок от 1 до 1 200 месяцев.';

  @override
  String get invalidPrice =>
      'Введите сумму с не более чем двумя знаками после запятой.';

  @override
  String get invalidCurrency =>
      'Введите трёхбуквенный код валюты, например USD.';

  @override
  String get invalidEmail => 'Введите действительный адрес электронной почты.';

  @override
  String get discardChanges => 'Отменить несохранённые изменения?';

  @override
  String get discard => 'Отменить изменения';

  @override
  String get keepEditing => 'Продолжить редактирование';

  @override
  String get restoreBackup => 'Восстановить из резервной копии';

  @override
  String get exportBackup => 'Экспортировать резервную копию';

  @override
  String get exportCsv => 'Экспортировать в CSV';

  @override
  String get backupExplanation =>
      'Один ZIP-файл содержит ваши гарантии, контакты, настройки и исходные вложения. Перенесите его на другое устройство и восстановите там. Это ручной перенос, а не автоматическая синхронизация.';

  @override
  String get backupPrivacy =>
      'Резервные копии не зашифрованы. Храните их в безопасном месте. У Kepli нет облачного сервиса; вы сами выбираете, куда отправлять файлы через системное меню обмена.';

  @override
  String get chooseBackup => 'Выбрать файл резервной копии';

  @override
  String get backupPreview => 'Проверить резервную копию';

  @override
  String get newWarranties => 'Новые гарантии';

  @override
  String backupSummary(int items, int files) {
    return 'Гарантии: $items; вложения: $files';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Экспортировано $date на платформе $platform';
  }

  @override
  String get merge => 'Объединить';

  @override
  String get mergeHelp =>
      'Добавляет новые гарантии и сохраняет более новую версию совпадающих гарантий. Текущие настройки сохраняются.';

  @override
  String get replaceAll => 'Заменить всё';

  @override
  String get replaceHelp =>
      'Заменяет гарантии и настройки этого устройства данными из резервной копии.';

  @override
  String replaceConfirmation(int count) {
    return 'Навсегда заменить все гарантии на этом устройстве ($count)? Сначала экспортируйте резервную копию, если хотите их сохранить.';
  }

  @override
  String get confirmReplace => 'Заменить все гарантии';

  @override
  String get conflicts => 'Совпадающие гарантии';

  @override
  String get keepLocal => 'Сохранить версию с этого устройства';

  @override
  String get useBackup => 'Использовать более новую версию из резервной копии';

  @override
  String get newerWinsHelp =>
      'Обычно выбирается более позднее обновление. Если время обновления совпадает, сохраняется версия с этого устройства. Выберите гарантии ниже, чтобы вместо этого оставить их локальную версию.';

  @override
  String get restore => 'Восстановить';

  @override
  String get notifications => 'Напоминания';

  @override
  String get enableReminders => 'Включить напоминания об окончании гарантии';

  @override
  String get reminderDays => 'Дней до окончания';

  @override
  String get reminderDaysHelp =>
      'Разделяйте значения запятыми, например 30, 7, 1. Используйте 0 для даты окончания.';

  @override
  String get invalidReminderDays =>
      'Введите от 1 до 12 неповторяющихся значений, каждое в диапазоне от 0 до 3 650 дней.';

  @override
  String get reminderHour => 'Час напоминания (0–23)';

  @override
  String get invalidReminderHour => 'Укажите час от 0 до 23.';

  @override
  String get reminderLimit =>
      'В очередь операционной системы помещаются только ближайшие напоминания. Регулярно открывайте Kepli, чтобы пополнять очередь.';

  @override
  String get notificationPrivacy =>
      'Напоминания планируются локально. Разрешения, настройки батареи и операционная система могут задержать или заблокировать их. Список скоро истекающих гарантий доступен всегда.';

  @override
  String get permissionRequired => 'Необходимо разрешение на уведомления.';

  @override
  String get requestPermission => 'Запросить разрешение';

  @override
  String get remindersOff => 'Напоминания отключены.';

  @override
  String get remindersUnavailable =>
      'Системные напоминания недоступны. Используйте список скоро истекающих гарантий.';

  @override
  String remindersScheduled(int count) {
    return 'Запланировано напоминаний: $count.';
  }

  @override
  String get linuxReminderHelp =>
      'В Linux напоминания работают, только пока Kepli открыт и доступна служба уведомлений.';

  @override
  String get accessibility => 'Специальные возможности';

  @override
  String get highContrast => 'Повысить контрастность';

  @override
  String get reduceMotion => 'Уменьшить анимацию';

  @override
  String get accessibilityHelp =>
      'Kepli также учитывает системные настройки размера текста, программы чтения с экрана, контрастности и уменьшения анимации. Все действия доступны без жестов.';

  @override
  String get language => 'Язык';

  @override
  String get languageHelp =>
      'Выберите язык интерфейса. По умолчанию используется английский. Текст сохранённых записей не переводится.';

  @override
  String get categories => 'Категории';

  @override
  String get addCategory => 'Добавить категорию';

  @override
  String get renameCategory => 'Переименовать категорию';

  @override
  String get deleteCategory => 'Удалить категорию';

  @override
  String get categoryInUse =>
      'Эта категория используется в гарантии. Сначала измените категорию той гарантии.';

  @override
  String get newCategory => 'Название категории';

  @override
  String get categoryExists => 'Такая категория уже существует.';

  @override
  String get categoryElectronics => 'Электроника';

  @override
  String get categoryAppliances => 'Бытовая техника';

  @override
  String get categoryTools => 'Инструменты';

  @override
  String get categoryOther => 'Другое';

  @override
  String get exportReports => 'Отчёты';

  @override
  String get about => 'О Kepli';

  @override
  String get privacyTitle => 'Локально. Конфиденциально. Ваше.';

  @override
  String get privacyBody =>
      'Без учётной записи, подписки, аналитики и облака Kepli. Ваши записи остаются в хранилище приложения, пока вы их не экспортируете или не отправите. Регулярно экспортируйте резервные копии: удаление приложения или потеря устройства могут привести к утрате данных.';

  @override
  String get appVersion => 'Версия';

  @override
  String get operationFailed => 'Не удалось завершить операцию.';

  @override
  String get technicalDetails => 'Технические сведения';

  @override
  String get saved => 'Гарантия сохранена на этом устройстве.';

  @override
  String get deleted => 'Гарантия и её вложения удалены.';

  @override
  String get restored =>
      'Резервная копия восстановлена. Все вложения, на которые есть ссылки, проверены.';

  @override
  String get settingsSaved => 'Настройки сохранены.';

  @override
  String get exportReady => 'Экспорт готов.';

  @override
  String get exportCancelled => 'Экспорт отменён.';

  @override
  String fileSavedTo(String path) {
    return 'Файл сохранён в $path';
  }

  @override
  String get shareOpened =>
      'Выберите в меню обмена, куда сохранить или отправить файл.';

  @override
  String get loading => 'Загрузка';

  @override
  String get retry => 'Повторить';

  @override
  String get startupError =>
      'Kepli не удалось открыть ваши локальные данные. Существующие файлы не были сброшены.';

  @override
  String get unavailableImage =>
      'Предпросмотр изображения недоступен. Вы по-прежнему можете открыть исходный файл.';

  @override
  String get largeAttachmentTitle => 'Большое вложение';

  @override
  String largeAttachmentWarning(String size) {
    return 'Размер этого файла — $size МБ. Большие вложения замедляют резервное копирование и занимают больше места.';
  }

  @override
  String get continueAction => 'Продолжить';

  @override
  String get recoverPhoto => 'Использовать восстановленное фото';

  @override
  String get recoveredPhotoHelp =>
      'После перезапуска приложения камерой удалось восстановить фотографию. Добавьте её к гарантии, чтобы не потерять.';

  @override
  String get dismiss => 'Закрыть';

  @override
  String get busy => 'Выполняется операция. Подождите.';

  @override
  String get menu => 'Меню';

  @override
  String get sortHint => 'Сначала гарантии с ближайшей датой окончания';

  @override
  String get requiredFields =>
      'Необходимо указать название, категорию, дату покупки и срок гарантии.';

  @override
  String get chooseDate => 'Выбрать дату покупки';

  @override
  String get selected => 'Выбрано';

  @override
  String get notSet => 'Не задано';

  @override
  String get reportTitle => 'Отчёт о гарантиях';

  @override
  String get pdfReferences =>
      'Чеки и гарантийные документы в формате PDF перечислены по именам файлов. При необходимости отправляйте исходные файлы отдельно.';

  @override
  String get documentFooter =>
      'Создано локально в Kepli. Этот отчёт не является резервной копией для восстановления.';

  @override
  String get notificationTitle => 'Гарантия скоро истекает';

  @override
  String notificationBody(String name, String date) {
    return '$name: гарантия истекает $date.';
  }

  @override
  String get contacts => 'Контакты отдела продаж и сервисной службы';

  @override
  String get addContact => 'Добавить контакт';

  @override
  String get editContact => 'Изменить контакт';

  @override
  String get removeContact => 'Удалить контакт';

  @override
  String get salesContact => 'Продажи';

  @override
  String get serviceContact => 'Сервис';

  @override
  String get contactName => 'Контактное лицо';

  @override
  String get organization => 'Компания или организация';

  @override
  String get phone => 'Телефон';

  @override
  String get email => 'Электронная почта';

  @override
  String get contactNotes => 'Заметки о контакте';

  @override
  String get noContacts => 'Контакты не добавлены';

  @override
  String get businessCard => 'Визитка';

  @override
  String get scanBusinessCard => 'Сканировать визитку';

  @override
  String get addBusinessCard => 'Добавить визитку';

  @override
  String get businessCardHelp =>
      'Сфотографируйте или импортируйте визитку и прикрепите её к этому контакту. Введите данные человека ниже; Kepli не использует облачное распознавание текста.';

  @override
  String get businessCardNeedsContact =>
      'Сохраните имя контакта, прежде чем прикрепить визитку.';

  @override
  String get scanDocument => 'Сканировать документ';

  @override
  String get scanHelp =>
      'Сфотографируйте страницы или выберите изображения, затем обрежьте, поверните и сохраните их в одном PDF-файле. Обработка выполняется на этом устройстве; текст не извлекается автоматически.';

  @override
  String get addPage => 'Добавить страницу';

  @override
  String get removePage => 'Удалить страницу';

  @override
  String get rotatePage => 'Повернуть страницу';

  @override
  String pageNumber(int number) {
    return 'Страница $number';
  }

  @override
  String get cropTop => 'Обрезать сверху';

  @override
  String get cropBottom => 'Обрезать снизу';

  @override
  String get cropLeft => 'Обрезать слева';

  @override
  String get cropRight => 'Обрезать справа';

  @override
  String get enhanceDocument => 'Повысить контрастность документа';

  @override
  String get saveScan => 'Сохранить скан в PDF';

  @override
  String get scanName => 'Название документа';

  @override
  String get noPages => 'Добавьте хотя бы одну страницу.';

  @override
  String get desktopScanHelp =>
      'Выберите изображения, сохранённые сканером или камерой. Прямое управление оборудованием сканера не требуется.';

  @override
  String get attachmentType => 'Тип вложения';

  @override
  String get previousPage => 'Предыдущая страница';

  @override
  String get nextPage => 'Следующая страница';

  @override
  String get processingDocument => 'Документ обрабатывается на этом устройстве';

  @override
  String get readOnlyDetails => 'Сведения о гарантии';

  @override
  String get selectWarranty =>
      'Выберите гарантию, чтобы просмотреть сведения о ней.';
}
