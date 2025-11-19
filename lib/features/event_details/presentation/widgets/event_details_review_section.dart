import 'package:event_listing_app/app_export.dart';
import 'package:flutter_rating/flutter_rating.dart';

class EventDetailsReviewSection extends StatelessWidget {
  const EventDetailsReviewSection({super.key, required this.data, required this.id, required this.controller});
  final String id;
  final EventDetailsEntity data;
  final EventDetailsCubit controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return Center(
                  child: Dialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 18),
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 16,
                    child: IntrinsicHeight(child: _DialogCard(data: data, id: id, controller: controller,)),
                  ),
                );
              },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeInCubic,
            );
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: curvedAnimation, child: child),
            );
          },
        );
      },
      child: Text(context.loc.giveFeedback),
    );
  }
}

class _DialogCard extends StatefulWidget {
  const _DialogCard({required this.data, required this.id, required this.controller});

  final EventDetailsCubit controller;
  final EventDetailsEntity data;
  final String id;

  @override
  State<_DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends State<_DialogCard> {
  double selectedRatings = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 30, width: 30),
              Text(
                context.loc.leaveFeedback,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      AppRouter.route.pop();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.brandHoverColor,
                    ),
                    child: Assets.icons.cross.svg(
                      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
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
                    CustomNetworkImage(
                      imageUrl:
                          widget.data.organizer?.profileImage ?? "https://picsum.photos/450/300",
                      borderRadius: BorderRadius.circular(30),
                      height: 50,
                      width: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.organizedBy,
                          style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.data.organizer?.businessName ?? context.loc.unknown,
                          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
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
                      child: Assets.icons.starGray.svg(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.ratings,
                          style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${widget.data.averageRating ?? 0} (${widget.data.totalRating ?? 0})",
                          style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            context.loc.how_was_your_experience_attending_this_event,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
          StarRating(
            size: 50,
            rating: selectedRatings,
            onRatingChanged: (rating) {
              setState(() {
                selectedRatings = rating;
              });
            },
          ),
          const Gap(8),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                context.read<ReviewCubit>().addReview(event: widget.id, rating: selectedRatings);
              },
              child: BlocConsumer<ReviewCubit, ReviewState>(
                listener: (context, state) {
                  if(state is ReviewAdd && state.message != null){
                    AppToast.success(message: state.message);
                  }

                  if(state is ReviewAdd && state.isVerified){
                    if(Navigator.canPop(context)){
                      AppRouter.route.pop();
                    }
                    widget.controller.getEventDetails(id: widget.id);
                  }
                },
                builder: (context, state) {
                  if(state is ReviewAdd && state.isLoading){
                    return const LoadingWidget();
                  }
                  return Text(context.loc.submit);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
