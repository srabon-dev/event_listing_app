import '../../../../app_export.dart';

class SignUpOtpScreen extends StatefulWidget {
  const SignUpOtpScreen({super.key, required this.email, required this.isUser});
  final String email;
  final bool isUser;

  @override
  State<SignUpOtpScreen> createState() => _SignUpOtpScreenState();
}

class _SignUpOtpScreenState extends State<SignUpOtpScreen> {
  final otp = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.verifyCode),
        titleTextStyle: context.titleMedium,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomAlignText(
                  text: context.loc.six_digit_code,
                  style: context.headlineMedium,
                ),
                const Gap(5),
                CustomAlignText(
                  text: AppLocalizations.of(context)!.enter_verification_code,
                  maxLine: 3,
                  style: context.bodyLarge,
                ),
                const Gap(24),
                ///==================== PIN Put input Field =======================
                Align(
                  alignment: Alignment.center,
                  child: OtpTextField(
                    controller: otp,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      context.loc.haveNotGotTheEmailYet,
                    ),
                    TextButton(
                      onPressed: (){

                      },
                      child: Text(context.loc.resendEmail),
                    ),
                  ],
                ),
                const Gap(12),
                CustomButton(
                  text: context.loc.verifyCode,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      AppRouter.route.goNamed(RoutePath.onboardingScreen, extra: widget.isUser);
                    }
                  },
                ),
                /*BlocConsumer<AuthBloc, AuthState>(
                  listener: (_, state) {
                    try{
                      if (state is SignUpOtpState) {
                        if (state.message != null) {
                          AppToast.show(context: context, message: state.message);
                        }
                        print("state.isVerified : ${state.isVerified}");
                        if (state.isVerified) {
                          AppRouter.route.goNamed(RoutePath.rvAddScreen);
                        }
                      }
                    }catch(_){}
                  },
                  builder: (context, state) {
                    final loading = state is SignUpOtpState ? state.isLoading : false;
                    return CustomButton(
                      text: AppLocalizations.of(context)!.verifyCode,
                      isLoading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            SignUpOTPEvent(email: widget.email, otp: otp.text),
                          );
                        }
                      },
                    );
                  },
                ),*/
                const Gap(24),
                /*BlocConsumer<AuthBloc, AuthState>(
                  listener: (_, state) {
                    try{
                      if (state is ResendOTPState) {
                        if (state.message != null) {
                          AppToast.show(context: context, message: state.message);
                        }
                      }
                    }catch(_){}
                  },
                  builder: (context, state) {
                    final loading = state is ResendOTPState ? state.isLoading : false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: AppLocalizations.of(context)!.haveNotGotTheEmailYet,
                        ),
                        TextButton(
                          onPressed: (){
                            context.read<AuthBloc>().add(
                              ResendOTPEvent(email: widget.email, url: ApiUrls.signUpOtpResend()),
                            );
                          },
                          child: loading? const LoadingWidget(): Text(AppLocalizations.of(context)!.resendEmail),
                        ),
                      ],
                    );
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
