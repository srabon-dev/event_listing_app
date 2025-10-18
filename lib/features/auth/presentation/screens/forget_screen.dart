import '../../../../app_export.dart';
import '../widgets/auth_forget_ui_widget.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final email = TextEditingController(text: kDebugMode? "user@gmail.com": null);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.forgotPasswordOnly),
        titleTextStyle: context.titleMedium,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthForgetUiWidget(
                  email: email,
                ),
                const Gap(24),
                CustomButton(
                  text: context.loc.continues,
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                      AppRouter.route.pushNamed(RoutePath.forgetOtpScreen, extra: email.text);
                    }
                  },
                ),
                /*BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ForgetState) {
                      if (state.message != null) {
                        AppToast.show(context: context, message: state.message);
                      }
                      if (state.isVerified) {
                        AppRouter.route.pushNamed(RoutePath.forgetOtpScreen, extra: email.text);
                      }
                    }
                  },
                  builder: (context, state) {
                    final data = state is ForgetState && state.isLoading;
                    return CustomButton(
                      text: AppLocalizations.of(context)!.resetPassword,
                      isLoading: data,
                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          context.read<AuthBloc>().add(
                            ForgetEvent(email: email.text.trim()),
                          );
                        }
                      },
                    );
                  },
                ),*/
                const Gap(44),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
