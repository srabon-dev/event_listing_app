import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class BookmarkRepository extends IBookmarkRepository{
  final IApiClient apiClient;
  BookmarkRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> toggleBookmark({required String token, required String url}) async {
    final response = await apiClient.post(
      url: url,
      body: {},
      token: token
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }
}