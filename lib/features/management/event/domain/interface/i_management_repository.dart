import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class IManagementRepository {

  Future<Either<Failure, OrganizerEventModel>> getEvents({
    required String token,
    required String url,
  });
}