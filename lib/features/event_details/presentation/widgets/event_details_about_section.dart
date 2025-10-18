import 'package:event_listing_app/app_export.dart';

class EventDetailsAboutSection extends StatelessWidget {
  const EventDetailsAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          context.loc.aboutTheEvent,
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
              buildAboutCard(
                context: context,
                image: Assets.icons.event,
                title: context.loc.registration_deadline,
                value: "15 May 2020 8:00 am",
              ),
              buildAboutCard(
                context: context,
                image: Assets.icons.age,
                title: context.loc.ages,
                value: "10–14",
              ),
              buildAboutCard(
                context: context,
                image: Assets.icons.basketball,
                title: context.loc.sport,
                value: "Basketball",
              ),
              buildAboutCard(
                context: context,
                image: Assets.icons.slot,
                title: context.loc.available_slot,
                value: "100",
              ),
              buildAboutCard(
                context: context,
                image: Assets.icons.tournament,
                title: context.loc.eventType,
                value: "Tournament",
              ),
              buildAboutCard(
                context: context,
                image: Assets.icons.event,
                title: context.loc.eventStartOn,
                value: "18 May 2020 8:00 am",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildAboutCard({
    required BuildContext context,
    required SvgGenImage image,
    required String title,
    required String value,
  }) {
    return Row(
      spacing: 8,
      children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(color: AppColors.softBrandColor, shape: BoxShape.circle),
          child: image.svg(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
            Text(value, style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }
}
