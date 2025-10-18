import 'package:event_listing_app/app_export.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final ILocalService db;

  EventDetailsCubit({required this.db}) : super(EventDetailsInitial());

  bool isRunning = false;

  Future<void> getEventDetails({required String id}) async {
    try {
      if (isRunning) return;
      isRunning = true;

      emit(EventDetailsLoading());

      await Future.delayed(const Duration(milliseconds: 800));

      final items = {
        "title": "Summer Elite Soccer Camp 2025",
        "subTitle": "For ages 10–14 | Intermediate to Advanced | Hosted by All-Star Academy",
        "imageUrl": "https://picsum.photos/450/300",
        "status": "Registration Open",
        "registrationDeadline":"15 May 2020 8:00 am"
      };

      emit(EventDetailsLoaded(items));
    } catch (e) {
      emit(const EventDetailsError('Failed to load categories'));
    } finally {
      isRunning = false;
    }
  }
}
