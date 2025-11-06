import '../../../app_export.dart';

part 'privacy_state.dart';

class PrivacyCubit extends Cubit<PrivacyState> {
  final IApiClient apiClient;
  final ILocalService db;

  PrivacyCubit({required this.apiClient, required this.db})
    : super(const OtherPrivacyState(status: ApiStatus.loading, description: "")) {
    getPrivacy();
  }

  Future<void> getPrivacy() async {
    try {
      emit(const OtherPrivacyState(status: ApiStatus.loading, description: ''));

      final token = await db.getToken();
      final response = await apiClient.get(token: token, url: ApiUrls.privacy());

      response.fold(
        (failure) {
          emit(OtherPrivacyState(status: ApiStatus.error, description: failure.message));
        },
        (success) {
          emit(
            OtherPrivacyState(
              status: ApiStatus.completed,
              description: success.data?["data"]?["description"] ?? "",
            ),
          );
        },
      );
    } catch (e) {
      emit(const OtherPrivacyState(status: ApiStatus.error, description: ''));
    }
  }
}
