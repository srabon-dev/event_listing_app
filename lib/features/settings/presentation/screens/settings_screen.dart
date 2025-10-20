import '../../../../app_export.dart';
import '../widgets/settings_row.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.accountSettings,
          style: context.titleMedium,
        ),
      ),
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
                showCustomAnimatedDialog(
                    context: context,
                    title: context.loc.logout,
                    subtitle: context.loc.areYouSureYouWantToLogOut,
                    actionButton: [
                      Expanded(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(AppColors.white),
                            foregroundColor: WidgetStatePropertyAll(AppColors.black),
                          ),
                          onPressed: () async {
                            try{
                              final dbHelper = sl<ILocalService>();
                              await dbHelper.logOut();

                              if(context.mounted && Navigator.canPop(context)){
                                AppRouter.route.pop();
                              }
                            }catch(_){}
                          },
                          child: Text(context.loc.yes),
                        ),
                      ),
                      const Gap(24),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            AppRouter.route.pop();
                          },
                          child: Text(context.loc.no),
                        ),
                      ),
                    ]
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


