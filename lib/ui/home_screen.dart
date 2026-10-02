import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/app_notice.dart';
import '../application/vault_controller.dart';
import '../domain/models.dart';
import 'about_screen.dart';
import 'backup_screen.dart';
import 'contact_editor.dart';
import 'settings_screen.dart';
import 'ui_support.dart';
import 'warranty_detail.dart';
import 'warranty_editor.dart';

enum _Destination { warranties, backups, settings, about }

enum _WarrantyFilter { all, active, soon, expired, claimed }

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final _settings = GlobalKey<SettingsScreenState>();
  final _search = TextEditingController();
  final _listScroll = ScrollController();
  _Destination _destination = _Destination.warranties;
  _WarrantyFilter _filter = _WarrantyFilter.all;
  String _category = '';
  Object? _error;
  bool _allowExit = false;

  @override
  void dispose() {
    _search.dispose();
    _listScroll.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    try {
      await ref.read(vaultProvider.notifier).refresh();
      if (mounted) setState(() => _error = null);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  Future<void> _navigate(_Destination destination) async {
    if (destination == _destination) return;
    if (ref.read(vaultProvider).busy) return;
    if (_destination == _Destination.settings &&
        !(await _settings.currentState?.confirmLeave() ?? true)) {
      return;
    }
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _destination = destination;
      _allowExit = false;
    });
  }

  Future<void> _newWarranty({bool recovered = false}) async {
    final photos = recovered
        ? ref.read(vaultProvider).recoveredPhotos
        : <PendingAttachment>[];
    WarrantyItem? linkedItem;
    if (recovered) {
      final ids = photos
          .map((photo) => photo.contactId)
          .whereType<String>()
          .toSet();
      linkedItem = ref
          .read(vaultProvider)
          .snapshot
          .items
          .where(
            (item) => item.contacts.any((contact) => ids.contains(contact.id)),
          )
          .firstOrNull;
    }
    final usablePhotos = <PendingAttachment>[];
    final recoveredContacts = <String, ItemContact>{};
    for (final photo in photos) {
      if (photo.contactId != null &&
          !(linkedItem?.contacts.any(
                (contact) => contact.id == photo.contactId,
              ) ??
              false)) {
        var contact = recoveredContacts[photo.contactId];
        contact ??= await editContact(context);
        if (!mounted || contact == null) return;
        recoveredContacts[photo.contactId!] = contact;
        usablePhotos.add(
          PendingAttachment(
            sourcePath: photo.sourcePath,
            originalName: photo.originalName,
            mimeType: photo.mimeType,
            role: AttachmentRole.businessCard,
            contactId: contact.id,
          ),
        );
      } else {
        usablePhotos.add(photo);
      }
    }
    await restoreFocusAfter(
      () => Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => WarrantyEditor(
            item: linkedItem,
            recoveredPhotos: usablePhotos,
            initialContacts: recoveredContacts.values.toList(),
          ),
        ),
      ),
    );
  }

  void _selectItem(WarrantyItem item, bool split) {
    ref.read(vaultProvider.notifier).selectItem(item.id);
    if (!split) {
      restoreFocusAfter(
        () => Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (context) => WarrantyDetailScreen(itemId: item.id),
          ),
        ),
      );
    }
  }

  void _clearFilters() => setState(() {
    _search.clear();
    _filter = _WarrantyFilter.all;
    _category = '';
  });

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vaultProvider);
    final l10n = context.l10n;
    final width = MediaQuery.sizeOf(context).width;
    final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
    final rail = width >= 760 && scale <= 1.8;
    final split = width >= 1000 && scale <= 1.5;
    final navigation = [
      (_Destination.warranties, l10n.warranties, Icons.inventory_2_outlined),
      (_Destination.backups, l10n.backups, Icons.archive_outlined),
      (_Destination.settings, l10n.settings, Icons.settings_outlined),
      (_Destination.about, l10n.about, Icons.info_outline),
    ];
    final title = navigation.firstWhere((entry) => entry.$1 == _destination).$2;
    final page = switch (_destination) {
      _Destination.warranties => _warranties(state, split),
      _Destination.backups => const BackupScreen(),
      _Destination.settings => SettingsScreen(key: _settings),
      _Destination.about => const AboutScreen(),
    };
    ref.listen<AppNotice?>(vaultProvider.select((state) => state.notice), (
      previous,
      next,
    ) {
      if (next == null || next == previous) return;
      final label = noticeLabel(context, next);
      if (label != null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Semantics(liveRegion: true, child: Text(label)),
            showCloseIcon: true,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    });
    return PopScope<void>(
      canPop: _allowExit || _destination != _Destination.settings,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || _allowExit) return;
        if (await _settings.currentState?.confirmLeave() ?? true) {
          if (mounted) {
            setState(() => _allowExit = true);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) Navigator.of(context).maybePop();
            });
          }
        }
      },
      child: Scaffold(
        key: _scaffold,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: rail
              ? null
              : AccessibleIconButton(
                  label: l10n.menu,
                  icon: Icons.menu,
                  onPressed: () => _scaffold.currentState!.openDrawer(),
                ),
          title: Text(
            _destination == _Destination.warranties ? l10n.appTitle : title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            if (_destination == _Destination.warranties)
              AccessibleIconButton(
                label: l10n.addWarranty,
                icon: Icons.add,
                onPressed: state.busy ? null : _newWarranty,
              ),
          ],
        ),
        drawer: rail
            ? null
            : Drawer(
                width: math.min(380, width - 16),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: AccessibleIconButton(
                            label: l10n.close,
                            icon: Icons.close,
                            onPressed: () =>
                                _scaffold.currentState!.closeDrawer(),
                          ),
                        ),
                        SectionHeading(l10n.appTitle),
                        Text(l10n.tagline),
                        const SizedBox(height: 24),
                        for (final entry in navigation)
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              bottom: 12,
                            ),
                            child: Semantics(
                              selected: _destination == entry.$1,
                              child: ActionButton(
                                key: ValueKey('nav-${entry.$1.name}'),
                                label: entry.$2,
                                icon: entry.$3,
                                primary: _destination == entry.$1,
                                onPressed: state.busy
                                    ? null
                                    : () {
                                        _scaffold.currentState!.closeDrawer();
                                        _navigate(entry.$1);
                                      },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (rail) ...[
                NavigationRail(
                  selectedIndex: _destination.index,
                  onDestinationSelected: state.busy
                      ? null
                      : (index) => _navigate(_Destination.values[index]),
                  destinations: [
                    for (final entry in navigation)
                      NavigationRailDestination(
                        icon: Tooltip(message: entry.$2, child: Icon(entry.$3)),
                        label: Text(entry.$2),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
              ],
              Expanded(
                child: Column(
                  children: [
                    if (state.busy)
                      LinearProgressIndicator(semanticsLabel: l10n.busy),
                    Expanded(child: page),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _warranties(VaultState state, bool split) {
    final items = state.snapshot.items;
    final today = CalendarDate.fromDateTime(DateTime.now());
    final soonDays = state.snapshot.settings.reminderDays.fold<int>(
      0,
      math.max,
    );
    bool soon(WarrantyItem item) =>
        item.statusAt(today) == ItemStatus.active &&
        item.expiryDate.differenceInDays(today) <= soonDays;
    final query = _search.text.trim().toLowerCase();
    final visible =
        items.where((item) {
          final matchesText =
              query.isEmpty ||
              [
                item.name,
                item.vendor ?? '',
                item.category,
                categoryLabel(context, item.category),
              ].any((text) => text.toLowerCase().contains(query));
          final matchesStatus = switch (_filter) {
            _WarrantyFilter.all => true,
            _WarrantyFilter.active => item.statusAt(today) == ItemStatus.active,
            _WarrantyFilter.soon => soon(item),
            _WarrantyFilter.expired =>
              item.statusAt(today) == ItemStatus.expired,
            _WarrantyFilter.claimed =>
              item.statusAt(today) == ItemStatus.claimed,
          };
          return matchesText &&
              matchesStatus &&
              (_category.isEmpty || _category == item.category);
        }).toList()..sort((a, b) {
          final expiry = a.expiryDate.compareTo(b.expiryDate);
          return expiry != 0
              ? expiry
              : a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
    final list = Scrollbar(
      controller: _listScroll,
      child: ListView.builder(
        controller: _listScroll,
        padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 32),
        itemCount: visible.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _listHeader(
              state,
              visible.length,
              items
                  .where((item) => item.statusAt(today) == ItemStatus.active)
                  .length,
              items.where(soon).length,
              items
                  .where((item) => item.statusAt(today) == ItemStatus.expired)
                  .length,
              items
                  .where((item) => item.statusAt(today) == ItemStatus.claimed)
                  .length,
            );
          }
          final item = visible[index - 1];
          return _WarrantyTile(
            item: item,
            today: today,
            selected: split && item.id == state.selectedItemId,
            onPressed: state.busy ? null : () => _selectItem(item, split),
          );
        },
      ),
    );
    if (!split) return list;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 4, child: list),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 6,
          child: state.selectedItemId == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(context.l10n.selectWarranty),
                  ),
                )
              : WarrantyDetailPane(itemId: state.selectedItemId!),
        ),
      ],
    );
  }

  Widget _listHeader(
    VaultState state,
    int visible,
    int active,
    int soon,
    int expired,
    int claimed,
  ) {
    final l10n = context.l10n;
    final labels = [
      (_WarrantyFilter.all, l10n.all),
      (_WarrantyFilter.active, l10n.active),
      (_WarrantyFilter.soon, l10n.expiringSoon),
      (_WarrantyFilter.expired, l10n.expired),
      (_WarrantyFilter.claimed, l10n.claimed),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            l10n.warranties,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 8),
        Text(l10n.tagline),
        if (_error != null)
          ErrorPanel(error: _error!, onRetry: state.busy ? null : _refresh),
        if (state.notice != null)
          NoticePanel(
            notice: state.notice!,
            onDismiss: ref.read(vaultProvider.notifier).dismissNotice,
          ),
        if (state.recoveredPhotos.isNotEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.recoveredPhotoHelp),
                  const SizedBox(height: 8),
                  ActionButton(
                    label: l10n.recoverPhoto,
                    icon: Icons.add_photo_alternate_outlined,
                    onPressed: state.busy
                        ? null
                        : () => _newWarranty(recovered: true),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final statistic in [
              (
                _WarrantyFilter.active,
                l10n.active,
                active,
                Icons.verified_outlined,
              ),
              (
                _WarrantyFilter.soon,
                l10n.expiringSoon,
                soon,
                Icons.event_available_outlined,
              ),
              (
                _WarrantyFilter.expired,
                l10n.expired,
                expired,
                Icons.event_busy_outlined,
              ),
              (_WarrantyFilter.claimed, l10n.claimed, claimed, Icons.task_alt),
            ])
              Semantics(
                selected: _filter == statistic.$1,
                child: ActionButton(
                  label:
                      '${statistic.$2}: ${numberLabel(context, statistic.$3)}',
                  icon: statistic.$4,
                  onPressed: () => setState(() => _filter = statistic.$1),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          key: const Key('warranty-search'),
          controller: _search,
          decoration: InputDecoration(
            labelText: l10n.searchHint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _search.text.isEmpty
                ? null
                : AccessibleIconButton(
                    label: l10n.clearFilters,
                    icon: Icons.close,
                    onPressed: _clearFilters,
                  ),
          ),
          onChanged: (value) => setState(() {}),
          textInputAction: TextInputAction.search,
        ),
        const SizedBox(height: 12),
        ChoiceField<_WarrantyFilter>(
          key: const Key('status-filter'),
          label: l10n.warranties,
          value: _filter,
          choices: [for (final value in labels) Choice(value.$1, value.$2)],
          onChanged: (value) => setState(() => _filter = value),
        ),
        const SizedBox(height: 12),
        ChoiceField<String>(
          key: const Key('category-filter'),
          label: l10n.category,
          value: _category,
          choices: [
            Choice('', l10n.all),
            for (final category in state.snapshot.settings.categories)
              Choice(category, categoryLabel(context, category)),
          ],
          onChanged: (value) => setState(() => _category = value),
        ),
        const SizedBox(height: 12),
        Text(l10n.sortHint),
        Semantics(liveRegion: true, child: Text(l10n.itemCount(visible))),
        const SizedBox(height: 16),
        ActionButton(
          key: const Key('add-warranty'),
          label: l10n.addWarranty,
          icon: Icons.add,
          primary: true,
          onPressed: state.busy ? null : _newWarranty,
        ),
        const SizedBox(height: 16),
        if (visible == 0) ...[
          SectionHeading(
            state.snapshot.items.isEmpty ? l10n.noWarranties : l10n.noMatches,
          ),
          if (state.snapshot.items.isEmpty)
            Text(l10n.getStarted)
          else
            ActionButton(
              label: l10n.clearFilters,
              icon: Icons.filter_alt_off_outlined,
              onPressed: _clearFilters,
            ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _WarrantyTile extends StatelessWidget {
  const _WarrantyTile({
    required this.item,
    required this.today,
    required this.selected,
    required this.onPressed,
  });
  final WarrantyItem item;
  final CalendarDate today;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final status = item.statusAt(today);
    final colors = Theme.of(context).colorScheme;
    return Card(
      key: ValueKey('warranty-${item.id}'),
      margin: const EdgeInsetsDirectional.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: Semantics(
        selected: selected,
        button: true,
        child: InkWell(
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(categoryLabel(context, item.category)),
                  if (item.vendor != null) Text(item.vendor!),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      StatusBadge(status: status),
                      Text(
                        '${context.l10n.expiryDate}: ${dateLabel(context, item.expiryDate)}',
                      ),
                      if (status == ItemStatus.active)
                        Text(
                          context.l10n.daysLeft(
                            item.expiryDate.differenceInDays(today),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
