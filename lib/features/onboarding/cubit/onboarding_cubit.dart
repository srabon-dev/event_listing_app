import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../app_export.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState>{
  final ILocalService db;
  OnboardingCubit(this.db) : super(OnboardingInitial(0));

  int _currentIndex = 0;
  final int totalPages = 6;


  int get currentIndex => _currentIndex;

  void changeIndex({bool isNext = false}) {
    if (isNext) {
      if (_currentIndex < totalPages - 1) {
        _currentIndex++;
        emit(ChangeIndexState(_currentIndex));
      } else {
        _checkAuthStatus();
      }
    } else {
      if (_currentIndex > 0) {
        _currentIndex--;
        emit(ChangeIndexState(_currentIndex));
      } else {
        _checkAuthStatus();
      }
    }
  }

  Future<void> skip() async => _checkAuthStatus();

  Future<void> _checkAuthStatus() async {
    // await db.viewOnboarding(isView: true);

    final token = await db.getToken();

    if (token.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      bool hasExpired = JwtDecoder.isExpired(token);

      if(decodedToken["role"] != null && decodedToken["role"].isNotEmpty && !hasExpired){

      }else{
        AppRouter.route.goNamed(RoutePath.loginScreen);
      }
    } else {
      AppRouter.route.goNamed(RoutePath.loginScreen);
    }
  }
}
