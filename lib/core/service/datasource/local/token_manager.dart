import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../app_export.dart';

class TokenManager extends ITokenManager{
  final ILocalService dbHelper;
  final ITokenRepository tokenRepository;

  TokenManager({required this.dbHelper, required this.tokenRepository});

  @override
  Future<String?> getValidAccessToken() async {
    try {
      final token = await dbHelper.getToken();

      if (token.isEmpty || JwtDecoder.isExpired(token)) {
        final refreshToken = await dbHelper.getRefreshToken();

        if (refreshToken.isEmpty) {
          return null;
        }

        final result = await tokenRepository.refreshToken(
          refreshToken: refreshToken,
          url: ApiUrls.refreshToken(),
        );

        return await result.fold((failure) async {
            return null;
          }, (success) async {
          final newAccessToken = success.data?.accessToken;

          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            await dbHelper.saveToken(token: newAccessToken);
            return newAccessToken;
          } else {
            return null;
          }
        },
        );
      }
      return token;
    } catch (_) {
      return null;
    }
  }
}
