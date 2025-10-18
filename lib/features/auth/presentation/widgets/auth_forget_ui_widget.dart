import '../../../../app_export.dart';

class AuthForgetUiWidget extends StatelessWidget {
  const AuthForgetUiWidget({super.key, required this.email});
  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAlignText(
          text: context.loc.forgotPasswordOnly,
          style: context.headlineSmall,
        ),
        const Gap(5),
        CustomAlignText(
          text: context.loc.pleaseEnterYourEmailToResetThePassword,
          style: context.bodyLarge,
        ),
        const Gap(24),
        CustomTextField(
          title: context.loc.email_address,
          hintText: context.loc.pleaseEnterYourEmail,
          keyboardType: TextInputType.emailAddress,
          controller: email,
          validator: TextFieldValidator.email(context),
        ),
        const Gap(12),
      ],
    );
  }
}
