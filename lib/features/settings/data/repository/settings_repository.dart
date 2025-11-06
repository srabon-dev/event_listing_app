import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class SettingsRepository extends ISettingsRepository {
  final IApiClient apiClient;

  SettingsRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> deleteAccount({
    required String password,
    required String url,
    required String token,
  }) async {
    final Map<String, String> body = {"password": password};

    final response = await apiClient.post(url: url, body: body, token: token);

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
