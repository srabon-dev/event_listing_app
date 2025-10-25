import '../../../../app_export.dart';

class AuthSignUpUiWidget extends StatelessWidget {
  const AuthSignUpUiWidget({
    super.key,
    required this.isUser,
    required this.name,
    required this.businessName,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  final bool isUser;
  final TextEditingController businessName;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        if(!isUser)
          CustomTextField(
            title: context.loc.businessName,
            hintText: context.loc.pleaseEnterYourBusinessName,
            keyboardType: TextInputType.name,
            controller: businessName,
            validator: TextFieldValidator.name(context),
          ),
        CustomTextField(
          title: context.loc.name,
          hintText: context.loc.pleaseEnterYourName,
          keyboardType: TextInputType.name,
          controller: name,
          validator: TextFieldValidator.name(context),
        ),
        CustomTextField(
          title: context.loc.email_address,
          hintText: context.loc.pleaseEnterYourEmail,
          keyboardType: TextInputType.emailAddress,
          controller: email,
          validator: TextFieldValidator.email(context),
        ),
        CustomTextField(
          title: context.loc.phone_number,
          hintText: context.loc.phone_number,
          keyboardType: TextInputType.phone,
          controller: phone,
          validator: TextFieldValidator.required(context),
        ),
        CustomTextField(
          title: context.loc.password,
          hintText: context.loc.enterYourPassword,
          keyboardType: TextInputType.text,
          controller: password,
          isPassword: true,
          validator: TextFieldValidator.password(context),
        ),
        CustomTextField(
          title: context.loc.confirmPassword,
          hintText: context.loc.confirmPassword,
          keyboardType: TextInputType.text,
          controller: confirmPassword,
          isPassword: true,
          validator: TextFieldValidator.confirmPassword(context, password),
        ),
      ],
    );
  }
}
