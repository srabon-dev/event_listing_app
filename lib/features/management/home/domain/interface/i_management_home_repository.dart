import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class IManagementHomeRepository {

  Future<Either<Failure, OrganizerEventModel>> getMyAllEvents({
    required String token,
    required String url,
  });
}