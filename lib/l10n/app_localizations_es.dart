// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Tus garantías. Tus recibos. Todo tuyo.';

  @override
  String get warranties => 'Garantías';

  @override
  String get backups => 'Copias de seguridad';

  @override
  String get settings => 'Ajustes';

  @override
  String get addWarranty => 'Añadir garantía';

  @override
  String get editWarranty => 'Editar garantía';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get close => 'Cerrar';

  @override
  String get edit => 'Editar';

  @override
  String get searchHint => 'Buscar por nombre, tienda o categoría';

  @override
  String get all => 'Todas';

  @override
  String get active => 'Vigentes';

  @override
  String get expiringSoon => 'Próximas a vencer';

  @override
  String get expired => 'Vencidas';

  @override
  String get claimed => 'Reclamadas';

  @override
  String get status => 'Estado';

  @override
  String get noWarranties => 'Aún no hay garantías';

  @override
  String get getStarted =>
      'Añade una compra y guarda juntos su recibo, los documentos de garantía y los contactos.';

  @override
  String get noMatches => 'No hay garantías que coincidan';

  @override
  String get clearFilters => 'Borrar filtros';

  @override
  String get purchaseDate => 'Fecha de compra';

  @override
  String get expiryDate => 'Fecha de vencimiento';

  @override
  String get warrantyLength => 'Duración de la garantía';

  @override
  String get months => 'Meses';

  @override
  String get years => 'Años';

  @override
  String get customDuration => 'Duración personalizada';

  @override
  String get name => 'Nombre';

  @override
  String get nameHint => 'Por ejemplo, frigorífico de la cocina';

  @override
  String get category => 'Categoría';

  @override
  String get vendor => 'Tienda o vendedor';

  @override
  String get price => 'Precio (opcional)';

  @override
  String get currency => 'Código de moneda';

  @override
  String get notes => 'Notas';

  @override
  String get productPhoto => 'Foto del producto';

  @override
  String get receipt => 'Recibo';

  @override
  String get warrantyPaper => 'Documento de garantía';

  @override
  String get attachments => 'Archivos adjuntos';

  @override
  String get addFiles => 'Añadir archivos';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get choosePhoto => 'Elegir fotos';

  @override
  String get removeAttachment => 'Quitar archivo adjunto';

  @override
  String get openAttachment => 'Abrir archivo adjunto';

  @override
  String get markClaimed => 'Marcar como reclamada';

  @override
  String get markActive => 'Quitar el estado de reclamada';

  @override
  String get exportPdf => 'Exportar garantía en PDF';

  @override
  String get deleteWarranty => '¿Eliminar garantía?';

  @override
  String deleteWarrantyWarning(String name) {
    return '¿Eliminar $name y todos sus archivos adjuntos de este dispositivo? Esta acción no se puede deshacer.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Quedan $count días',
      one: 'Queda 1 día',
      zero: 'Vence hoy',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garantías',
      one: '1 garantía',
      zero: 'No hay garantías',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Este campo es obligatorio.';

  @override
  String get invalidDuration => 'Introduce entre 1 y 1200 meses.';

  @override
  String get invalidPrice =>
      'Introduce un importe con un máximo de dos decimales.';

  @override
  String get invalidCurrency =>
      'Introduce un código de moneda de tres letras, como USD.';

  @override
  String get invalidEmail =>
      'Introduce una dirección de correo electrónico válida.';

  @override
  String get discardChanges => '¿Descartar los cambios sin guardar?';

  @override
  String get discard => 'Descartar';

  @override
  String get keepEditing => 'Seguir editando';

  @override
  String get restoreBackup => 'Restaurar copia de seguridad';

  @override
  String get exportBackup => 'Exportar copia de seguridad';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get backupExplanation =>
      'Un único archivo ZIP contiene tus garantías, contactos, preferencias y archivos adjuntos originales. Trasládalo a otro dispositivo y restáuralo allí. Es una transferencia manual, no una sincronización automática.';

  @override
  String get backupPrivacy =>
      'Las copias de seguridad no están cifradas. Guárdalas en un lugar seguro. Kepli no tiene servicio en la nube; tú controlas los destinos que eliges en el panel de compartir del sistema.';

  @override
  String get chooseBackup => 'Elegir archivo de copia de seguridad';

  @override
  String get backupPreview => 'Revisar copia de seguridad';

  @override
  String get newWarranties => 'Garantías nuevas';

  @override
  String backupSummary(int items, int files) {
    return '$items garantías y $files archivos adjuntos';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Exportado el $date en $platform';
  }

  @override
  String get merge => 'Combinar';

  @override
  String get mergeHelp =>
      'Añade garantías nuevas y conserva la versión más reciente de las garantías coincidentes. Se mantienen las preferencias actuales.';

  @override
  String get replaceAll => 'Reemplazar todo';

  @override
  String get replaceHelp =>
      'Reemplaza las garantías y las preferencias de este dispositivo por las de la copia de seguridad.';

  @override
  String replaceConfirmation(int count) {
    return '¿Reemplazar permanentemente las $count garantías de este dispositivo? Exporta primero una copia de seguridad si quieres conservarlas.';
  }

  @override
  String get confirmReplace => 'Reemplazar todas las garantías';

  @override
  String get conflicts => 'Garantías coincidentes';

  @override
  String get keepLocal => 'Conservar la versión de este dispositivo';

  @override
  String get useBackup =>
      'Usar la versión más reciente de la copia de seguridad';

  @override
  String get newerWinsHelp =>
      'Normalmente se conserva la actualización más reciente. Si las marcas de tiempo son iguales, se mantiene la versión de este dispositivo. Selecciona las garantías de abajo para conservar su versión local en su lugar.';

  @override
  String get restore => 'Restaurar';

  @override
  String get notifications => 'Recordatorios';

  @override
  String get enableReminders => 'Activar recordatorios de vencimiento';

  @override
  String get reminderDays => 'Días antes del vencimiento';

  @override
  String get reminderDaysHelp =>
      'Separa los valores con comas, por ejemplo 30, 7, 1. Usa 0 para la fecha de vencimiento.';

  @override
  String get invalidReminderDays =>
      'Introduce de 1 a 12 valores distintos, cada uno entre 0 y 3650 días.';

  @override
  String get reminderHour => 'Hora del recordatorio (0-23)';

  @override
  String get invalidReminderHour => 'Introduce una hora entre 0 y 23.';

  @override
  String get reminderLimit =>
      'En la cola del sistema operativo solo caben los recordatorios más próximos. Abre Kepli con regularidad para reponerlos.';

  @override
  String get notificationPrivacy =>
      'Los recordatorios se programan localmente. Los permisos, los ajustes de batería y el sistema operativo pueden retrasarlos o impedirlos. La lista de garantías próximas a vencer siempre está disponible.';

  @override
  String get permissionRequired =>
      'Se requiere permiso para enviar notificaciones.';

  @override
  String get requestPermission => 'Solicitar permiso';

  @override
  String get remindersOff => 'Los recordatorios están desactivados.';

  @override
  String get remindersUnavailable =>
      'Los recordatorios del sistema no están disponibles. Usa la lista de garantías próximas a vencer.';

  @override
  String remindersScheduled(int count) {
    return '$count recordatorios programados.';
  }

  @override
  String get linuxReminderHelp =>
      'En Linux, los recordatorios solo funcionan mientras Kepli está abierto y hay un servicio de notificaciones disponible.';

  @override
  String get accessibility => 'Accesibilidad';

  @override
  String get highContrast => 'Aumentar contraste';

  @override
  String get reduceMotion => 'Reducir movimiento';

  @override
  String get accessibilityHelp =>
      'Kepli también respeta los ajustes del sistema de tamaño del texto, lector de pantalla, contraste y reducción de movimiento. Todas las acciones están disponibles sin gestos.';

  @override
  String get language => 'Idioma';

  @override
  String get languageHelp =>
      'Elige el idioma de la interfaz. El inglés es el predeterminado. El texto de tus elementos guardados no se traduce.';

  @override
  String get categories => 'Categorías';

  @override
  String get addCategory => 'Añadir categoría';

  @override
  String get renameCategory => 'Cambiar nombre de categoría';

  @override
  String get deleteCategory => 'Eliminar categoría';

  @override
  String get categoryInUse =>
      'Una garantía utiliza esta categoría. Cambia primero la categoría de esa garantía.';

  @override
  String get newCategory => 'Nombre de la categoría';

  @override
  String get categoryExists => 'Esa categoría ya existe.';

  @override
  String get categoryElectronics => 'Electrónica';

  @override
  String get categoryAppliances => 'Electrodomésticos';

  @override
  String get categoryTools => 'Herramientas';

  @override
  String get categoryOther => 'Otros';

  @override
  String get exportReports => 'Informes';

  @override
  String get about => 'Acerca de Kepli';

  @override
  String get privacyTitle => 'Local. Privado. Tuyo.';

  @override
  String get privacyBody =>
      'Sin cuenta, suscripción, análisis de uso ni nube de Kepli. Tus registros permanecen en el almacenamiento de esta aplicación hasta que los exportas o compartes. Exporta copias de seguridad con regularidad: desinstalar la aplicación o perder un dispositivo puede borrar tus datos.';

  @override
  String get appVersion => 'Versión';

  @override
  String get operationFailed => 'No se pudo completar la operación.';

  @override
  String get technicalDetails => 'Detalles técnicos';

  @override
  String get saved => 'Garantía guardada en este dispositivo.';

  @override
  String get deleted => 'Garantía y sus archivos adjuntos eliminados.';

  @override
  String get restored =>
      'Copia de seguridad restaurada. Se han verificado todos los archivos adjuntos referenciados.';

  @override
  String get settingsSaved => 'Ajustes guardados.';

  @override
  String get exportReady => 'Exportación lista.';

  @override
  String get exportCancelled => 'Exportación cancelada.';

  @override
  String fileSavedTo(String path) {
    return 'Archivo guardado en $path';
  }

  @override
  String get shareOpened =>
      'Elige dónde guardar o enviar el archivo en el panel de compartir.';

  @override
  String get loading => 'Cargando';

  @override
  String get retry => 'Reintentar';

  @override
  String get startupError =>
      'Kepli no pudo abrir tus datos locales. Tus archivos existentes no se han restablecido.';

  @override
  String get unavailableImage =>
      'La vista previa de la imagen no está disponible. Puedes abrir el archivo original.';

  @override
  String get largeAttachmentTitle => 'Archivo adjunto grande';

  @override
  String largeAttachmentWarning(String size) {
    return 'Este archivo ocupa $size MB. Los archivos adjuntos grandes ralentizan las copias de seguridad y ocupan más espacio.';
  }

  @override
  String get continueAction => 'Continuar';

  @override
  String get recoverPhoto => 'Usar foto recuperada';

  @override
  String get recoveredPhotoHelp =>
      'Se ha recuperado una foto después de que la cámara reiniciara la aplicación. Añádela a una garantía para no perderla.';

  @override
  String get dismiss => 'Descartar';

  @override
  String get busy => 'Operación en curso. Espera.';

  @override
  String get menu => 'Menú';

  @override
  String get sortHint => 'Ordenadas por fecha de vencimiento más próxima';

  @override
  String get requiredFields =>
      'El nombre, la categoría, la fecha de compra y la duración de la garantía son obligatorios.';

  @override
  String get chooseDate => 'Elegir fecha de compra';

  @override
  String get selected => 'Seleccionado';

  @override
  String get notSet => 'Sin establecer';

  @override
  String get reportTitle => 'Informe de garantías';

  @override
  String get pdfReferences =>
      'Los recibos y documentos de garantía en PDF se enumeran por nombre de archivo. Comparte sus archivos originales por separado cuando sea necesario.';

  @override
  String get documentFooter =>
      'Generado localmente por Kepli. Este informe no es una copia de seguridad restaurable.';

  @override
  String get notificationTitle => 'Garantía próxima a vencer';

  @override
  String notificationBody(String name, String date) {
    return '$name: la garantía vence el $date.';
  }

  @override
  String get contacts => 'Contactos de ventas y servicio técnico';

  @override
  String get addContact => 'Añadir contacto';

  @override
  String get editContact => 'Editar contacto';

  @override
  String get removeContact => 'Quitar contacto';

  @override
  String get salesContact => 'Ventas';

  @override
  String get serviceContact => 'Servicio técnico';

  @override
  String get contactName => 'Persona de contacto';

  @override
  String get organization => 'Empresa u organización';

  @override
  String get phone => 'Teléfono';

  @override
  String get email => 'Correo electrónico';

  @override
  String get contactNotes => 'Notas del contacto';

  @override
  String get noContacts => 'No se han añadido contactos';

  @override
  String get businessCard => 'Tarjeta de visita';

  @override
  String get scanBusinessCard => 'Escanear tarjeta de visita';

  @override
  String get addBusinessCard => 'Añadir tarjeta de visita';

  @override
  String get businessCardHelp =>
      'Fotografía o importa la tarjeta y adjúntala a este contacto. Introduce los datos de la persona abajo; Kepli no utiliza reconocimiento óptico de caracteres en la nube.';

  @override
  String get businessCardNeedsContact =>
      'Guarda el nombre del contacto antes de adjuntar una tarjeta de visita.';

  @override
  String get scanDocument => 'Escanear documento';

  @override
  String get scanHelp =>
      'Fotografía páginas o selecciona imágenes; después recórtalas, gíralas y guárdalas en un único PDF. El procesamiento se realiza en este dispositivo; el texto no se extrae automáticamente.';

  @override
  String get addPage => 'Añadir página';

  @override
  String get removePage => 'Quitar página';

  @override
  String get rotatePage => 'Girar página';

  @override
  String pageNumber(int number) {
    return 'Página $number';
  }

  @override
  String get cropTop => 'Recortar por arriba';

  @override
  String get cropBottom => 'Recortar por abajo';

  @override
  String get cropLeft => 'Recortar por la izquierda';

  @override
  String get cropRight => 'Recortar por la derecha';

  @override
  String get enhanceDocument => 'Mejorar contraste del documento';

  @override
  String get saveScan => 'Guardar escaneo como PDF';

  @override
  String get scanName => 'Nombre del documento';

  @override
  String get noPages => 'Añade al menos una página.';

  @override
  String get desktopScanHelp =>
      'Selecciona imágenes guardadas por tu escáner o cámara. No es necesario controlar directamente el escáner.';

  @override
  String get attachmentType => 'Tipo de archivo adjunto';

  @override
  String get previousPage => 'Página anterior';

  @override
  String get nextPage => 'Página siguiente';

  @override
  String get processingDocument => 'Procesando documento en este dispositivo';

  @override
  String get readOnlyDetails => 'Detalles de la garantía';

  @override
  String get selectWarranty => 'Selecciona una garantía para ver sus detalles.';
}
