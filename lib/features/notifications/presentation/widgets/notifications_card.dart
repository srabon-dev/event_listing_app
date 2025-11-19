import 'package:event_listing_app/app_export.dart';

class NotificationsCard extends StatelessWidget {
  const NotificationsCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.isLoading,
  });

  final NotificationItem item;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
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
                Text(item.title ?? context.loc.unknown, style: context.titleSmall, maxLines: 2),
                Text(item.message ?? context.loc.unknown, maxLines: 3),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40,
              width: 35,
              padding: const EdgeInsets.all(8),
              child: isLoading ? const LoadingWidget() : Assets.icons.cross.svg(),
            ),
          ),
        ],
      ),
    );
  }
}
