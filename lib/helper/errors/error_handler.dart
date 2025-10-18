import 'dart:io';
import 'package:event_listing_app/app_export.dart';

class ErrorHandle extends IErrorHandler{
  final ILocalizationHelper localizationHelper;

  ErrorHandle(this.localizationHelper);

  @override
  Failure handleDioError(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode ?? 0;

      if (statusCode == 403) {
        AppLogger.log("401 Unauthorized - Clearing local session");
        sl<ILocalService>().logOut();
        AppRouter.route.goNamed(RoutePath.loginScreen);

        return Failure(message: "Session expired. Please login again.", code: 403);
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Failure(message: localizationHelper.getLocalizedText((log)=>log.connectionTimeout, 'Connection timeout'));
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          final responseData = error.response?.data;

          AppLogger.log("[DIO ERROR] Status: $statusCode | Response: $responseData");

          final message = error.response?.data?['message'] ?? localizationHelper.getLocalizedText((log)=>log.somethingWentWrong, 'Something went wrong');
          return Failure(message: message.toString(), code: statusCode);
        case DioExceptionType.cancel:
          return Failure(message: localizationHelper.getLocalizedText((log)=>log.requestWasCancelled, 'Request was cancelled'));
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return Failure(message: localizationHelper.getLocalizedText((log)=>log.noInternetConnection, 'No internet connection'));
          }
          return Failure(message: localizationHelper.getLocalizedText((log)=>log.unexpectedErrorOccurred, 'Unexpected error occurred'));
        default:
          return Failure(message: localizationHelper.getLocalizedText((log)=>log.somethingWentWrong, 'Something went wrong'));
      }
    } else if (error is SocketException) {
      return Failure(message: localizationHelper.getLocalizedText((log)=>log.noInternetConnection, 'No internet connection'));
    } else {
      return Failure(message: localizationHelper.getLocalizedText((log)=>log.unexpectedErrorOccurred, 'Unexpected error occurred'));
    }
  }
}
