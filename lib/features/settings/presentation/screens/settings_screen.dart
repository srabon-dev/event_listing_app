import '../../../../app_export.dart';
import '../widgets/settings_row.dart';
import '../widgets/settings_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.settings,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            SettingsSection(
              title: AppLocalizations.of(context)!.accountSettings,
              children: [
                SettingsRow(
                  text: AppLocalizations.of(context)!.changePassword,
                  onTap: () {
                    AppRouter.route.pushNamed(RoutePath.changePasswordScreen);
                  },
                ),
                /*SettingsRow(
                  text: AppLocalizations.of(context)!.delete_account,
                  onTap: () {
                    showCustomAnimatedDialog(context: context,
                      title: AppLocalizations.of(context)!.delete_account,
                      subtitle: AppLocalizations.of(context)!.are_you_sure_you_want_delete_account,
                      actionButton: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){},
                            child: Text(AppLocalizations.of(context)!.yes),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (){
                              AppRouter.route.pop();
                            },
                            child: Text(AppLocalizations.of(context)!.no),
                          ),
                        ),
                      ]
                    );
                  },
                ),*/
              ],
            ),
            const Gap(24),
            SettingsSection(
              title: AppLocalizations.of(context)!.more,
              children: [
                SettingsRow(
                  text: AppLocalizations.of(context)!.aboutUs,
                  onTap: () {
                    AppRouter.route.pushNamed(RoutePath.aboutScreen);
                  },
                ),
                SettingsRow(
                  text: AppLocalizations.of(context)!.privacyPolicy,
                  onTap: () {
                    AppRouter.route.pushNamed(RoutePath.privacyPolicy);
                  },
                ),
                SettingsRow(
                  text: AppLocalizations.of(context)!.termsConditions,
                  onTap: () {
                    AppRouter.route.pushNamed(RoutePath.termsOfCondition);
                  },
                ),
              ],
            ),

            const Gap(24),
            CustomButton(
              text: AppLocalizations.of(context)!.logOut,
              onTap: (){
                showCustomAnimatedDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.logout,
                  subtitle: AppLocalizations.of(context)!.areYouSureYouWantToLogOut,
                  actionButton: [
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(AppColors.white),
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
                        child: Text(AppLocalizations.of(context)!.yes),
                      ),
                    ),
                    const Gap(24),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          AppRouter.route.pop();
                        },
                        child: Text(AppLocalizations.of(context)!.no),
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


