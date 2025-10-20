import '../../../app_export.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final IApiClient apiClient;
  final ILocalService db;

  SupportCubit({required this.apiClient, required this.db})
    : super(
        const OtherSupportState(status: ApiStatus.loading, description: ""),
      ) {
    get();
  }

  Future<void> get() async {
    emit(const OtherSupportState(status: ApiStatus.loading, description: ''));
    await Future.delayed(const Duration(milliseconds: 800));
    emit(const OtherSupportState(
      status: ApiStatus.completed,
      description: 'Demo success response!',
    ));
  }

/*  Future<void> get() async {
    try {
      emit(const OtherSupportState(status: ApiStatus.loading, description: ''));
      final token = await db.getToken();
      final response = await apiClient.get(token: token, url: ApiUrls.terms());

      response.fold(
        (failure) {
          emit(
            OtherSupportState(
              status: ApiStatus.error,
              description: failure.message,
            ),
          );
        },
        (success) {
          emit(
            OtherSupportState(
              status: ApiStatus.completed,
              description: success.data?["data"]?["description"] ?? "",
            ),
          );
        },
      );
    } catch (e) {
      emit(const OtherSupportState(status: ApiStatus.error, description: ''));
    }
  }*/
}
