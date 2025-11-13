import 'package:event_listing_app/app_export.dart';

class EventDetailsTopSectionWidget extends StatelessWidget {
  const EventDetailsTopSectionWidget({super.key, required this.data});
  final EventDetailsEntity data;

  @override
  Widget build(BuildContext context) {
    final cleanStatus = data.status?.replaceAll('_', ' ') ?? context.loc.unknown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomNetworkImage(
          height: 200,
          width: context.width,
          imageUrl: data.image,
          borderRadius: BorderRadius.circular(8),
        ),
        Text(
          data.name,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(data.shortDescription ?? context.loc.unknown, style: context.bodyMedium),
        ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.skyLight),
            elevation: WidgetStatePropertyAll(0),
          ),
          child: Text(
            cleanStatus,
            style: context.titleSmall.copyWith(color: AppColors.skyMedium, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
