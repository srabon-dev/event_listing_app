import '../../../../app_export.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_row_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
            const SliverToBoxAdapter(
              child: ProfileAppBar(),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileRowCard(name: context.loc.myProfile, icon: Assets.icons.myProfile),
                  ProfileRowCard(name: context.loc.accountSettings, icon: Assets.icons.settings),
                  ProfileRowCard(name: context.loc.mySubscription, icon: Assets.icons.premium),
                  ProfileRowCard(
                    name: context.loc.notification,
                    icon: Assets.icons.profileNotification,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      context.loc.more,
                      style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  ProfileRowCard(name: context.loc.termsConditions, icon: Assets.icons.terms),
                  ProfileRowCard(name: context.loc.privacyPolicy, icon: Assets.icons.privacy),
                  ProfileRowCard(name: context.loc.helpSupport, icon: Assets.icons.info),
                  ProfileRowCard(name: context.loc.myProfile, icon: Assets.icons.logout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
