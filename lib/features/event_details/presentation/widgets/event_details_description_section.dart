import 'package:event_listing_app/app_export.dart';

class EventDetailsDescriptionSection extends StatelessWidget {
  const EventDetailsDescriptionSection({super.key});

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
          child: Text(text, style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }

  final text =
      """This 3-day intensive camp is designed for serious players looking to sharpen their skills under professional coaching. Each day includes technical drills, tactical sessions, and small-sided games. Goalkeepers receive specialized training. Lunch and water provided.
 Day 1 – June 15: Skill Development
9:00 AM – Warm-up & Ball Control
10:30 AM – Passing & Movement Drills
12:00 PM – Lunch
1:00 PM – Small-Sided Games
3:00 PM – Review & Q&A

Day 2 – June 16: Tactical Play
(same format)

Day 3 – June 17: Scrimmage & Evaluation
(same format)

→ Default: First day expanded, others collapsed
→ Chevron icon (▶️/▼) on right
→ Font: Inter Medium for title, Regular for details""";
}
