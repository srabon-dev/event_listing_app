import '../../../app_export.dart';
part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  final IApiClient apiClient;
  final ILocalService db;

  TermsCubit({required this.apiClient, required this.db}) : super(const OtherTermsState(status: ApiStatus.loading, description: "")) {
    getTerms();
  }

  Future<void> getTerms() async{
    try{
      emit(const OtherTermsState(status: ApiStatus.loading, description: ''));
      final token = await db.getToken();
      final response = await apiClient.get(token: token, url: ApiUrls.terms());

      response.fold((failure){
        emit(OtherTermsState(status: ApiStatus.error, description: failure.message));
      }, (success){
        emit(OtherTermsState(status: ApiStatus.completed, description: success.data?["data"]?["description"] ?? ""));
      });
    }catch(e){
      emit(const OtherTermsState(status: ApiStatus.error, description: ''));
    }
  }
}