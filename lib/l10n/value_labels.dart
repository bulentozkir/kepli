import '../domain/models.dart';
import 'app_localizations.dart';

String localizeCategory(AppLocalizations strings, String category) =>
    switch (category) {
      'Electronics' => strings.categoryElectronics,
      'Appliances' => strings.categoryAppliances,
      'Tools' => strings.categoryTools,
      'Other' => strings.categoryOther,
      _ => category,
    };

String localizeAttachmentRole(AppLocalizations strings, AttachmentRole role) =>
    switch (role) {
      AttachmentRole.receipt => strings.receipt,
      AttachmentRole.warranty => strings.warrantyPaper,
      AttachmentRole.product => strings.productPhoto,
      AttachmentRole.businessCard => strings.businessCard,
    };

String localizeContactRole(AppLocalizations strings, ContactRole role) =>
    switch (role) {
      ContactRole.sales => strings.salesContact,
      ContactRole.service => strings.serviceContact,
    };

String localizeStatus(AppLocalizations strings, ItemStatus status) =>
    switch (status) {
      ItemStatus.active => strings.active,
      ItemStatus.expired => strings.expired,
      ItemStatus.claimed => strings.claimed,
    };
