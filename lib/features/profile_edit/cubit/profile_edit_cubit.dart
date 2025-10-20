import '../../../app_export.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final ILocalService db;
  final IProfileEditRepository repository;

  ProfileEditCubit({required this.repository, required this.db}) : super(ProfileEditInitial());

  Future<void> updateProfile({String? name, String? imagePath, String? currentMileage}) async {
    try {
      emit(const ProfileUpdate(isLoading: true));
      final token = await db.getToken();

      final result = await repository.profileEdit(
        token: token,
        name: name,
        currentMileage: currentMileage,
        imagePath: imagePath,
        url: ApiUrls.editProfile(),
      );

      result.fold(
        (failure) {
          emit(ProfileUpdate(message: failure.message, isLoading: false));
        },
        (profile) {
          emit(const ProfileUpdate(isLoading: false, isVerified: true));
        },
      );
    } catch (e) {
      AppLogger.log("Update Profile ${e.toString()}");
      emit(ProfileUpdate(message: e.toString(), isLoading: false));
    }
  }
}
