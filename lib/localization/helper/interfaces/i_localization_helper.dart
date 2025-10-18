import '../../gen_l10n/app_localizations.dart';

abstract class ILocalizationHelper{
  String getLocalizedText(String Function(AppLocalizations) selector, String fallback);
}