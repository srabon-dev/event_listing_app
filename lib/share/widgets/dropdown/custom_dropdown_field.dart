import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:event_listing_app/app_export.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final String Function(T)? labelBuilder;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool isRequired;
  final Color? fillColor;
  final String? errorText;
  final bool enabled;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.labelBuilder,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.fillColor,
    this.errorText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final message = AppLocalizations.of(context)!.fieldIsRequired;

    String? Function(T?)? validation =
    (isRequired ? (val) => (val == null) ? message : null : null);
    final validationFunction = validator ?? validation;

    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return DropdownButtonFormField2<T>(
      isExpanded: true,
      value: items.contains(value) ? value : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: hasError ? AppColors.errorColor : AppColors.brandHoverColor,
            width: 1.2,
          ),
        ),
        filled: true,
        fillColor: fillColor ?? AppColors.white,
        errorText: errorText,
        errorStyle: const TextStyle(color: AppColors.errorColor),
      ),
      hint: Text(
        hintText,
        style: const TextStyle(
          color: AppColors.brandHoverColor,
          fontSize: 14,
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(
          labelBuilder?.call(item) ?? item.toString(),
          style: const TextStyle(
            color: AppColors.brandHoverColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      )).toList(),
      onChanged: enabled ? onChanged : null,
      validator: validationFunction,
      style: const TextStyle(
        color: AppColors.brandHoverColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down, color: AppColors.brandHoverColor),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
