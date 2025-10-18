import 'package:event_listing_app/app_export.dart';

import '../widgets/event_details_about_section.dart';
import '../widgets/event_details_description_section.dart';
import '../widgets/event_details_location_section.dart';
import '../widgets/event_details_organizer_section.dart';
import '../widgets/event_details_top_section_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventDetailsCubit(db: sl<ILocalService>()),
      child: _View(id: id),
    );
  }
}

class _View extends StatefulWidget {
  const _View({required this.id});

  final String id;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late final EventDetailsCubit controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<EventDetailsCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.state is! EventDetailsLoaded) {
        controller.getEventDetails(id: widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.eventDetails), titleTextStyle: context.titleMedium),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
          builder: (context, state) {
            if (state is EventDetailsLoading) {
              return const LoadingWidget();
            } else if (state is EventDetailsError) {
              return ErrorCard(
                text: state.message,
                onTap: () {
                  controller.getEventDetails(id: widget.id);
                },
              );
            } else if (state is EventDetailsLoaded) {
              final data = state.data;

              return RefreshIndicator(
                onRefresh: () async {
                  controller.getEventDetails(id: widget.id);
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                        child: EventDetailsTopSectionWidget(
                            data: data,
                        ),
                    ),
                    const SliverGap(18),
                    const SliverToBoxAdapter(
                      child: EventDetailsAboutSection(),
                    ),
                    const SliverGap(18),
                    const SliverToBoxAdapter(
                      child: EventDetailsDescriptionSection(),
                    ),
                    const SliverGap(18),
                    const SliverToBoxAdapter(
                      child: EventDetailsOrganizerSection(),
                    ),
                    const SliverGap(18),
                    const SliverToBoxAdapter(
                      child: EventDetailsLocationSection(),
                    ),
                    const SliverGap(44),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
