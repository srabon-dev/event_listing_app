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

  static String category() => '$base/category/all-categories';
  static String eventAdd() => '$base/event/create';
  static String eventEdit({required String id}) => '$base/event/update/$id';
  static String getEventDetails({required String id}) => '$base/event/get-single/$id';
  static String deleteEvent({required String id}) => '$base/event/delete/$id';
  static String getMyEvents({String? status, required int page}) {
    final buffer = StringBuffer('$base/event/my-events?page=$page&limit=10');

    if (status != null && status.isNotEmpty) {
      buffer.write('&status=$status');
    }

    return buffer.toString();
  }
  static String getAllEvents({String? status, required int page}) {
    final buffer = StringBuffer('$base/event/get-all?page=$page&limit=10');

    if (status != null && status.isNotEmpty) {
      buffer.write('&status=$status');
    }

    return buffer.toString();
  }

  static String getFavoriteEvents({String? status, required int page}) {
    final buffer = StringBuffer('$base/bookmark/my-bookmarks?page=$page&limit=10');

    if (status != null && status.isNotEmpty) {
      buffer.write('&eventStatus=$status');
    }

    return buffer.toString();
  }

  static String toggleBookmark({required String id}) => "$base/bookmark/add-delete-bookmark/$id";
  static String addRating() => "$base/rating/add-rating";

  static String getAllSearchEvents({
    required int page,
    String? status,
    String? searchTerm,
    String? sport,
    String? eventType,
    int? minAge,
    int? maxAge,
    String? skillLevel,
    String? zipCode,
  }) {
    final buffer = StringBuffer('$base/event/get-all?page=$page');

    void appendParam(String key, String? value) {
      if (value != null && value.isNotEmpty) {
        buffer.write('&$key=$value');
      }
    }

    appendParam('status', status);
    appendParam('searchTerm', searchTerm);
    appendParam('sport', sport);
    appendParam('eventType', eventType);
    appendParam('minAge', minAge.toString());
    appendParam('maxAge', maxAge.toString());
    appendParam('skillLevel', skillLevel);
    appendParam('zipCode', zipCode);

    return buffer.toString();
  }

  static String getNotifications({required int page}) => '$base/notification/get-notifications?page=$page&limit=10';
  static String deleteNotification({required String id}) => '$base/notification/delete-notification/$id';

  static String privacy() => '$base/manage/get-privacy-policy';
  static String terms() => '$base/manage/get-terms-conditions';
  static String about() => '$base/manage/get-about-us';
  static String faq() => '$base/manage/get-faq';
}
