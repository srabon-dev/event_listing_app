/*
import '../../../app_export.dart';
import '../domain/interface/i_profile_edit_repository.dart';

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

  Future<void> changeRv({required String rvId}) async {
    try {
      if (rvId.isEmpty) return;

      emit(const ProfileUpdate(isLoading: true));
      final token = await db.getToken();

      final result = await repository.changeRv(token: token, url: ApiUrls.rvChange(), rvId: rvId);

      result.fold((failure) {
        emit(ProfileUpdate(message: failure.message));
      }, (profile) async {
        emit(const ProfileUpdate(isVerified: true, isLoading: false));
      },
      );
    } catch (e) {
      emit(ProfileUpdate(message: e.toString(), isLoading: false));
    }
  }

  Future<void> deleteRv({required String rvId}) async {
    try {
      if (rvId.isEmpty) return;

      emit(const ProfileUpdate(isLoading: true));
      final token = await db.getToken();

      final result = await repository.deleteRv(token: token, url: ApiUrls.rvDelete(rvId: rvId));

      result.fold((failure) {
        emit(ProfileUpdate(message: failure.message));
      }, (profile) async {
        emit(const ProfileUpdate(isVerified: true, isLoading: false));
      },
      );
    } catch (e) {
      emit(ProfileUpdate(message: e.toString(), isLoading: false));
    }
  }


}
*/
