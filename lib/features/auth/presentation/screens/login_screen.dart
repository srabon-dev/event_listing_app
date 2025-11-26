import '../../../../app_export.dart';
import '../widgets/auth_login_ui_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 44),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text(
                    context.loc.welcome_back,
                    style: context.headlineMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    context.loc.log_in_to_your_account_to_find,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  AuthLoginUiWidget(email: email, password: password),
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
                      Text(context.loc.donTHaveAnAccount),
                      TextButton(
                        onPressed: () {
                          AppRouter.route.pushNamed(RoutePath.authRolePickScreen);
                        },
                        child: Text(
                          context.loc.signUp,
                          style: const TextStyle(decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is LoginState) {
                        if (state.message != null) {
                          AppToast.info(context: context, message: state.message ?? "");
                        }
                        if (state.isVerified) {
                          if(state.authEntity?.isSuccess == true){
                            if(state.authEntity?.isUser == true){
                              AppRouter.route.goNamed(RoutePath.userNavigationScreen);
                            } else if(state.authEntity?.isOrganizer == true){
                              AppRouter.route.goNamed(RoutePath.managementNavigationScreen);
                            }
                          }
                        }
                      }
                    },
                    builder: (context, state) {
                      final data = state is LoginState && state.isLoading;
                      return CustomButton(
                        text: context.loc.log_in,
                        isLoading: data,
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(
                              LoginEvent(email: email.text.trim(), password: password.text.trim()),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
