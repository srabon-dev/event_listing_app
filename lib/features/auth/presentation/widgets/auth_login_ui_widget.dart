import '../../../../app_export.dart';

class AuthLoginUiWidget extends StatelessWidget {
  const AuthLoginUiWidget({super.key, required this.email, required this.password});

  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          title: context.loc.email_address,
          hintText: "NeilMarshall@gmail.com",
          keyboardType: TextInputType.emailAddress,
          controller: email,
          validator: TextFieldValidator.email(context),
        ),
        const Gap(18),
        CustomTextField(
          title: context.loc.password,
          hintText: "••••••••",
          keyboardType: TextInputType.text,
          controller: password,
          isPassword: true,
          validator: TextFieldValidator.password(context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                AppRouter.route.pushNamed(RoutePath.forgetScreen);
              },
              child: Text(
                context.loc.forgotPassword,
                style: const TextStyle(decoration: TextDecoration.none),
              ),
            ),
          ],
        ),
        const Gap(12),
      ],
    );
  }
}
