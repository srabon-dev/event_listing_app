import 'package:event_listing_app/app_export.dart';

class LocalizationHelper extends ILocalizationHelper{

  @override
  String getLocalizedText(String Function(AppLocalizations) selector, String fallback) {
    try {
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null) {
        final loc = AppLocalizations.of(context);
        if (loc != null) {
          return selector(loc);
        }
      }
      return fallback;
    } catch (_) {
      return fallback;
    }
  }
}