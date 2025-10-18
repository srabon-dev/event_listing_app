import 'package:event_listing_app/app_export.dart';

class EventDetailsTopSectionWidget extends StatelessWidget {
  const EventDetailsTopSectionWidget({super.key, required this.data});
  final Map<String, String> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomNetworkImage(
          height: 200,
          width: context.width,
          imageUrl: data['imageUrl'] ?? "",
          borderRadius: BorderRadius.circular(8),
        ),
        Text(
          data['title'] ?? context.loc.unknown,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(data['subTitle'] ?? context.loc.unknown, style: context.bodyMedium),
        ElevatedButton(
          onPressed: () {},
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.skyLight),
            elevation: WidgetStatePropertyAll(0),
          ),
          child: Text(
            data["status"] ?? context.loc.unknown,
            style: context.titleSmall.copyWith(color: AppColors.skyMedium, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
