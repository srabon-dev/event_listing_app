import 'package:event_listing_app/app_export.dart';
import 'package:event_listing_app/features/event_details/presentation/widgets/event_details_review_section.dart';

class EventDetailsDescriptionSection extends StatelessWidget {
  const EventDetailsDescriptionSection({
    super.key,
    required this.data,
    required this.isUser,
    required this.id,
    required this.controller,
  });

  final String id;
  final EventDetailsEntity data;
  final EventDetailsCubit controller;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text(
            data.description ?? "",
            style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        if (isUser && data.ratingData?.user?.id == null && ["REGISTRATION_OPEN", "EVENT_STARTED", "EVENT_FINISHED"].contains(data.status))
          EventDetailsReviewSection(data: data, id: id, controller: controller),
      ],
    );
  }
}
