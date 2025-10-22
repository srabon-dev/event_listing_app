import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../app_export.dart';

class SplashCubit extends Cubit<void> {
  final ILocalService db;

  SplashCubit(this.db) : super(null);

  Future<void> checkAuthStatus() async {
    final String token = await db.getToken();

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
