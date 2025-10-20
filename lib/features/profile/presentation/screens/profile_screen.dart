import '../../../../app_export.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_row_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.isUser = true});
  final bool isUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const ProfileAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProfileCubit>().fetchProfile();
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: ProfileAppBar()),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileRowCard(
                    name: context.loc.myProfile,
                    icon: Assets.icons.myProfile,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.myProfileScreen);
                    },
                  ),
                  ProfileRowCard(
                    name: context.loc.accountSettings,
                    icon: Assets.icons.settings,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.settingsScreen);
                    },
                  ),
                  if(widget.isUser)
                    ProfileRowCard(
                      name: context.loc.mySubscription,
                      icon: Assets.icons.premium,
                      onTap: () {
                        AppRouter.route.pushNamed(RoutePath.subscriptionScreen);
                      },
                    ),
                  ProfileRowCard(
                    name: context.loc.notification,
                    icon: Assets.icons.profileNotification,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.notificationsScreen);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      context.loc.more,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ProfileRowCard(
                    name: context.loc.termsConditions,
                    icon: Assets.icons.terms,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.termsOfCondition);
                    },
                  ),
                  ProfileRowCard(
                    name: context.loc.privacyPolicy,
                    icon: Assets.icons.privacy,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.privacyPolicy);
                    },
                  ),
                  ProfileRowCard(
                    name: context.loc.helpSupport,
                    icon: Assets.icons.info,
                    onTap: () {
                      AppRouter.route.pushNamed(RoutePath.supportScreen);
                    },
                  ),
                  ProfileRowCard(
                    name: context.loc.logout,
                    icon: Assets.icons.logout,
                    onTap: (){
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
                  const Gap(24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
