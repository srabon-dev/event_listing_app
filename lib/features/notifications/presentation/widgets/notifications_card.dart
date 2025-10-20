import 'package:event_listing_app/app_export.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.softBrandColor,
              shape: BoxShape.circle,
            ),
            child: Assets.images.logoCircle.image(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subscription Expiring Soon", style: context.titleSmall),
                const Text(
                  "Your PlayFinderUSA subscription is about to expire. Renew now to continue enjoying unlimited access to events.",
                  maxLines: 2,
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              AppLogger.log("delete Notification Click");
            },
            child: Container(
              height: 40,
              width: 35,
              padding: const EdgeInsets.all(8),
              child: Assets.icons.cross.svg(),
            ),
          ),
        ],
      ),
    );
  }
}
