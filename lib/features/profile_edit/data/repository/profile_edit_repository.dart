import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

class ProfileEditRepository extends IProfileEditRepository {
  final IApiClient apiClient;
  ProfileEditRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> profileEdit({
    String? name,
    String? businessName,
    String? imagePath,
    String? phone,
    String? address,
    required String url,
    required String token,
  }) async {
    final Map<String, String> body = {
      if (name != null) "name": name,
      if (businessName != null) "businessName": businessName,
      if (phone != null) "phone": phone,
      if (address != null) "address": address,
    };

    final List<MultipartBody> multipart = [];

    if (imagePath != null && imagePath.isNotEmpty) {
      multipart.add(MultipartBody(fieldKey: "profile_image", file: File(imagePath)));
    }

    final Either<Failure, Response<dynamic>> response;

    if(multipart.isNotEmpty){
      response = await apiClient.uploadMultipart(
        url: url,
        fields: {
          "data": jsonEncode(body),
        },
        token: token,
        files: multipart,
        method: 'PATCH',
      );
    }else{
      response = await apiClient.patch(
        url: url,
        body: {
          "data": jsonEncode(body),
        },
        token: token,
      );
    }

    return response.fold((failure) {
        return Left(failure);
      }, (success) {
        return Right(success);
      },
    );
  }
}
