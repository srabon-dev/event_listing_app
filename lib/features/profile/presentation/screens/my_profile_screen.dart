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
            final image = state.data.profileImage.isNotEmpty?  state.data.profileImage : AppConfig.defaultProfile;
            final name = state.data.name.isNotEmpty? state.data.name : context.loc.unknown;
            final businessName = state.data.businessName;
            final email = state.data.email.isNotEmpty? state.data.email : context.loc.unknown;
            final phone = state.data.phone.isNotEmpty? state.data.phone : context.loc.unknown;
            final address = state.data.address.isNotEmpty? state.data.address : context.loc.unknown;

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
                          if(businessName.isNotEmpty)
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
                                  Text(context.loc.businessName, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                                  Text(businessName, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
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
                                Text(email, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
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
                                Text(phone, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
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
                                Text(address, style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          const Gap(12),
                          ElevatedButton(
                              onPressed: () async {
                                final role = await sl<ILocalService>().getRole();
                                final bool isUser = role.toLowerCase() == 'user';
                                final bool isOrganizer = role.toLowerCase() == 'organizer';

                                if (isUser || isOrganizer) {
                                  AppRouter.route.pushNamed(
                                    RoutePath.profileEditScreen,
                                    extra: {
                                      "data": state.data,
                                      "isUser": isUser,
                                    },
                                  );
                                }
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
