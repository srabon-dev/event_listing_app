import 'package:event_listing_app/app_export.dart';

class LocalizationCubit extends Cubit<Locale> {
  final ILocalService _dbHelper;
  LocalizationCubit(this._dbHelper) : super(const Locale(AppConfig.defaultLanguageKey)) {
    loadLocale();
  }


  Future<void> loadLocale() async {
    final localeCode = await _dbHelper.getLanguage();
    if (localeCode.isNotEmpty) {
      emit(Locale(localeCode));
    } else {
      emit(const Locale(AppConfig.defaultLanguageKey));
    }
  }

  Future<void> changeLocale(Locale locale) async {
    await _dbHelper.saveLanguage(value: locale.languageCode);
    emit(locale);
  }
}
