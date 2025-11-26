import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class EventDetailsRepository extends IEventDetailsRepository {
  final IApiClient apiClient;

  EventDetailsRepository({required this.apiClient});

  @override
  Future<Either<Failure, EventDetailsEntity>> getEventDetails({
    required String token,
    required String url,
  }) async {
    final response = await apiClient.get(url: url, token: token);

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (success) {
        final model = EventDetailsModel.fromJson(success.data);
        return Right(model.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, Response>> deleteEvent({
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
