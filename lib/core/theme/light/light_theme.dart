import '../../../app_export.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  fontFamily: FontFamily.clashDisplay,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.brandHoverColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.brandHoverColor,
      foregroundColor: Colors.black,
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
      side: const BorderSide(color: AppColors.brandHoverColor, width: 1.5),
      foregroundColor: Colors.black,
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
      foregroundColor: AppColors.primaryText,
      textStyle: const TextStyle(
        fontFamily: FontFamily.clashDisplay,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        decoration: TextDecoration.underline,
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.brandHoverColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.softBrandColor,
    iconColor: AppColors.brandHoverColor,
    prefixIconColor: AppColors.brandHoverColor,
    suffixIconColor: AppColors.brandHoverColor,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 14,
    ),
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
        color: AppColors.errorColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 2,
        color: AppColors.errorColor,
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
      borderSide: const BorderSide(
          color: Colors.transparent
      ),
    ),
    hintStyle: const TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.secondaryText,
    ),
    errorStyle: const TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.errorColor,
    ),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    headlineMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    headlineSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    titleLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    titleMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    titleSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.primaryText,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    ),
    bodyMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    ),
    bodySmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryText,
    ),
    labelLarge: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    labelMedium: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
    labelSmall: TextStyle(
      fontFamily: FontFamily.clashDisplay,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryText,
    ),
  ),
);