import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

class EventEditRepository extends IEventEditRepository {
  final IApiClient apiClient;

  EventEditRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> editEvent({
    required String token,
    List<String>? imagePath,
    required EventAddEntities body,
    required String url,
  }) async {

    final List<MultipartBody> multipart = [];

    final Either<Failure, Response<dynamic>> response;

    if(imagePath != null && imagePath.isNotEmpty) {
      for(String image in imagePath) {
        multipart.add(MultipartBody(fieldKey: "event_image", file: File(image)));
      }

      response =  await apiClient.uploadMultipart(
        url: url,
        files: multipart,
        method: "PATCH",
        token: token,
        fields: {
          "data": jsonEncode(body.toJson())
        },
      );
    } else {
      response =  await apiClient.patch(
        url: url,
        token: token,
        body: {
          "data": jsonEncode(body.toJson())
        },
      );
    }

    return response.fold((failure) {
      return Left(failure);
    }, (success) {
      return Right(success);
    });
  }
}
