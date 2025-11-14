import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class IHomeRepository {

  Future<Either<Failure, OrganizerEventModel>> getMyAllEvents({
    required String token,
    required String url,
  });
}