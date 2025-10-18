import '../failure.dart';

abstract class IErrorHandler{
  Failure handleDioError(dynamic error);
}