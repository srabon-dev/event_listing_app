import 'package:event_listing_app/app_export.dart';

class AppToast {

  static void _show({
    BuildContext? context,
    String? message,
    AppToastType type = AppToastType.info,
    SnackBarBehavior? position,
    Color? textColor,
    Color? backgroundColor,
  }) {
    final effectiveContext = context ?? AppRouter.navigatorKey.currentContext;
    if (effectiveContext == null) return;

    final messenger = ScaffoldMessenger.maybeOf(effectiveContext);
    if (messenger == null) return;

    final displayMessage = (message?.trim().isEmpty ?? true)
        ? effectiveContext.loc.somethingWentWrong
        : message!;

    final defaultBgColor = backgroundColor ??
        switch (type) {
          AppToastType.success => AppColors.successColor,
          AppToastType.error => AppColors.errorColor,
          AppToastType.warning => AppColors.black,
          AppToastType.info => AppColors.brandHoverColor,
        };

    final effectiveTextColor = textColor ?? AppColors.white;

    messenger.clearSnackBars();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!(effectiveContext as Element).mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(displayMessage, style: TextStyle(color: effectiveTextColor)),
          behavior: position ?? SnackBarBehavior.floating,
          backgroundColor: defaultBgColor,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  static void success({
    BuildContext? context,
    String? message,
  }) => _show(context: context, message: message, type: AppToastType.success);

  static void error({
    BuildContext? context,
    required String message,
  }) => _show(context: context, message: message, type: AppToastType.error);

  static void warning({
    BuildContext? context,
    required String message,
  }) => _show(context: context, message: message, type: AppToastType.warning);

  static void info({
    BuildContext? context,
    required String message,
  }) => _show(context: context, message: message, type: AppToastType.info);
}
