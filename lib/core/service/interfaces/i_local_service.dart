abstract class ILocalService {
  Future<String> getToken();
  Future<String> getRole();
  Future<String> getRefreshToken();
  Future<String> getUserId();
  Future<bool> isViewOnboarding();
  Future<String> getLanguage();

  Future<bool> saveUserdata({required String token, required String refreshToken, required String id, required String role});
  Future<bool> viewOnboarding({required bool isView});
  Future<bool> saveToken({required String token});
  Future<bool> saveLanguage({required String value});
  Future<bool> logOut();
}
