import 'package:event_listing_app/app_export.dart';

part 'event_add_event.dart';
part 'event_add_state.dart';

class EventAddBloc extends Bloc<EventAddEvent, EventAddState> {
  final ILocalService db;
  final IEventAddRepository repository;

  EventAddBloc({required this.db, required this.repository}) : super(EventAddInitial()) {
    on<EventAdd>(_onEventAdd);
  }

  bool isRunning = false;

  Future<void> _onEventAdd(EventAdd event, Emitter<EventAddState> emit) async {
    try {
      if(isRunning)return;
      isRunning = true;

      emit(const EventState(isLoading: true));
      final token = await db.getToken();

      final response = await repository.addEvent(
        token: token,
        imagePath: event.imagePath,
        body: event.entities,
        url: ApiUrls.eventAdd(),
      );

      response.fold(
        (failure) {
          emit(EventState(isLoading: false, message: failure.message));
        },
        (success) {
          emit(const EventState(isLoading: false, isVerified: true));
        },
      );
    } catch (e) {
      emit(EventState(isLoading: false, error: e.toString()));
    } finally {
      isRunning = false;
    }
  }
}
