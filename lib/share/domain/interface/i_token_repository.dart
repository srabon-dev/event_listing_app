import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class ITokenRepository{
  Future<Either<Failure, Response>> refreshToken({required String refreshToken, required String url});
}