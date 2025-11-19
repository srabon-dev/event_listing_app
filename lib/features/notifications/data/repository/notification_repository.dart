import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class NotificationRepository extends INotificationRepository {
  final IApiClient apiClient;

  NotificationRepository({required this.apiClient});

  @override
  Future<Either<Failure, List<NotificationItem>>> getNotifications({
    required String token,
    required String url,
  }) async {
    final response = await apiClient.get(url: url, token: token);

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (success) {
        final notificationModel = NotificationModel.fromJson(success.data);
        final items = notificationModel.data?.result ?? [];
        return Right(items);
      },
    );
  }

  @override
  Future<Either<Failure, Response>> removeNotification({
    required String token,
    required String url,
  }) async {
    final response = await apiClient.delete(url: url, token: token);

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (success) {
        return Right(success);
      },
    );
  }
}
