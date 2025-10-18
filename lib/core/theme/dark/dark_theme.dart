import '../../../app_export.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColorsDark.backgroundColor,
  fontFamily: FontFamily.clashDisplay,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColorsDark.backgroundColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColorsDark.brandHoverColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsDark.brandHoverColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(186, 48),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontFamily: FontFamily.clashDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColorsDark.brandHoverColor, width: 1.5),
      foregroundColor: Colors.white,
      minimumSize: const Size(186, 48),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontFamily: FontFamily.clashDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColorsDark.primaryText,
      textStyle: const TextStyle(
        fontFamily: FontFamily.clashDisplay,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        decoration: TextDecoration.underline,
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColorsDark.brandHoverColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsDark.softBrandColor,
    iconColor: AppColorsDark.brandHoverColor,
    prefixIconColor: AppColorsDark.brandHoverColor,
    suffixIconColor: AppColorsDark.brandHoverColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
          color: Colors.transparent
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 2,
        color: AppColorsDark.errorColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 2,
        color: AppColorsDark.errorColor,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.transparent
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.transparent, width: 1.5),
    ),
    hintStyle: const TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.secondaryText,
    ),
    errorStyle: const TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColorsDark.errorColor,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColorsDark.primaryText,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.secondaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.secondaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.secondaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.primaryText,
    ),
    labelMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.primaryText,
    ),
    labelSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColorsDark.primaryText,
    ),
  ),
);
