import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class ReviewRepository extends IReviewRepository {
  final IApiClient apiClient;

  ReviewRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> addReview({
    required String token,
    required String url,
    required String event,
    required double ratings,
  }) async {
    final response = await apiClient.post(
      url: url,
      body: {"event": event, "rating": ratings},
      token: token,
    );

    return response.fold((failure) {
        return Left(failure);
      }, (success) {
        return Right(success);
      },
    );
  }
}
