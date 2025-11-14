import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class ISearchRepository {

  Future<Either<Failure, OrganizerEventModel>> getSearchEvents({
    required String token,
    required String url,
  });
}