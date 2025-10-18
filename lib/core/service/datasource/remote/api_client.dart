import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../../app_export.dart';

class ApiClient extends IApiClient{
  final Dio dio;
  final INetworkChecker networkChecker;
  final ILocalizationHelper localizationHelper;
  final IErrorHandler errorHandler;

  ApiClient({required this.dio, required this.networkChecker, required this.localizationHelper, required this.errorHandler});

  Map<String, String> _headers({String? token, bool isJson = true, bool isMultipart = false}) {
    final headers = <String, String>{};

    if (token != null) {
      AppLogger.log(token);
      headers['Authorization'] = "Bearer $token";
    }

    if (isJson) {
      headers['Content-Type'] = 'application/json';
    }
    return headers;
  }

  @override
  Future<Either<Failure, Response>> get({
    required String url,
    Map<String, dynamic>? queryParams,
    String? token,
  }) async {
    try {
      AppLogger.log("GET: $url : Token : ${_headers(token: token)} : Body : $queryParams");
      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: _headers(token: token)),
      );

      AppLogger.log("GET: $url : Status Code: ${response.statusCode} : Body : $queryParams, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("GET: $url : Body : $queryParams, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    try {

      AppLogger.log("POST: $url : Body : $body");
      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: _headers(token: token)),
      );
      AppLogger.log("POST: $url : Status Code: ${response.statusCode} : Body : $body, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("POST: $url : Body : $body, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> patch({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {

      AppLogger.log("PATCH: $url : Body : $body");
      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final response = await dio.patch(
        url,
        data: body,
        options: Options(headers: _headers(token: token)),
      );
      AppLogger.log("PATCH: $url : Status Code: ${response.statusCode} : Body : $body, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("PATCH: $url : Body : $body, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> put({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      AppLogger.log("PUT: $url : Body : $body");
      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final response = await dio.put(
        url,
        data: body,
        options: Options(headers: _headers(token: token)),
      );
      AppLogger.log("PUT: $url : Status Code: ${response.statusCode} : Body : $body, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("PUT: $url : Body : $body, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    try {
      AppLogger.log("DELETE: $url : Body : $body");
      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final response = await dio.delete(
        url,
        data: body,
        options: Options(headers: _headers(token: token, isJson: false)),
      );
      AppLogger.log("DELETE: $url : Status Code: ${response.statusCode} : Body : $body, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("DELETE: $url : Body : $body, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> uploadMultipart({
    required String url,
    required List<MultipartBody> files,
    required String method,
    required String token,
    Map<String, String>? fields,
  }) async {
    try {
      AppLogger.log("MULTIPART: $url : Body : $fields");

      final connectionCheck = await _checkConnection();
      if (connectionCheck.isLeft()) return Left(connectionCheck.swap().getOrElse(() => Failure(message: 'No internet connection')));

      final Map<String, dynamic> formMap = {};

      fields?.forEach((key, value) {
        formMap[key] = value.toString();
      });


      for (final item in files) {
        AppLogger.log(item.file.path);

        final mimeType = lookupMimeType(item.file.path) ?? 'application/octet-stream';
        final split = mimeType.split('/');

        formMap[item.fieldKey] = await MultipartFile.fromFile(
          item.file.path,
          filename: item.file.uri.pathSegments.last,
          contentType: MediaType(split[0], split[1]),
        );

        AppLogger.log("${item.fieldKey} - ${item.file.uri.pathSegments.last} - $mimeType");
      }


      final formData = FormData.fromMap(formMap);

      final response = await dio.request(
        url,
        data: formData,
        options: Options(
          method: method,
          headers: _headers(token: token, isJson: false),
          // contentType: 'multipart/form-data',
        ),
      );
      AppLogger.log("MULTIPART: $url : Status Code: ${response.statusCode} : Body : $fields, Response: ${response.data}");
      return Right(response);
    } catch (e) {
      AppLogger.log("MULTIPART: $url : Body : $fields, Error: ${e.toString()}");
      return Left(errorHandler.handleDioError(e));
    }
  }

  Future<Either<Failure, void>> _checkConnection() async {
    final hasNet = await networkChecker.hasConnection();
    if (!hasNet) {
      final message = localizationHelper.getLocalizedText(
            (log) => log.noInternetConnection,
        'No internet connection',
      );
      return Left(Failure(message: message));
    }
    return const Right(null);
  }
}
