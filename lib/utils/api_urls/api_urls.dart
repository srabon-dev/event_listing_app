import 'package:event_listing_app/app_export.dart';

class ApiUrls {
  static const base = AppConfig.baseURL;

  static String login() => '$base/auth/login';
  static String signUp() => '$base/auth/register';
  static String signUpOtp() => '$base/auth/verify-email';
  static String signUpOtpResend() => '$base/auth/resend-verification-code';
  static String forget() => '$base/auth/forgot-password';
  static String forgetOtpResend() => '$base/auth/resend-password-reset-code';
  static String forgetOtpVerify() => '$base/auth/verify-reset-code';
  static String resetPassword() => '$base/auth/reset-password';

  static String deleteAccount() => '$base/user/delete-account';
  static String changePassword() => '$base/user/change-password';
  static String getProfile() => '$base/user/profile';
  static String editProfile() => '$base/user/update-profile';
  static String refreshToken() => '$base/auth/refresh-token';

  static String privacy() => '$base/manage/get-privacy-policy';
  static String terms() => '$base/manage/get-terms-conditions';
  static String about() => '$base/manage/get-about-us';
}
