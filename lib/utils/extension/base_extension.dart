import 'package:event_listing_app/app_export.dart';

extension BasePathExtensions on String {
  String get addBasePath {
    return RoutePath.basePath + this;
  }
}

extension ContextExtensions on BuildContext {
  // ----------------- THEME & COLORS -----------------
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Color get primaryTextColor => isDarkMode ? AppColorsDark.primaryText : AppColors.primaryText;
  Color get secondaryTextColor => isDarkMode ? AppColorsDark.secondaryText : AppColors.secondaryText;
  Color get backgroundColor => isDarkMode ? AppColorsDark.backgroundColor : AppColors.backgroundColor;
  Color get brandHoverColor => isDarkMode ? AppColorsDark.brandHoverColor : AppColors.brandHoverColor;
  Color get softBrandColor => isDarkMode ? AppColorsDark.softBrandColor : AppColors.softBrandColor;
  Color get successColor => isDarkMode ? AppColorsDark.successColor : AppColors.successColor;
  Color get errorColor => isDarkMode ? AppColorsDark.errorColor : AppColors.errorColor;

  // ----------------- MEDIA QUERY -----------------
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // ----------------- LOCALIZATION -----------------
  AppLocalizations get loc => AppLocalizations.of(this)!;

  // ----------------- TEXT THEME -----------------
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get headlineLarge => textTheme.headlineLarge!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;
  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;
  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;
}