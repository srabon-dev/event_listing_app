import 'package:event_listing_app/app_export.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_top_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              context.loc.profile,
              style: context.titleLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listenWhen: (previous, current) => current is ProfileLoaded,
              listener: (context, state) {

              },
              builder: (context, state) {
                String name = context.loc.unknown;
                String image = AppConfig.defaultProfile;

                if (state is ProfileLoaded) {
                  image = state.data.profileImage.isNotEmpty?  state.data.profileImage : AppConfig.defaultProfile;
                  name = state.data.name.isNotEmpty? state.data.name : context.loc.unknown;
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(image),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: context.titleLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
