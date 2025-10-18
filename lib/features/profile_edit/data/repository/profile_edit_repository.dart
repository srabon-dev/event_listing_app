import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';
import '../../domain/interface/i_profile_edit_repository.dart';

class ProfileEditRepository extends IProfileEditRepository {
  final IApiClient apiClient;
  ProfileEditRepository({required this.apiClient});

  @override
  Future<Either<Failure, Response>> profileEdit({
    String? name,
    String? imagePath,
    String? currentMileage,
    required String url,
    required String token,
  }) async {
    final Map<String, String> body = {
      if (name != null) "name": name,
      if (currentMileage != null) "currentMileage": currentMileage,
    };

    final List<MultipartBody> multipart = [];

    if (imagePath != null && imagePath.isNotEmpty) {
      multipart.add(MultipartBody(fieldKey: "profilePic", file: File(imagePath)));
    }

    final Either<Failure, Response<dynamic>> response;

    if(multipart.isNotEmpty){
      response = await apiClient.uploadMultipart(
        url: url,
        fields: body,
        token: token,
        files: multipart,
        method: 'PUT',
      );
    }else{
      response = await apiClient.put(
        url: url,
        body: body,
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

  @override
  Future<Either<Failure, Response>> changeRv({
    required String rvId,
    required String token,
    required String url,
  }) async {
    final body = {"rvId": rvId};

    final response = await apiClient.put(url: url, token: token, body: body);

    return response.fold((failure) {
        return Left(failure);
      }, (success) {
        return Right(success);
      },
    );
  }

  @override
  Future<Either<Failure, Response>> deleteRv({
    required String token,
    required String url,
  }) async{
    final response = await apiClient.post(url: url, token: token, body: {});

    return response.fold((failure) {
        return Left(failure);
      }, (success) {
        return Right(success);
      },
    );
  }
}
