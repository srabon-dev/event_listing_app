import 'package:shared_preferences/shared_preferences.dart';
import 'package:event_listing_app/app_export.dart';

class LocalService implements ILocalService {
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  @override
  Future<String> getToken() async {
    final prefs = await _prefs;
    return prefs.getString(LocalKeys.token) ?? "";
  }

  @override
  Future<String> getRole() async {
    final prefs = await _prefs;
    return prefs.getString(LocalKeys.role) ?? "";
  }

  @override
  Future<String> getRefreshToken() async {
    final prefs = await _prefs;
    return prefs.getString(LocalKeys.refreshToken) ?? "";
  }

  @override
  Future<String> getUserId() async {
    final prefs = await _prefs;
    return prefs.getString(LocalKeys.userId) ?? "";
  }

  @override
  Future<bool> isViewOnboarding() async {
    final prefs = await _prefs;
    return prefs.getBool(LocalKeys.onboarding) ?? false;
  }

  @override
  Future<String> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(LocalKeys.language) ?? "";
  }

  @override
  Future<bool> saveUserdata({
    required String token,
    required String refreshToken,
    required String id,
    required String role,
  }) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setString(LocalKeys.token, token) &&
          await prefs.setString(LocalKeys.refreshToken, refreshToken) &&
          await prefs.setString(LocalKeys.userId, id) &&
          await prefs.setString(LocalKeys.role, role);

      if (!success) AppLogger.log("Failed to save user data", type: AppLogType.error);
      return success;
    } catch (e, stack) {
      AppLogger.log("Error saving user data: $e\n$stack", type: AppLogType.error);
      return false;
    }
  }

  @override
  Future<bool> saveToken({required String token}) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setString(LocalKeys.token, token);
      if (!success) AppLogger.log("Failed to save token", type: AppLogType.error);
      return success;
    } catch (e, stack) {
      AppLogger.log("Error saving token: $e\n$stack", type: AppLogType.error);
      return false;
    }
  }

  @override
  Future<bool> viewOnboarding({required bool isView}) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setBool(LocalKeys.onboarding, isView);
      if (!success) AppLogger.log("Failed to save onboarding status", type: AppLogType.error);
      return success;
    } catch (e, stack) {
      AppLogger.log("Error saving onboarding status: $e\n$stack", type: AppLogType.error);
      return false;
    }
  }

  @override
  Future<bool> saveLanguage({required String value}) async {
    try {
      final prefs = await _prefs;
      final success = await prefs.setString(LocalKeys.language, value);
      if (!success) AppLogger.log("Failed to save language", type: AppLogType.error);
      return success;
    } catch (e, stack) {
      AppLogger.log("Error saving language: $e\n$stack", type: AppLogType.error);
      return false;
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      final prefs = await _prefs;
      final lang = prefs.getString(LocalKeys.language) ?? "";
      final cleared = await prefs.clear();

      if (!cleared) {
        AppLogger.log("Logout failed", type: AppLogType.error);
        return false;
      }

      final langSaved = await prefs.setString(LocalKeys.language, lang);
      if (!langSaved) AppLogger.log("Language not restored after logout", type: AppLogType.warning);

      AppRouter.route.goNamed(RoutePath.loginScreen);
      AppLogger.log("User logged out successfully", type: AppLogType.success);
      return true;
    } catch (e, stack) {
      AppLogger.log("Logout error: $e\n$stack", type: AppLogType.error);
      return false;
    }
  }
}
