import '../../../app_export.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  final IApiClient apiClient;
  final ILocalService db;

  AboutUsCubit({required this.apiClient, required this.db}) : super(const OtherAboutState(status: ApiStatus.loading, description: "")) {
    getAbout();
  }

  Future<void> getAbout() async{
    try{
      emit(const OtherAboutState(status: ApiStatus.loading, description: ''));
      final token = await db.getToken();
      final response = await apiClient.get(token: token, url: ApiUrls.about());

      response.fold((failure){
        emit(OtherAboutState(status: ApiStatus.error, description: failure.message));
      }, (success){
        emit(OtherAboutState(status: ApiStatus.completed, description: success.data?["data"]?["description"] ?? ""));
      });
    }catch(e){
      emit(const OtherAboutState(status: ApiStatus.error, description: ''));
    }
  }
}
