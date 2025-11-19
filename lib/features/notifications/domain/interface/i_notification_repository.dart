import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class INotificationRepository {

  Future<Either<Failure, List<NotificationItem>>> getNotifications({
    required String token,
    required String url,
  });

  Future<Either<Failure, Response>> removeNotification({
    required String token,
    required String url,
  });
}