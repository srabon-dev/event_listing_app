import 'package:event_listing_app/app_export.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    profileCubit = context.read<ProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.myProfile),
        titleTextStyle: context.titleMedium,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is ProfileLoading){
            return const LoadingWidget();
          }
          if(state is ProfileError){
            return Center(child: Text(state.message),);
          }
          if (state is ProfileLoaded) {
            final image = state.data["profileImage"] ?? AppConfig.defaultProfile;
            final name = state.data["name"] ?? context.loc.unknown;

            return RefreshIndicator(
              onRefresh: () async{
                context.read<ProfileCubit>().fetchProfile();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(image)),
                      ),
                    ),
                  ),
                  const SliverGap(24),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: context.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.skyLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(context.loc.name, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                                Text(name, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: context.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.skyLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(context.loc.email_address, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                                Text(name, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: context.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.skyLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(context.loc.phone_number, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                                Text(name, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: context.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.skyLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(context.loc.location, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                                Text(name, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              AppRouter.route.pushNamed(RoutePath.profileEditScreen, extra: const ProfileEntity(
                                name: "",
                                id: "",
                                email: "",
                                role: "",
                                profileImage: "",
                                isVerified: true,
                                rvList: []
                              ));
                            },
                            child: Text(context.loc.editProfile),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
