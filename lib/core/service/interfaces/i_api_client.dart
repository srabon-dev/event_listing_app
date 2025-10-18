import 'package:dartz/dartz.dart';
import '../../../app_export.dart';

abstract class IApiClient {
  Future<Either<Failure, Response>> get({
    required String url,
    Map<String, dynamic>? queryParams,
    String? token,
  });

  Future<Either<Failure, Response>> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  });

  Future<Either<Failure, Response>> patch({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  });

  Future<Either<Failure, Response>> put({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  });

  Future<Either<Failure, Response>> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  });

  Future<Either<Failure, Response>> uploadMultipart({
    required String url,
    required List<MultipartBody> files,
    required String method,
    required String token,
    Map<String, String>? fields,
  });
}
