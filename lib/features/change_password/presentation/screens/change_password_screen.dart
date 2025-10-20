import '../../../../app_export.dart';
import '../widgets/change_password_inputs_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.loc.changePassword,
            style: context.titleMedium,
          ),
        ),
        body: BlocProvider(
          create:
              (context) => ChangePasswordBloc(
                db: sl<ILocalService>(),
                repository: ChangePasswordRepository(apiClient: sl<IApiClient>()),
              ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 12,
                children: [
                  ChangePasswordInputsWidget(
                    currentPassword: currentPassword,
                    newPassword: newPassword,
                    confirmNewPassword: confirmNewPassword,
                  ),
                  const Gap(12),
                  BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                    listener: (context, state) async {
                      try {
                        if (state is ChangePasswordAddNewState) {
                          if (state.message != null) {
                            AppToast.success(context: context, message: state.message);
                          }
                          if (state.isVerified) {
                            context.read<ChangePasswordBloc>().db.logOut();
                          }
                        }
                      } catch (_) {
                        if (context.mounted) {
                          AppToast.error(
                            context: context,
                            message: context.loc.somethingWentWrong,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      final loading = state is ChangePasswordAddNewState ? state.isLoading : false;
                      return CustomButton(
                        text: context.loc.continues,
                        isLoading: loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            /*context.read<ChangePasswordBloc>().add(
                              ChangePasswordAddNewEvent(
                                oldPassword: currentPassword.text,
                                newPassword: newPassword.text,
                                confirmPassword: confirmNewPassword.text,
                              ),
                            );*/
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
