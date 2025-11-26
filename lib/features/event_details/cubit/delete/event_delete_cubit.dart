import '../../../../app_export.dart';

part 'event_delete_state.dart';

class EventDeleteCubit extends Cubit<EventDeleteState> {
  final ILocalService db;
  final IEventDetailsRepository repository;

  EventDeleteCubit({required this.db, required this.repository}) : super(EventDeleteInitial());

  Future<void> deleteEvent({required String id}) async {
    try {
      emit(const DeleteEventState(isLoading: true));
      final token = await db.getToken();

      final result = await repository.deleteEvent(
        token: token,
        url: ApiUrls.deleteEvent(id: id),
      );

      result.fold(
            (failure) {
          emit(DeleteEventState(message: failure.message, isLoading: false));
        },
            (profile) {
          emit(const DeleteEventState(isLoading: false, isVerified: true));
        },
      );
    } catch (e) {
      emit(DeleteEventState(message: e.toString(), isLoading: false));
    }
  }
}
