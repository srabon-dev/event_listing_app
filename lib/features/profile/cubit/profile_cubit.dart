import 'package:event_listing_app/app_export.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ILocalService db;
  final IProfileRepository repository;

  ProfileCubit({required this.repository, required this.db}) : super(const ProfileLoaded(data: {}));

  Future<void> fetchProfile() async {
    try {

      // final token = await db.getToken();

      final result = await Future.delayed(const Duration(seconds: 1));
      // final result = await repository.getProfile(token: token, url: ApiUrls.getProfile());

      /*result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(data: profile)),
      );*/
      emit(const ProfileLoaded(data: {
        "name": "SRABON DEV",
        "profileImage": "https://picsum.photos/450/300"
      }));
    } catch (e) {
      emit(const ProfileLoaded(data: {}));
    }
  }
}
