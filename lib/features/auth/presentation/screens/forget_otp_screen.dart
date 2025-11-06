import '../../../../app_export.dart';

class ForgetOtpScreen extends StatefulWidget {
  const ForgetOtpScreen({super.key, required this.email});
  final String email;

  @override
  State<ForgetOtpScreen> createState() => _ForgetOtpScreenState();
}

class _ForgetOtpScreenState extends State<ForgetOtpScreen> {
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
                  text: context.loc.checkYourEmail,
                  style: context.headlineMedium,
                ),
                const Gap(5),
                CustomAlignText(
                  text: context.loc.enterThe6DigitCode,
                  maxLine: 3,
                  style: context.bodyMedium,
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
                              ResendOTPEvent(email: widget.email, url: ApiUrls.forgetOtpResend()),
                            );
                          },
                          child: loading? const LoadingWidget(): Text(context.loc.resendEmail),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(24),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (_, state) {
                    try{
                      if (state is ForgetOtpState) {
                        if (state.message != null) {
                          AppToast.success(context: context, message: state.message);
                        }
                        if (state.isVerified) {
                          AppRouter.route.pushNamed(RoutePath.resetPassword, extra: widget.email);
                        }
                      }
                    }catch(_){}
                  },
                  builder: (context, state) {
                    final loading = state is ForgetOtpState ? state.isLoading : false;
                    return CustomButton(
                      text: context.loc.verifyCode,
                      isLoading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            ForgetOTPEvent(email: widget.email, otp: otp.text),
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
