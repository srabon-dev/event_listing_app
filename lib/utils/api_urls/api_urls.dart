import 'package:event_listing_app/app_export.dart';

class ApiUrls {
  static const base = AppConfig.baseURL;

  static String login() => '$base/auth/login';
  static String signUp() => '$base/user/sign-up';
  static String signUpOtp() => '$base/user/verify-code';
  static String signUpOtpResend() => '$base/user/resend-verify-code';
  static String forget() => '$base/auth/forget-password';
  static String forgetOtpResend() => '$base/auth/resend-reset-code';
  static String forgetOtpVerify() => '$base/auth/verify-reset-otp';
  static String resetPassword() => '$base/auth/reset-password';

  static String deleteAccount() => '$base/user/delete-account';
  static String changePassword() => '$base/auth/change-password';
  static String getProfile() => '$base/user/get-my-profile';
  static String editProfile() => '$base/user/update-profile';
  static String refreshToken() => '$base/auth/refresh-token';

  static String privacy() => '$base/manage/get-privacy-policy';
  static String terms() => '$base/manage/get-terms-conditions';
  static String about() => '$base/manage/get-about-us';
  static String faq() => '$base/manage/get-faq';
}
