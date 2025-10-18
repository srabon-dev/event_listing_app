import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class ProfileRepository extends IProfileRepository {
  final IApiClient apiClient;

  ProfileRepository({required this.apiClient});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile({
    required String token,
    required String url,
  }) async {
    final response = await apiClient.get(url: url, token: token);

    return response.fold(
      (failure) {
        return Left(failure);
      },
      (success) {
        final profileModel = ProfileModel.fromJson(success.data);
        return Right(profileModel.toEntity());
      },
    );
  }
}
