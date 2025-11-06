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
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (_, state) {
                        try{
                          if (state is ResendOTPState) {
                            if (state.message != null) {
                              AppToast.success(context: context, message: state.message);
                            }
                          }
                        }catch(_){}
                      },
                      builder: (context, state) {
                        final loading = state is ResendOTPState ? state.isLoading : false;
                        return TextButton(
                          onPressed: (){
                            context.read<AuthBloc>().add(
                              ResendOTPEvent(email: widget.email, url: ApiUrls.signUpOtpResend()),
                            );
                          },
                          child: loading? const LoadingWidget(): Text(context.loc.resendEmail),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(12),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignUpOtpState) {
                      if (state.message != null) {
                        AppToast.info(context: context, message: state.message ?? "");
                      }
                      if (state.isVerified) {
                        AppLogger.log(state.isVerified);
                        AppLogger.log(state.authEntity?.isSuccess);
                        AppLogger.log(state.authEntity?.isUser);
                        AppLogger.log(state.authEntity?.isOrganizer);
                        if(state.authEntity?.isSuccess == true){
                          if(state.authEntity?.isUser == true){
                            AppRouter.route.goNamed(RoutePath.onboardingScreen, extra: true);
                          } else if(state.authEntity?.isOrganizer == true){
                            AppRouter.route.goNamed(RoutePath.onboardingScreen, extra: false);
                          }
                        }
                      }
                    }
                  },
                  builder: (context, state) {
                    final loading = state is SignUpOtpState ? state.isLoading : false;
                    return CustomButton(
                      text: context.loc.verifyCode,
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
                ),
                const Gap(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
