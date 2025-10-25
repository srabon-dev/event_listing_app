import 'package:flutter/gestures.dart';

import '../../../../app_export.dart';
import '../widgets/auth_sign_up_ui_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.isUser});

  final bool isUser;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final businessName = TextEditingController(text: kDebugMode ? "Test" : "");
  final name = TextEditingController(text: kDebugMode ? "Test" : "");
  final email = TextEditingController(text: kDebugMode ? "rv@yopmail.com" : "");
  final phone = TextEditingController();
  final password = TextEditingController(text: kDebugMode ? "%%66Test" : "");
  final confirmPassword = TextEditingController(text: kDebugMode ? "%%66Test" : "");
  final ValueNotifier<bool> isAgree = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    businessName.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    isAgree.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 64),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                const SizedBox(height: 44),
                Text(
                  context.loc.create_your_account,
                  style: context.headlineMedium.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.isUser?context.loc.join_for_free: context.loc.join_for_free_and_start,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
                AuthSignUpUiWidget(
                  isUser: widget.isUser,
                  businessName: businessName,
                  name: name,
                  email: email,
                  phone: phone,
                  password: password,
                  confirmPassword: confirmPassword,
                ),
                ValueListenableBuilder(
                  valueListenable: isAgree,
                  builder: (context, item, child) {
                    return Row(
                      children: [
                        Checkbox(
                          value: isAgree.value,
                          onChanged: (value) {
                            if (value != null) {
                              isAgree.value = value;
                            }
                          },
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${context.loc.i_agree_to_the} ',
                                  style: context.bodyMedium,
                                ),
                                TextSpan(
                                  text: '${context.loc.termsConditions} ',
                                  style: context.titleSmall,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppRouter.route.pushNamed(RoutePath.termsOfCondition);
                                    },
                                ),
                                TextSpan(text: '${context.loc.and} ', style: context.bodyMedium),
                                TextSpan(
                                  text: context.loc.privacyPolicy,
                                  style: context.titleSmall,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppRouter.route.pushNamed(RoutePath.privacyPolicy);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(child: Container(height: 1, color: AppColors.brandHoverColor)),
                    Text(context.loc.or, style: context.titleSmall),
                    Expanded(child: Container(height: 1, color: AppColors.brandHoverColor)),
                  ],
                ),
                Row(
                  children: [
                    Text(context.loc.alreadyHaveAnAccount),
                    TextButton(
                      onPressed: () {
                        AppRouter.route.goNamed(RoutePath.loginScreen);
                      },
                      child: Text(context.loc.signIn),
                    ),
                  ],
                ),
                CustomButton(
                  text: context.loc.continueText,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      AppRouter.route.pushNamed(
                        RoutePath.signUpOtpScreen,
                        extra: {"isUser": widget.isUser, "email": email.text},
                      );
                    }
                  },
                ),
                /*BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    try{
                      if (state is SignUpState) {
                        if (state.message != null) {
                          AppToast.show(context: context, message: state.message);
                        }
                        if (state.isVerified) {
                          AppRouter.route.pushNamed(RoutePath.signUpOtpScreen, extra: email.text);
                        }
                      }
                    }catch(_){}
                  },
                  builder: (context, state) {
                    final loading = state is SignUpState && state.isLoading;
                    return CustomButton(
                      text: AppLocalizations.of(context)!.continueText,
                      isLoading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUpEvent(
                              name: name.text,
                              email: email.text,
                              password: password.text,
                              confirmPassword: confirmPassword.text,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),*/
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
