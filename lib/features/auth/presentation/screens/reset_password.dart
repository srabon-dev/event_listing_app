import '../../../../app_export.dart';
import '../widgets/auth_reset_ui_widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.resetPassword),
        titleTextStyle: context.titleMedium,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthResetUiWidget(
                  password: password,
                  confirmPassword: confirmPassword,
                ),
                const Gap(24),
                CustomButton(
                  text: context.loc.continues,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      AppRouter.route.goNamed(RoutePath.loginScreen);
                    }
                  },
                ),
                /*BlocConsumer<AuthBloc, AuthState>(
                  listener: (_, state) {
                    try{
                      if (state is ResetPasswordState) {
                        if (state.message != null) {
                          AppToast.show(context: context, message: state.message);
                        }
                        print("state.isVerified : ${state.isVerified}");
                        if (state.isVerified) {
                          AppRouter.route.goNamed(RoutePath.loginScreen);
                        }
                      }
                    }catch(_){}
                  },
                  builder: (context, state) {
                    final loading = state is ResetPasswordState ? state.isLoading : false;
                    return CustomButton(
                      text: AppLocalizations.of(context)!.updatePassword,
                      isLoading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            ResetPasswordEvent(email: widget.email, password: password.text, confirmPassword: confirmPassword.text),
                          );
                        }
                      },
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
