import 'package:event_listing_app/app_export.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsOrganizerSection extends StatelessWidget {
  const EventDetailsOrganizerSection({
    super.key,
    required this.data,
    required this.isUser,
    required this.id,
  });

  final bool isUser;
  final EventDetailsEntity data;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isUser && data.ratingData?.user?.name != null)
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
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.softBrandColor,
                    shape: BoxShape.circle,
                  ),
                  child: CustomNetworkImage(
                    imageUrl:
                        data.ratingData?.user?.profileImage ?? "https://picsum.photos/450/300",
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.ratingData?.user?.name ?? context.loc.unknown,
                      style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Assets.icons.star.svg(),
                        Text(
                          formatRating(data.ratingData?.rating ?? 0),
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
                        (data.registrationFee == null || data.registrationFee.toString().isEmpty)
                            ? "Free"
                            : "\$${data.registrationFee}",
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
                      if (isUser)
                        GestureDetector(
                          onTap: () {
                            context.read<BookmarkCubit>().toggleBookmark(id: id);
                          },
                          child: BlocConsumer<BookmarkCubit, BookmarkState>(
                            listener: (context, state) {
                              if (state is BookmarkToggle && state.message != null) {
                                AppToast.success(message: state.message);
                              }

                              if (state is BookmarkToggle && state.isVerified) {
                                context.read<EventDetailsCubit>().getEventDetails(id: id);
                              }
                            },
                            builder: (context, state) {
                              if (state is BookmarkToggle && state.isLoading) {
                                return const LoadingWidget();
                              }
                              return Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: data.isBookmark == true
                                      ? AppColors.brandHoverColor
                                      : AppColors.softBrandColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Assets.icons.bookmark.svg(
                                  colorFilter: data.isBookmark == true
                                      ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          try {
                            SharePlus.instance.share(
                              ShareParams(
                                text:
                                    'Check out this event: ${data.name}\n${data.websiteLink ?? ""}',
                              ),
                            );
                          } finally {}
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(14),
                          decoration: const BoxDecoration(
                            color: AppColors.softBrandColor,
                            shape: BoxShape.circle,
                          ),
                          child: Assets.icons.share.svg(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomButton(
                text: context.loc.goToEventRegistrationLink,
                onTap: () async {
                  try {
                    final url = data.websiteLink;

                    if (url == null || url.trim().isEmpty) {
                      AppToast.warning(
                        message: "No registration link is available for this event.",
                      );
                      return;
                    }

                    final uri = Uri.parse(url);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } else {
                      AppToast.warning(
                        message: "We couldn't open the registration link. Please try again.",
                      );
                    }
                  } catch (e) {
                    AppToast.warning(
                      message:
                          "Unable to open the link. Check your internet connection and try again.",
                    );
                  }
                },
              ),
              Text(
                context.loc.organizer_info,
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w500),
              ),
              Column(
                spacing: 12,
                children: [
                  buildRowCard(
                    context: context,
                    networkImageUrl:
                        data.organizer?.profileImage ?? "https://picsum.photos/450/300",
                    title: context.loc.organizedBy,
                    value: data.organizer?.businessName ?? context.loc.unknown,
                    isOrganizer: true,
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.starGray,
                    title: context.loc.ratings,
                    value: "${data.averageRating ?? 0} (${data.totalRating ?? 0})",
                    isRating: true,
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.email,
                    title: context.loc.contactEmail,
                    value: data.organizer?.email ?? context.loc.unknown,
                  ),
                  buildRowCard(
                    context: context,
                    svgIcon: Assets.icons.call,
                    title: context.loc.contactPhone,
                    value: data.organizer?.phone ?? context.loc.unknown,
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
        return Padding(padding: const EdgeInsets.all(5.0), child: svgIcon.svg());
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
