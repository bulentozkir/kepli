import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../application/vault_controller.dart';
import '../domain/models.dart';
import '../services/document_scanner.dart';
import 'ui_support.dart';

class ScanDocumentScreen extends ConsumerStatefulWidget {
  const ScanDocumentScreen({
    super.key,
    this.role = AttachmentRole.receipt,
    this.contactId,
  });

  final AttachmentRole role;
  final String? contactId;

  @override
  ConsumerState<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends ConsumerState<ScanDocumentScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _pages = <ScanPage>[];
  int _index = 0;
  bool _busy = false;
  bool _leaving = false;
  Object? _error;
  late AttachmentRole _role;

  @override
  void initState() {
    super.initState();
    _role = widget.role;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _leave() async {
    if (_busy) return;
    if ((_pages.isNotEmpty || _name.text.isNotEmpty) &&
        !await confirmAction(
          context,
          title: context.l10n.discardChanges,
          message: context.l10n.discardChanges,
          confirmLabel: context.l10n.discard,
          cancelLabel: context.l10n.keepEditing,
        )) {
      return;
    }
    if (!mounted) return;
    setState(() => _leaving = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  Future<void> _addPages({required bool camera}) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final files = ref.read(dependenciesProvider).files;
      final List<PendingAttachment> selected;
      if (camera) {
        final photo = await files.takePhoto(
          role: _role,
          contactId: widget.contactId,
        );
        selected = photo == null ? [] : [photo];
      } else {
        selected = files.cameraAvailable
            ? await files.pickPhotos(role: _role, contactId: widget.contactId)
            : await files.pickAttachments(
                role: _role,
                contactId: widget.contactId,
              );
      }
      final additions = <ScanPage>[];
      for (final file in selected) {
        if (!file.mimeType.startsWith('image/')) {
          throw const KepliException(
            'Document scans accept images only. Attach existing PDF files '
            'directly to the warranty or contact instead.',
          );
        }
        if (!mounted) return;
        if (!await confirmLargeFile(context, file.sourcePath)) continue;
        additions.add(ScanPage(sourcePath: file.sourcePath));
      }
      if (!mounted) return;
      setState(() {
        if (additions.isNotEmpty) _index = _pages.length;
        _pages.addAll(additions);
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _updatePage(ScanPage page) => setState(() => _pages[_index] = page);

  Future<void> _save() async {
    if (_busy || !_form.currentState!.validate()) return;
    if (_pages.isEmpty) {
      setState(() => _error = context.l10n.noPages);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await ref
          .read(dependenciesProvider)
          .scanner
          .createPdf(
            pages: List.of(_pages),
            name: _name.text.trim(),
            role: _role,
            contactId: widget.contactId,
          );
      if (!mounted) return;
      setState(() => _leaving = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Navigator.pop(context, result);
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final files = ref.watch(dependenciesProvider).files;
    final page = _pages.isEmpty ? null : _pages[_index];
    return PopScope<PendingAttachment>(
      canPop: _leaving,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _leave();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AccessibleIconButton(
            label: l10n.cancel,
            icon: Icons.close,
            onPressed: _busy ? null : _leave,
          ),
          title: Text(
            l10n.scanDocument,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: PageBody(
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.scanHelp),
                  if (files.isDesktop || !files.cameraAvailable) ...[
                    const SizedBox(height: 12),
                    Text(l10n.desktopScanHelp),
                  ],
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('scan-name'),
                    controller: _name,
                    enabled: !_busy,
                    maxLength: 180,
                    decoration: InputDecoration(labelText: l10n.scanName),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) =>
                        value!.trim().isEmpty ? l10n.fieldRequired : null,
                  ),
                  if (_role != AttachmentRole.businessCard)
                    ChoiceField<AttachmentRole>(
                      value: _role,
                      label: l10n.attachmentType,
                      choices: [
                        for (final role in [
                          AttachmentRole.receipt,
                          AttachmentRole.warranty,
                        ])
                          Choice(role, attachmentRoleLabel(context, role)),
                      ],
                      onChanged: _busy
                          ? null
                          : (value) => setState(() => _role = value),
                    ),
                  SectionHeading(l10n.addPage),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (files.cameraAvailable)
                        ActionButton(
                          label: l10n.takePhoto,
                          icon: Icons.add_a_photo_outlined,
                          onPressed: _busy
                              ? null
                              : () => _addPages(camera: true),
                        ),
                      ActionButton(
                        key: const Key('scan-add-images'),
                        label: l10n.choosePhoto,
                        icon: Icons.add_photo_alternate_outlined,
                        onPressed: _busy
                            ? null
                            : () => _addPages(camera: false),
                      ),
                    ],
                  ),
                  if (_busy) BusyIndicator(label: l10n.processingDocument),
                  if (_error != null) ErrorPanel(error: _error!),
                  if (page == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(l10n.noPages),
                    )
                  else ...[
                    SectionHeading(l10n.pageNumber(_index + 1)),
                    _ScanPreview(
                      key: ValueKey(page.sourcePath),
                      page: page,
                      label: l10n.pageNumber(_index + 1),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionButton(
                          label: l10n.previousPage,
                          icon: Icons.navigate_before,
                          onPressed: _busy || _index == 0
                              ? null
                              : () => setState(() => _index--),
                        ),
                        ActionButton(
                          label: l10n.nextPage,
                          icon: Icons.navigate_next,
                          onPressed: _busy || _index == _pages.length - 1
                              ? null
                              : () => setState(() => _index++),
                        ),
                        ActionButton(
                          label: l10n.rotatePage,
                          icon: Icons.rotate_right,
                          onPressed: _busy
                              ? null
                              : () => _updatePage(
                                  page.copyWith(
                                    quarterTurns: (page.quarterTurns + 1) % 4,
                                  ),
                                ),
                        ),
                        ActionButton(
                          label: l10n.removePage,
                          icon: Icons.delete_outline,
                          onPressed: _busy
                              ? null
                              : () => setState(() {
                                  _pages.removeAt(_index);
                                  _index = math.max(0, _index - 1);
                                }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _CropSlider(
                      label: l10n.cropTop,
                      value: page.cropTop,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                _updatePage(page.copyWith(cropTop: value)),
                    ),
                    _CropSlider(
                      label: l10n.cropBottom,
                      value: page.cropBottom,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                _updatePage(page.copyWith(cropBottom: value)),
                    ),
                    _CropSlider(
                      label: l10n.cropLeft,
                      value: page.cropLeft,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                _updatePage(page.copyWith(cropLeft: value)),
                    ),
                    _CropSlider(
                      label: l10n.cropRight,
                      value: page.cropRight,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                _updatePage(page.copyWith(cropRight: value)),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.enhanceDocument),
                      value: page.enhance,
                      onChanged: _busy
                          ? null
                          : (value) =>
                                _updatePage(page.copyWith(enhance: value)),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ActionButton(
                    key: const Key('scan-save'),
                    label: l10n.saveScan,
                    icon: Icons.picture_as_pdf_outlined,
                    primary: true,
                    onPressed: _busy ? null : _save,
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

class _CropSlider extends StatelessWidget {
  const _CropSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final double value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    final percentage = NumberFormat.percentPattern(context.l10n.localeName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('$label: ${percentage.format(value)}'),
        Semantics(
          label: label,
          child: Slider(
            value: value,
            max: 0.45,
            divisions: 45,
            label: percentage.format(value),
            semanticFormatterCallback: percentage.format,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _ScanPreview extends StatefulWidget {
  const _ScanPreview({super.key, required this.page, required this.label});
  final ScanPage page;
  final String label;

  @override
  State<_ScanPreview> createState() => _ScanPreviewState();
}

class _ScanPreviewState extends State<_ScanPreview> {
  ImageStream? _stream;
  late final ImageStreamListener _listener;
  double? _aspectRatio;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _listener = ImageStreamListener(
      (info, synchronousCall) {
        if (mounted) {
          setState(() => _aspectRatio = info.image.width / info.image.height);
        }
        info.dispose();
      },
      onError: (Object error, StackTrace? stackTrace) {
        if (mounted) setState(() => _failed = true);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stream?.removeListener(_listener);
    _stream = _provider.resolve(createLocalImageConfiguration(context));
    _stream!.addListener(_listener);
  }

  ImageProvider get _provider => ResizeImage(
    FileImage(File(widget.page.sourcePath)),
    width: 1400,
    height: 1400,
    policy: ResizeImagePolicy.fit,
  );

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) return Text(context.l10n.unavailableImage);
    if (_aspectRatio == null) {
      return BusyIndicator(label: context.l10n.loading);
    }
    final page = widget.page;
    final ratio = page.quarterTurns.isOdd ? 1 / _aspectRatio! : _aspectRatio!;
    return Semantics(
      image: true,
      label: widget.label,
      child: ExcludeSemantics(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = math.min(constraints.maxWidth, 420 * ratio);
            return Center(
              child: SizedBox(
                width: width,
                height: width / ratio,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    RotatedBox(
                      quarterTurns: page.quarterTurns,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                          page.enhance
                              ? const [
                                  0.24449,
                                  0.82244,
                                  0.08307,
                                  0,
                                  -19.125,
                                  0.24449,
                                  0.82244,
                                  0.08307,
                                  0,
                                  -19.125,
                                  0.24449,
                                  0.82244,
                                  0.08307,
                                  0,
                                  -19.125,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                ]
                              : const [
                                  1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                ],
                        ),
                        child: Image(
                          image: _provider,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Text(context.l10n.unavailableImage),
                        ),
                      ),
                    ),
                    CustomPaint(
                      painter: _CropOverlay(
                        page: page,
                        mask: Theme.of(
                          context,
                        ).colorScheme.scrim.withValues(alpha: 0.65),
                        outline: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CropOverlay extends CustomPainter {
  const _CropOverlay({
    required this.page,
    required this.mask,
    required this.outline,
  });
  final ScanPage page;
  final Color mask;
  final Color outline;

  @override
  void paint(Canvas canvas, Size size) {
    final crop = Rect.fromLTRB(
      size.width * page.cropLeft,
      size.height * page.cropTop,
      size.width * (1 - page.cropRight),
      size.height * (1 - page.cropBottom),
    );
    final region = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRect(crop);
    canvas.drawPath(region, Paint()..color = mask);
    canvas.drawRect(
      crop,
      Paint()
        ..color = outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(_CropOverlay oldDelegate) =>
      oldDelegate.page != page ||
      oldDelegate.mask != mask ||
      oldDelegate.outline != outline;
}
