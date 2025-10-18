import 'package:event_listing_app/app_export.dart';

class EventDetailsOrganizerSection extends StatelessWidget {
  const EventDetailsOrganizerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.skyLight),
          ),
          child: Row(
            spacing: 8,
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: AppColors.softBrandColor,
                  shape: BoxShape.circle,
                ),
                child: const CustomNetworkImage(imageUrl: "https://picsum.photos/450/300"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Leslie Alexander",
                    style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Assets.icons.star.svg(),
                      Text(
                        "4.0 / 5.0",
                        style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.skyLight),
          ),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.startsForm,
                        style: context.titleMedium.copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "\$19.00",
                        style: context.titleLarge.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: AppColors.softBrandColor,
                          shape: BoxShape.circle,
                        ),
                        child: Assets.icons.bookmark.svg(),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: AppColors.softBrandColor,
                          shape: BoxShape.circle,
                        ),
                        child: Assets.icons.share.svg(),
                      ),
                    ],
                  ),
                ],
              ),
              CustomButton(text: context.loc.goToEventRegistrationLink, onTap: () {}),
              Text(
                context.loc.organizer_info,
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
              ),
              Column(
                spacing: 12,
                children: [
                  buildRowCard(
                    context: context,
                    networkImageUrl: "https://picsum.photos/450/300",
                    title: context.loc.organizedBy,
                    value: "Youth Sport Club",
                    isOrganizer: true,
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.starGray,
                    title: context.loc.ratings,
                    value: "4.9 (24)",
                    isRating: true,
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.email,
                    title: context.loc.contactEmail,
                    value: "info@youthSportclub.com",
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.call,
                    title: context.loc.contactPhone,
                    value: "+1 (555) 123-4567",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRowCard({
    required BuildContext context,
    SvgGenImage? svgIcon,
    String? networkImageUrl,
    required String title,
    required String value,
    bool isRating = false,
    bool isOrganizer = false,
  }) {
    final hasSvg = svgIcon != null;
    final hasNetworkImage = (networkImageUrl?.isNotEmpty ?? false);

    Widget buildImageWidget() {
      if (hasSvg) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: svgIcon.svg(),
        );
      } else if (hasNetworkImage) {
        return CustomNetworkImage(
          imageUrl: networkImageUrl!,
          borderRadius: BorderRadius.circular(30),
          height: 50,
          width: 50,
        );
      } else {
        return const Icon(Icons.image_not_supported, color: AppColors.brandHoverColor);
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.skyLight),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.softBrandColor,
              shape: BoxShape.circle,
            ),
            child: buildImageWidget(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
              if (isRating)
                Row(
                  children: [
                    Assets.icons.star.svg(),
                    const SizedBox(width: 4),
                    Text(value, style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400)),
                  ],
                )
              else
                Text(value, style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}
