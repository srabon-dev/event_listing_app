import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

class ChangePasswordRepository extends IChangePasswordRepository {
  final IApiClient apiClient;
  ChangePasswordRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String url,
    required String token,
  }) async {
    final Map<String, String> body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmNewPassword": confirmPassword,
    };

    final response = await apiClient.post(
      url: url,
      body: body,
      token: token,
    );

    return response.fold((failure) => Left(failure), (success) {
      return Right(success);
    },
    );
  }
}
