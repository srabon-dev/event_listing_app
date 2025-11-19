import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class IReviewRepository {
  Future<Either<Failure, Response>> addReview({
    required String token,
    required String url,
    required String event,
    required double ratings,
  });
}
