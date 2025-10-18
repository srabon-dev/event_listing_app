import 'package:pinput/pinput.dart';
import 'package:event_listing_app/app_export.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final basePinTheme = PinTheme(
      height: 50,
      width: 50,
      textStyle: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.brandHoverColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.brandHoverColor),
      ),
    );

    return FormField<String>(
      validator: (value) {
        if (controller.text.isEmpty) {
          return AppLocalizations.of(context)!.otpIsRequired;
        }
        if (controller.text.length != 6) {
          return AppLocalizations.of(context)!.otpMustBe6Digits;
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Pinput(
              length: 6,
              controller: controller,
              autofocus: true,

              defaultPinTheme: basePinTheme,
              focusedPinTheme: basePinTheme.copyWith(
                decoration: basePinTheme.decoration?.copyWith(
                  border: Border.all(color: AppColors.brandHoverColor),
                ),
              ),
              submittedPinTheme: basePinTheme,
              errorPinTheme: basePinTheme.copyWith(
                decoration: basePinTheme.decoration?.copyWith(
                  color: AppColors.brandHoverColor.withValues(alpha: 0.8),
                ),
              ),
              onChanged: (value) {
                field.didChange(value);
              },
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.brandHoverColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
