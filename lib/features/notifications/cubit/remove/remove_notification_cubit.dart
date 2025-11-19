import 'package:event_listing_app/app_export.dart';

part 'remove_notification_state.dart';

class RemoveNotificationCubit extends Cubit<RemoveNotificationState> {
  final ILocalService db;
  final INotificationRepository repository;

  RemoveNotificationCubit({required this.db, required this.repository}) : super(RemoveNotificationInitial());

  Future<void> removeNotification({required String id}) async {
    try {
      emit(RemoveNotificationStatus(isLoading: true, deletingId: id));
      final token = await db.getToken();

      final result = await repository.removeNotification(
        token: token,
        url: ApiUrls.deleteNotification(id: id),
      );

      result.fold(
            (failure) {
          emit(RemoveNotificationStatus(message: failure.message, isLoading: false, deletingId: id));
        },
            (profile) {
          emit(RemoveNotificationStatus(isLoading: false, isVerified: true, deletingId: id));
        },
      );
    } catch (e) {
      emit(RemoveNotificationStatus(message: e.toString(), isLoading: false, deletingId: id));
    }
  }
}
