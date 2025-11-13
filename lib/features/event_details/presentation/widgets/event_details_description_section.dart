import 'package:event_listing_app/app_export.dart';

class EventDetailsDescriptionSection extends StatelessWidget {
  const EventDetailsDescriptionSection({super.key, required this.data});
  final EventDetailsEntity data;

  @override
  Widget build(BuildContext context) {
    return data.description != null && data.description!.isNotEmpty? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.loc.eventDetails,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.skyLight),
          ),
          child: Text(data.description ?? "", style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400)),
        ),
      ],
    ) : const SizedBox();
  }
}
