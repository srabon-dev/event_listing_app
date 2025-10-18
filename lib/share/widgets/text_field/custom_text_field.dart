import 'package:flutter/services.dart';
import 'package:event_listing_app/app_export.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.inputFormatters,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = AppColors.brandHoverColor,
    this.inputTextStyle,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.maxLines = 1,
    this.minLines = 1,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.prefix,
    this.suffixIconColor,
    this.isPassword = false,
    this.readOnly = false,
    this.maxLength,
    super.key,
    this.prefixIcon,
    this.onTap,
    this.isCollapsed,
    this.isDense,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.suffix,
    this.initialValue,
    this.fillColor,
    this.contentPadding,
    this.title,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextStyle? inputTextStyle;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;

  final Color? suffixIconColor;
  final Color? fillColor;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final OutlineInputBorder? border;

  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? enabledBorder;

  final bool isPassword;
  final Widget? suffix;
  final bool readOnly;
  final int? maxLength;
  final bool? isCollapsed;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final String? title;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureText,
      builder: (context, obscureText, _) {
        return Column(
          children: [
            if(widget.title != null)
              CustomAlignText(text: widget.title ?? ""),
            if(widget.title != null)
              const Gap(8),
            TextFormField(
              onTap: widget.onTap,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: widget.inputFormatters,
              onFieldSubmitted: widget.onFieldSubmitted,
              readOnly: widget.readOnly,
              controller: widget.controller,
              initialValue: widget.initialValue,
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              cursorColor: widget.cursorColor,
              style: widget.inputTextStyle,
              onChanged: widget.onChanged,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              obscureText: widget.isPassword ? obscureText : false,
              validator: widget.validator,
              decoration: InputDecoration(
                fillColor: widget.fillColor,
                contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
                isCollapsed: widget.isCollapsed,
                isDense: widget.isDense,
                errorMaxLines: 2,
                hintText: widget.hintText,
                filled: true,
                prefixIcon: widget.prefixIcon,
                prefix: widget.prefix,
                suffix: widget.suffix,
                suffixIcon: widget.isPassword ? GestureDetector(
                  onTap: toggle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    child: obscureText ? const Icon(Icons.visibility_off_outlined, color: AppColors.brandHoverColor,) :
                    const Icon(Icons.visibility_outlined, color: AppColors.brandHoverColor,),
                  ),
                ) : widget.suffixIcon,
                suffixIconColor: widget.suffixIconColor,
                border: widget.border,
                focusedBorder: widget.focusedBorder,
                enabledBorder: widget.enabledBorder,
              ),
            ),
          ],
        );
      },
    );
  }

  void toggle() {
    _obscureText.value = !_obscureText.value;
  }
}
