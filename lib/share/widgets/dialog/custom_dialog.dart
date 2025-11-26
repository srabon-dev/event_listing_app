import '../../../app_export.dart';

void showCustomAnimatedDialog({
  required BuildContext context,
  bool isDismissible = true,
  String? title,
  String? subtitle,
  List<Widget>? actionButton,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder:
        (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return Center(
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 8),
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 16,
              child: IntrinsicHeight(
                child: IntrinsicWidth(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
                          child: Text(
                            subtitle ?? "",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          spacing: 12,
                          children: actionButton ?? [],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: curvedAnimation, child: child),
      );
    },
  );
}
