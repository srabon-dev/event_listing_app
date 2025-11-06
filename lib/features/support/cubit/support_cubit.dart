import '../../../app_export.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final IApiClient apiClient;
  final ILocalService db;

  SupportCubit({required this.apiClient, required this.db})
    : super(
        OtherSupportState(status: ApiStatus.loading, faqModel: FaqModel()),
      ) {
    get();
  }

  Future<void> get() async {
    try {
      emit(OtherSupportState(status: ApiStatus.loading, faqModel: FaqModel(),));
      final token = await db.getToken();
      final response = await apiClient.get(token: token, url: ApiUrls.faq());

      response.fold(
        (failure) {
          emit(
            OtherSupportState(
              status: ApiStatus.error,
              faqModel: FaqModel(),
            ),
          );
        },
        (success) {
          final data = FaqModel.fromJson(success.data);

          emit(
            OtherSupportState(
              status: ApiStatus.completed,
              faqModel: data,
            ),
          );
        },
      );
    } catch (e) {
      emit(OtherSupportState(status: ApiStatus.error, faqModel: FaqModel()));
    }
  }
}
