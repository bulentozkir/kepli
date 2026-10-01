// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Kepli';

  @override
  String get tagline => 'Suas garantias. Seus recibos. Tudo seu.';

  @override
  String get warranties => 'Garantias';

  @override
  String get backups => 'Cópias de segurança';

  @override
  String get settings => 'Configurações';

  @override
  String get addWarranty => 'Adicionar garantia';

  @override
  String get editWarranty => 'Editar garantia';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get close => 'Fechar';

  @override
  String get edit => 'Editar';

  @override
  String get searchHint => 'Buscar por nome, loja ou categoria';

  @override
  String get all => 'Todas';

  @override
  String get active => 'Ativas';

  @override
  String get expiringSoon => 'Perto de vencer';

  @override
  String get expired => 'Vencidas';

  @override
  String get claimed => 'Acionadas';

  @override
  String get status => 'Estado';

  @override
  String get noWarranties => 'Ainda não há garantias';

  @override
  String get getStarted =>
      'Adicione uma compra e mantenha o recibo, os documentos de garantia e os contatos juntos.';

  @override
  String get noMatches => 'Nenhuma garantia correspondente';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get purchaseDate => 'Data da compra';

  @override
  String get expiryDate => 'Data de vencimento';

  @override
  String get warrantyLength => 'Prazo da garantia';

  @override
  String get months => 'Meses';

  @override
  String get years => 'Anos';

  @override
  String get customDuration => 'Duração personalizada';

  @override
  String get name => 'Nome';

  @override
  String get nameHint => 'Por exemplo, geladeira da cozinha';

  @override
  String get category => 'Categoria';

  @override
  String get vendor => 'Loja ou vendedor';

  @override
  String get price => 'Preço (opcional)';

  @override
  String get currency => 'Código da moeda';

  @override
  String get notes => 'Anotações';

  @override
  String get productPhoto => 'Foto do produto';

  @override
  String get receipt => 'Recibo';

  @override
  String get warrantyPaper => 'Documento de garantia';

  @override
  String get attachments => 'Anexos';

  @override
  String get addFiles => 'Adicionar arquivos';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get choosePhoto => 'Escolher fotos';

  @override
  String get removeAttachment => 'Remover anexo';

  @override
  String get openAttachment => 'Abrir anexo';

  @override
  String get markClaimed => 'Marcar como acionada';

  @override
  String get markActive => 'Remover status de acionada';

  @override
  String get exportPdf => 'Exportar garantia em PDF';

  @override
  String get deleteWarranty => 'Excluir garantia?';

  @override
  String deleteWarrantyWarning(String name) {
    return 'Excluir $name e todos os seus anexos deste dispositivo? Essa ação não pode ser desfeita.';
  }

  @override
  String daysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Faltam $count dias',
      one: 'Falta 1 dia',
      zero: 'Vence hoje',
    );
    return '$_temp0';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count garantias',
      one: '1 garantia',
      zero: 'Nenhuma garantia',
    );
    return '$_temp0';
  }

  @override
  String get fieldRequired => 'Este campo é obrigatório.';

  @override
  String get invalidDuration => 'Informe de 1 a 1.200 meses.';

  @override
  String get invalidPrice => 'Informe um valor com até duas casas decimais.';

  @override
  String get invalidCurrency =>
      'Informe um código de moeda com três letras, como USD.';

  @override
  String get invalidEmail => 'Informe um endereço de e-mail válido.';

  @override
  String get discardChanges => 'Descartar alterações não salvas?';

  @override
  String get discard => 'Descartar';

  @override
  String get keepEditing => 'Continuar editando';

  @override
  String get restoreBackup => 'Restaurar cópia de segurança';

  @override
  String get exportBackup => 'Exportar cópia de segurança';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get backupExplanation =>
      'Um único arquivo ZIP contém suas garantias, contatos, preferências e anexos originais. Transfira-o para outro dispositivo e restaure-o lá. Isso é uma transferência manual, não uma sincronização automática.';

  @override
  String get backupPrivacy =>
      'As cópias de segurança não são criptografadas. Guarde-as em um local seguro. O Kepli não tem serviço em nuvem; você controla os destinos escolhidos no painel de compartilhamento do sistema.';

  @override
  String get chooseBackup => 'Escolher arquivo de cópia de segurança';

  @override
  String get backupPreview => 'Revisar cópia de segurança';

  @override
  String get newWarranties => 'Novas garantias';

  @override
  String backupSummary(int items, int files) {
    return '$items garantias e $files anexos';
  }

  @override
  String exportedOn(String date, String platform) {
    return 'Exportado em $date no $platform';
  }

  @override
  String get merge => 'Mesclar';

  @override
  String get mergeHelp =>
      'Adiciona novas garantias e mantém a versão mais recente das garantias correspondentes. As preferências atuais são mantidas.';

  @override
  String get replaceAll => 'Substituir tudo';

  @override
  String get replaceHelp =>
      'Substitui as garantias e preferências deste dispositivo pelas da cópia de segurança.';

  @override
  String replaceConfirmation(int count) {
    return 'Substituir permanentemente todas as $count garantias deste dispositivo? Exporte uma cópia de segurança primeiro se quiser mantê-las.';
  }

  @override
  String get confirmReplace => 'Substituir todas as garantias';

  @override
  String get conflicts => 'Garantias correspondentes';

  @override
  String get keepLocal => 'Manter a versão deste dispositivo';

  @override
  String get useBackup => 'Usar a versão mais recente da cópia de segurança';

  @override
  String get newerWinsHelp =>
      'Normalmente, a atualização mais recente prevalece. Quando as datas e horas coincidem, a versão deste dispositivo é mantida. Selecione as garantias abaixo para manter a versão local em vez da mais recente.';

  @override
  String get restore => 'Restaurar';

  @override
  String get notifications => 'Lembretes';

  @override
  String get enableReminders => 'Ativar lembretes de vencimento';

  @override
  String get reminderDays => 'Dias antes do vencimento';

  @override
  String get reminderDaysHelp =>
      'Separe os valores por vírgulas, por exemplo 30, 7, 1. Use 0 para a data de vencimento.';

  @override
  String get invalidReminderDays =>
      'Informe de 1 a 12 valores distintos, cada um entre 0 e 3.650 dias.';

  @override
  String get reminderHour => 'Hora do lembrete (0-23)';

  @override
  String get invalidReminderHour => 'Informe uma hora entre 0 e 23.';

  @override
  String get reminderLimit =>
      'Apenas os lembretes mais próximos cabem na fila do sistema operacional. Abra o Kepli regularmente para reabastecê-la.';

  @override
  String get notificationPrivacy =>
      'Os lembretes são agendados localmente. Permissões, configurações de bateria e o sistema operacional podem atrasá-los ou impedi-los. Sua lista de garantias perto de vencer está sempre disponível.';

  @override
  String get permissionRequired =>
      'É necessária permissão para enviar notificações.';

  @override
  String get requestPermission => 'Solicitar permissão';

  @override
  String get remindersOff => 'Os lembretes estão desativados.';

  @override
  String get remindersUnavailable =>
      'Os lembretes do sistema estão indisponíveis. Use a lista de garantias perto de vencer.';

  @override
  String remindersScheduled(int count) {
    return '$count lembretes agendados.';
  }

  @override
  String get linuxReminderHelp =>
      'No Linux, os lembretes funcionam apenas enquanto o Kepli está aberto e um serviço de notificações está disponível.';

  @override
  String get accessibility => 'Acessibilidade';

  @override
  String get highContrast => 'Aumentar contraste';

  @override
  String get reduceMotion => 'Reduzir movimento';

  @override
  String get accessibilityHelp =>
      'O Kepli também respeita as configurações do sistema para tamanho do texto, leitor de tela, contraste e redução de movimento. Todas as ações estão disponíveis sem gestos.';

  @override
  String get language => 'Idioma';

  @override
  String get languageHelp =>
      'Escolha o idioma da interface. O inglês é o padrão. O texto dos itens salvos não é traduzido.';

  @override
  String get categories => 'Categorias';

  @override
  String get addCategory => 'Adicionar categoria';

  @override
  String get renameCategory => 'Renomear categoria';

  @override
  String get deleteCategory => 'Excluir categoria';

  @override
  String get categoryInUse =>
      'Esta categoria é usada por uma garantia. Altere primeiro a categoria dessa garantia.';

  @override
  String get newCategory => 'Nome da categoria';

  @override
  String get categoryExists => 'Essa categoria já existe.';

  @override
  String get categoryElectronics => 'Eletrônicos';

  @override
  String get categoryAppliances => 'Eletrodomésticos';

  @override
  String get categoryTools => 'Ferramentas';

  @override
  String get categoryOther => 'Outros';

  @override
  String get exportReports => 'Relatórios';

  @override
  String get about => 'Sobre o Kepli';

  @override
  String get privacyTitle => 'Local. Privado. Seu.';

  @override
  String get privacyBody =>
      'Sem conta, assinatura, análise de uso ou nuvem do Kepli. Seus registros ficam no armazenamento deste aplicativo até você exportá-los ou compartilhá-los. Exporte cópias de segurança regularmente: desinstalar o aplicativo ou perder um dispositivo pode apagar seus dados.';

  @override
  String get appVersion => 'Versão';

  @override
  String get operationFailed => 'Não foi possível concluir a operação.';

  @override
  String get technicalDetails => 'Detalhes técnicos';

  @override
  String get saved => 'Garantia salva neste dispositivo.';

  @override
  String get deleted => 'Garantia e seus anexos excluídos.';

  @override
  String get restored =>
      'Cópia de segurança restaurada. Todos os anexos referenciados foram verificados.';

  @override
  String get settingsSaved => 'Configurações salvas.';

  @override
  String get exportReady => 'Exportação pronta.';

  @override
  String get exportCancelled => 'Exportação cancelada.';

  @override
  String fileSavedTo(String path) {
    return 'Arquivo salvo em $path';
  }

  @override
  String get shareOpened =>
      'Escolha onde salvar ou enviar o arquivo no painel de compartilhamento.';

  @override
  String get loading => 'Carregando';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get startupError =>
      'O Kepli não conseguiu abrir seus dados locais. Seus arquivos existentes não foram redefinidos.';

  @override
  String get unavailableImage =>
      'Prévia da imagem indisponível. Você ainda pode abrir o arquivo original.';

  @override
  String get largeAttachmentTitle => 'Anexo grande';

  @override
  String largeAttachmentWarning(String size) {
    return 'Este arquivo tem $size MB. Anexos grandes tornam as cópias de segurança mais lentas e ocupam mais espaço.';
  }

  @override
  String get continueAction => 'Continuar';

  @override
  String get recoverPhoto => 'Usar foto recuperada';

  @override
  String get recoveredPhotoHelp =>
      'Uma foto foi recuperada após a câmera reiniciar o aplicativo. Adicione-a a uma garantia para não perdê-la.';

  @override
  String get dismiss => 'Dispensar';

  @override
  String get busy => 'Operação em andamento. Aguarde.';

  @override
  String get menu => 'Menu';

  @override
  String get sortHint => 'Ordenadas pelo vencimento mais próximo';

  @override
  String get requiredFields =>
      'Nome, categoria, data da compra e prazo da garantia são obrigatórios.';

  @override
  String get chooseDate => 'Escolher data da compra';

  @override
  String get selected => 'Selecionado';

  @override
  String get notSet => 'Não definido';

  @override
  String get reportTitle => 'Relatório de garantias';

  @override
  String get pdfReferences =>
      'Os recibos e documentos de garantia em PDF são listados pelo nome do arquivo. Compartilhe os arquivos originais separadamente quando necessário.';

  @override
  String get documentFooter =>
      'Gerado localmente pelo Kepli. Este relatório não é uma cópia de segurança restaurável.';

  @override
  String get notificationTitle => 'Garantia perto de vencer';

  @override
  String notificationBody(String name, String date) {
    return '$name: a garantia vence em $date.';
  }

  @override
  String get contacts => 'Contatos de vendas e assistência técnica';

  @override
  String get addContact => 'Adicionar contato';

  @override
  String get editContact => 'Editar contato';

  @override
  String get removeContact => 'Remover contato';

  @override
  String get salesContact => 'Vendas';

  @override
  String get serviceContact => 'Assistência técnica';

  @override
  String get contactName => 'Pessoa de contato';

  @override
  String get organization => 'Empresa ou organização';

  @override
  String get phone => 'Telefone';

  @override
  String get email => 'E-mail';

  @override
  String get contactNotes => 'Anotações do contato';

  @override
  String get noContacts => 'Nenhum contato adicionado';

  @override
  String get businessCard => 'Cartão de visita';

  @override
  String get scanBusinessCard => 'Digitalizar cartão de visita';

  @override
  String get addBusinessCard => 'Adicionar cartão de visita';

  @override
  String get businessCardHelp =>
      'Fotografe ou importe o cartão e anexe-o a este contato. Insira os dados da pessoa abaixo; o Kepli não usa reconhecimento óptico de caracteres na nuvem.';

  @override
  String get businessCardNeedsContact =>
      'Salve o nome do contato antes de anexar um cartão de visita.';

  @override
  String get scanDocument => 'Digitalizar documento';

  @override
  String get scanHelp =>
      'Fotografe páginas ou selecione imagens, depois recorte, gire e salve tudo em um único PDF. O processamento permanece neste dispositivo; o texto não é extraído automaticamente.';

  @override
  String get addPage => 'Adicionar página';

  @override
  String get removePage => 'Remover página';

  @override
  String get rotatePage => 'Girar página';

  @override
  String pageNumber(int number) {
    return 'Página $number';
  }

  @override
  String get cropTop => 'Recortar por cima';

  @override
  String get cropBottom => 'Recortar por baixo';

  @override
  String get cropLeft => 'Recortar pela esquerda';

  @override
  String get cropRight => 'Recortar pela direita';

  @override
  String get enhanceDocument => 'Melhorar contraste do documento';

  @override
  String get saveScan => 'Salvar digitalização como PDF';

  @override
  String get scanName => 'Nome do documento';

  @override
  String get noPages => 'Adicione pelo menos uma página.';

  @override
  String get desktopScanHelp =>
      'Selecione imagens salvas pelo scanner ou pela câmera. Não é necessário controlar diretamente o equipamento de digitalização.';

  @override
  String get attachmentType => 'Tipo de anexo';

  @override
  String get previousPage => 'Página anterior';

  @override
  String get nextPage => 'Próxima página';

  @override
  String get processingDocument => 'Processando documento neste dispositivo';

  @override
  String get readOnlyDetails => 'Detalhes da garantia';

  @override
  String get selectWarranty => 'Selecione uma garantia para ver seus detalhes.';
}
