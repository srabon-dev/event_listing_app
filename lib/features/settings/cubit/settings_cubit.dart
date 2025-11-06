import 'package:event_listing_app/app_export.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ILocalService db;
  final ISettingsRepository repository;

  SettingsCubit({required this.repository, required this.db}) : super(SettingsInitial());

  Future<void> delete({required String password}) async {
    try {
      emit(const SettingsUpdate(isLoading: true));
      final token = await db.getToken();

      final result = await repository.deleteAccount(
        token: token,
        password: password,
        url: ApiUrls.deleteAccount(),
      );

      result.fold(
        (failure) {
          emit(SettingsUpdate(message: failure.message, isLoading: false));
        },
        (profile) {
          emit(const SettingsUpdate(isLoading: false, isVerified: true));
        },
      );
    } catch (e) {
      emit(SettingsUpdate(message: e.toString(), isLoading: false));
    }
  }
}
