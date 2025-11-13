import 'package:event_listing_app/app_export.dart';

class EventDetailsLocationSection extends StatelessWidget {
  const EventDetailsLocationSection({super.key, required this.data});
  final EventDetailsEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.loc.eventLocation,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.skyLight),
          ),
          child: Column(
            spacing: 12,
            children: [
              Row(
                spacing: 8,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: AppColors.softBrandColor,
                      shape: BoxShape.circle,
                    ),
                    child: Assets.icons.location.svg(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.location,
                          style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Los Angeles, CA – Griffith Park Fields",
                          maxLines: 2,
                          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                width: context.width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.skyLight),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Center(child: Text("Google Map")),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
