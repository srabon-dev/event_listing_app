import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class EventAddRepository extends IEventAddRepository {
  final IApiClient apiClient;

  EventAddRepository({required this.apiClient});
  
  @override
  Future<Either<Failure, Response>> addEvent({
    required String token,
    required List<String> imagePath,
    required EventAddEntities body,
    required String url,
  }) async {

    final List<MultipartBody> multipart = [];

    for(String image in imagePath) {
      multipart.add(MultipartBody(fieldKey: "event_image", file: File(image)));
    }

    final response =  await apiClient.uploadMultipart(
      url: url,
      files: multipart,
      method: "POST",
      token: token,
      fields: {
        "data": jsonEncode(body.toJson())
      },
    );

    return response.fold((failure) {
      return Left(failure);
    }, (success) {
      return Right(success);
    });
  }
}
