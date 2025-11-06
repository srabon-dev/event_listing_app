import 'package:event_listing_app/app_export.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ILocalService db;
  final IProfileRepository repository;

  ProfileCubit({required this.repository, required this.db}) : super(ProfileLoading());

  Future<void> fetchProfile() async {
    try {

      final token = await db.getToken();
      final result = await repository.getProfile(token: token, url: ApiUrls.getProfile());

      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(data: profile)),
      );
    } catch (e) {
      emit(const ProfileError(message: ""));
    }
  }
}
