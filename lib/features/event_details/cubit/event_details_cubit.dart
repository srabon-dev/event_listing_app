import 'package:event_listing_app/app_export.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final ILocalService db;
  final IEventDetailsRepository repository;

  EventDetailsCubit({required this.db, required this.repository}) : super(EventDetailsInitial());

  bool isRunning = false;

  Future<void> getEventDetails({required String id}) async {
    try {
      if (isRunning) return;
      isRunning = true;

      emit(EventDetailsLoading());

      final token = await db.getToken();
      final result = await repository.getEventDetails(token: token, url: ApiUrls.getEventDetails(id: id));

      result.fold(
            (failure) => emit(EventDetailsError(failure.message)),
            (profile) => emit(EventDetailsLoaded(profile)),
      );

    } catch (e) {
      emit(const EventDetailsError('Failed to load categories'));
    } finally {
      isRunning = false;
    }
  }
}
