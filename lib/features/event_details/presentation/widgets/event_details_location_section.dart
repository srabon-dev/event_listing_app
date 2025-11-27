import 'package:event_listing_app/app_export.dart';

class EventDetailsLocationSection extends StatelessWidget {
  const EventDetailsLocationSection({super.key, required this.data, required this.isUser, required this.id, required this.cubit});
  final String id;
  final EventDetailsCubit cubit;
  final EventDetailsEntity data;
  final bool isUser;

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
                          data.address ?? context.loc.unknown,
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StaticMapView(
                  height: 200,
                  width: context.width,
                  lat: data.location?.coordinates?.lastOrNull,
                  lng: data.location?.coordinates?.firstOrNull,
                  apiKey: AppConfig.googleMapAPIKey,
                ),
              ),
            ],
          ),
        ),
        if (!isUser)
          ElevatedButton(
            onPressed: () {
              showCustomAnimatedDialog(
                context: context,
                actionButton: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          AppRouter.route.pop();
                        }
                      },
                      child: const Text("No"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<EventDeleteCubit>().deleteEvent(id: id);
                      },
                      child: BlocConsumer<EventDeleteCubit, EventDeleteState>(
                        listener: (context, state) {
                          if(state is DeleteEventState){
                            if(state.message != null && state.message!.isNotEmpty) {
                              AppToast.success(message: state.message);
                            }
                            if(state.isVerified) {
                              if (Navigator.canPop(context)) {
                                AppRouter.route.pop();
                                if (Navigator.canPop(context)) {
                                  AppRouter.route.pop(true);
                                }
                              }
                            }
                          }
                        },
                        builder: (context, state) {
                          final loading = state is DeleteEventState && state.isLoading;
                          if(loading) {
                            return const LoadingWidget(color: AppColors.white,);
                          }
                          return const Text("Yes");
                        },
                      ),
                    ),
                  ),
                ],
                title: "Delete Event",
                subtitle: "Are you sure you want delete event?",
              );
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.white),
              elevation: WidgetStatePropertyAll(0),
              side: WidgetStatePropertyAll(BorderSide(color: AppColors.errorColor)),
            ),
            child: Text(
              "Delete Event",
              style: context.titleMedium.copyWith(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
