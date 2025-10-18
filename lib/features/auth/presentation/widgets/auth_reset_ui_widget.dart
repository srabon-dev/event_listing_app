import '../../../../app_export.dart';

class AuthResetUiWidget extends StatelessWidget {
  const AuthResetUiWidget({super.key, required this.password, required this.confirmPassword});

  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAlignText(
          text: context.loc.setANewPassword,
          style: context.headlineSmall,
        ),
        const Gap(5),
        CustomAlignText(
          text: AppLocalizations.of(context)!.createANewPasswordEnsureTtDiffersFrom,
          maxLine: 3,
          style: context.bodyMedium,
        ),
        const Gap(24),

        ///==================== input Field =======================
        const Gap(18),
        CustomTextField(
          title: AppLocalizations.of(context)!.password,
          hintText: AppLocalizations.of(context)!.enterYourPassword,
          keyboardType: TextInputType.text,
          controller: password,
          isPassword: true,
          validator: TextFieldValidator.password(context),
        ),
        const Gap(18),
        CustomTextField(
          title: AppLocalizations.of(context)!.confirmPassword,
          hintText: AppLocalizations.of(context)!.confirmPassword,
          keyboardType: TextInputType.text,
          controller: confirmPassword,
          isPassword: true,
          validator: TextFieldValidator.confirmPassword(context, password),
        ),
        const Gap(12),
      ],
    );
  }
}
