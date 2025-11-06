import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../app_export.dart';

class SplashCubit extends Cubit<void> {
  final ILocalService db;

  SplashCubit(this.db) : super(null);

  Future<void> checkAuthStatus() async {
    try {
      final String token = await db.getToken();

      if (token.isEmpty) {
        AppRouter.route.goNamed(RoutePath.loginScreen);
        return;
      }

      if (JwtDecoder.isExpired(token)) {
        AppRouter.route.goNamed(RoutePath.loginScreen);
        return;
      }

      Map<String, dynamic> decodedToken;
      try {
        decodedToken = JwtDecoder.decode(token);
      } catch (_) {
        AppRouter.route.goNamed(RoutePath.loginScreen);
        return;
      }

      final role = (decodedToken["role"] ?? "").toString().toLowerCase();

      switch (role) {
        case "user":
          AppRouter.route.goNamed(RoutePath.userNavigationScreen);
          break;
        case "organizer":
          AppRouter.route.goNamed(RoutePath.managementNavigationScreen);
          break;
        default:
          AppRouter.route.goNamed(RoutePath.loginScreen);
          break;
      }
    } catch (e) {
      AppRouter.route.goNamed(RoutePath.loginScreen);
    }
  }
}
