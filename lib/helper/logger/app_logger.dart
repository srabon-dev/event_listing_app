import 'package:event_listing_app/app_export.dart';

class AppLogger {
  AppLogger._();

  static void log(dynamic message, {AppLogType type = AppLogType.defaultLog}) {
    final String prefix;

    switch (type) {
      case AppLogType.error:
        prefix = '[❌ ERROR]';
        break;
      case AppLogType.success:
        prefix = '[✅ SUCCESS]';
        break;
      case AppLogType.warning:
        prefix = '[⚠️ WARNING]';
        break;
      case AppLogType.defaultLog:
        prefix = '[ℹ️ LOG]';
    }

    final format = 'yyyy-MM-dd HH:MM:ss';
    final formattedTime = DateConverter.formatDate(format: format);

    if (kDebugMode) {
      print('$prefix [$formattedTime] $message');
    }
  }
}
