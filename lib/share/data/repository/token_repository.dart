import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class TokenRepository extends ITokenRepository{
  final IApiClient apiClient;
  TokenRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> refreshToken({required String refreshToken, required String url}) async {
    final body = {'refresh_token': refreshToken};

    final response = await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }
}