import '../../../../app_export.dart';

class ChangePasswordInputsWidget extends StatelessWidget {
  const ChangePasswordInputsWidget({
    super.key,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  final TextEditingController currentPassword;
  final TextEditingController newPassword;
  final TextEditingController confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        CustomTextField(
          title: context.loc.currentPassword,
          hintText: "xxxx",
          keyboardType: TextInputType.text,
          controller: currentPassword,
          isPassword: true,
          validator: TextFieldValidator.password(context),
        ),
        CustomTextField(
          title: context.loc.newPassword,
          hintText: "xxxx",
          keyboardType: TextInputType.text,
          controller: newPassword,
          isPassword: true,
          validator: TextFieldValidator.password(context),
        ),
        CustomTextField(
          title: context.loc.repeatPassword,
          hintText: "xxxx",
          keyboardType: TextInputType.text,
          controller: confirmNewPassword,
          isPassword: true,
          validator: TextFieldValidator.confirmPassword(context, newPassword),
        ),
      ],
    );
  }
}
