import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class ManagementHomeRepository extends IManagementHomeRepository {
  final IApiClient apiClient;

  ManagementHomeRepository({required this.apiClient});

  @override
  Future<Either<Failure, OrganizerEventModel>> getMyAllEvents({
    required String token,
    required String url,
  }) async {
    final response = await apiClient.get(url: url, token: token);

    return response.fold((failure) {
      return Left(failure);
    }, (success) {
      final profileModel = OrganizerEventModel.fromJson(success.data);
      return Right(profileModel);
    },
    );
  }
}
