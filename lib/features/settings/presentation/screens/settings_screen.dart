import '../../../../app_export.dart';
import '../widgets/settings_row.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.accountSettings, style: context.titleMedium)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          spacing: 12,
          children: [
            SettingsRow(
              name: context.loc.changePassword,
              icon: Assets.icons.lock,
              onTap: () {
                AppRouter.route.pushNamed(RoutePath.changePasswordScreen);
              },
            ),
            SettingsRow(
              name: AppLocalizations.of(context)!.delete_account,
              icon: Assets.icons.delete,
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder:
                      (
                        BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return Center(
                          child: Dialog(
                            insetPadding: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 16,
                            child: const IntrinsicHeight(
                              child: IntrinsicWidth(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                                  child: DeleteAccountUIWidget(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutBack,
                      reverseCurve: Curves.easeInCubic,
                    );
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: curvedAnimation, child: child),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteAccountUIWidget extends StatefulWidget {
  const DeleteAccountUIWidget({super.key});

  @override
  State<DeleteAccountUIWidget> createState() => _DeleteAccountUIWidgetState();
}

class _DeleteAccountUIWidgetState extends State<DeleteAccountUIWidget> {
  final password = TextEditingController(text: kDebugMode ? "123456" : "");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.loc.delete_account,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
            child: Text(
              context.loc.are_you_sure_you_want_delete_account,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          CustomTextField(
            title: context.loc.password,
            hintText: context.loc.enterYourPassword,
            keyboardType: TextInputType.text,
            controller: password,
            isPassword: true,
            validator: TextFieldValidator.password(context),
          ),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.white),
                    foregroundColor: WidgetStatePropertyAll(AppColors.black),
                  ),
                  onPressed: () async {
                    try {
                      if(_formKey.currentState!.validate()){
                        final dbHelper = sl<ILocalService>();
                        context.read<NavigationCubit>().changeIndex(index: 0);
                        await dbHelper.logOut();

                        if (context.mounted && Navigator.canPop(context)) {
                          AppRouter.route.pop();
                        }
                      }
                    } catch (_) {

                    }
                  },
                  child: Text(context.loc.yes),
                ),
              ),
              const Gap(24),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    AppRouter.route.pop();
                  },
                  child: Text(context.loc.no),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
