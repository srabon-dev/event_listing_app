import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:event_listing_app/app_export.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final List<String>? items;
  final String? value;
  final String extraText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;

  final Map<String, String>? labels;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.extraText = "",
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final safeItems = items ?? [];
    final bool isValueValid = safeItems.contains(value);
    final message = AppLocalizations.of(context)!.fieldIsRequired;

    String? Function(String?)? validation =
    (isRequired ? (val) => (val == null || val.isEmpty) ? message : null : null);
    final validationFunction = validator ?? validation;

    final isExtraTextNotEmpty = extraText.isNotEmpty;

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: isValueValid ? value : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: false,
        hintStyle: const TextStyle(color: AppColors.brandHoverColor),
        errorStyle: const TextStyle(color: AppColors.brandHoverColor),
      ),
      hint: Text(hintText, style: const TextStyle(color: AppColors.brandHoverColor, fontSize: 16),),
      items: safeItems.map((key) {
        final label = labels?[key] ?? key;
        return DropdownMenuItem<String>(
          value: key,
          child: Text(
            label + (isExtraTextNotEmpty ? " $extraText" : ""),
            style: const TextStyle(
              color: AppColors.brandHoverColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      onChanged: safeItems.isEmpty ? null : onChanged,
      validator: validationFunction,
      style: const TextStyle(
        color: AppColors.brandHoverColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      buttonStyleData: const ButtonStyleData(padding: EdgeInsets.only(right: 8)),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down, color: AppColors.brandHoverColor),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
