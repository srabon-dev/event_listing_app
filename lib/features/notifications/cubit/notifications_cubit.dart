import 'package:event_listing_app/app_export.dart';

class NotificationsCubit extends Cubit<void> {
  final ILocalService db;
  final INotificationRepository repository;

  NotificationsCubit({required this.db, required this.repository}) : super(null);

  bool isLoading = false;

  Future<void> get({
    required int pageKey,
    required PagingController<int, NotificationItem> pagingController,
  }) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final token = await db.getToken();
      final response = await repository.getNotifications(
        url: ApiUrls.getNotifications(page: pageKey),
        token: token,
      );

      response.fold(
        (failure) {
          pagingController.error = failure.message;
        },
        (value) {
          if (value.isEmpty) {
            pagingController.appendLastPage(value);
          } else {
            pagingController.appendPage(value, pageKey + 1);
          }
        },
      );
    } catch (e) {
      pagingController.error = 'An error occurred';
    } finally {
      isLoading = false;
    }
  }
}
