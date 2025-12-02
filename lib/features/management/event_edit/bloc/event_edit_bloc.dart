import '../../../../app_export.dart';

part 'event_edit_event.dart';

part 'event_edit_state.dart';

class EventEditBloc extends Bloc<EventEditEvent, EventEditState> {
  final ILocalService db;
  final IEventEditRepository repository;

  EventEditBloc({required this.repository, required this.db}) : super(EventEditInitial()) {
    on<EventEditNewEvent>(_onEventEdit);
  }

  bool isRunning = false;

  Future<void> _onEventEdit(EventEditNewEvent event, Emitter<EventEditState> emit) async {
    try {
      if (isRunning) return;
      isRunning = true;

      emit(const EventEditNewState(isLoading: true));
      final token = await db.getToken();

      final response = await repository.editEvent(
        token: token,
        imagePath: event.imagePath,
        body: event.entities,
        url: ApiUrls.eventEdit(id: event.id),
      );

      response.fold(
        (failure) {
          emit(EventEditNewState(isLoading: false, message: failure.message));
        },
        (success) {
          emit(
            EventEditNewState(
              isLoading: false,
              isVerified: true,
              message: success.data?["message"] ?? "Successfully Edit Event",
            ),
          );
        },
      );
    } catch (e) {
      emit(EventEditNewState(isLoading: false, error: e.toString()));
    } finally {
      isRunning = false;
    }
  }
}
