import 'package:flutter/services.dart';

import '../../../app_export.dart';

class CustomErrorTextField extends StatefulWidget {
  const CustomErrorTextField({
    this.inputFormatters,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    super.key,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    required this.title,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;
  final OutlineInputBorder? border;

  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? enabledBorder;
  final List<TextInputFormatter>? inputFormatters;
  final String title;

  @override
  State<CustomErrorTextField> createState() => _CustomErrorTextFieldState();
}

class _CustomErrorTextFieldState extends State<CustomErrorTextField> {
  String? _errorText;
  final GlobalKey _iconKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  String? _builtInValidator(String? value) {
    final trimmed = value?.trim() ?? "";
    if (trimmed.isEmpty) {
      return AppLocalizations.of(context)!.fieldIsRequired;
    }
    return null;
  }

  void _showPopup() {
    ScaffoldMessenger.of(context).clearSnackBars();

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      return;
    }

    final renderBox = _iconKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final estimatedWidth = 150.0;

    final position = renderBox.localToGlobal(Offset.zero);
    final iconSize = renderBox.size;

    final left = position.dx + iconSize.width / 2 - estimatedWidth / 2;

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: position.dy - 40,
            left: left - 20,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 6)],
                ),
                child: Text(
                  _errorText ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            if (_errorText != null)
              GestureDetector(
                key: _iconKey,
                onTap: _showPopup,
                child: const Icon(Iconsax.info_circle, color: Colors.red, size: 20),
              ),
          ],
        ),
        const Gap(8),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            hintText: widget.hintText,
            border: widget.border,
            errorText: null,
            errorStyle: const TextStyle(fontSize: 0, height: 0),
            focusedBorder: widget.focusedBorder,
            enabledBorder: widget.enabledBorder,
          ),
          validator: (value) {
            final error = _builtInValidator(value);
            if (_errorText != error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _errorText = error;
                  });
                }
              });
            }
            return null;
          },
        ),
      ],
    );
  }
}
