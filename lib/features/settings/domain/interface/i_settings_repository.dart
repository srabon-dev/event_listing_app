import 'package:dartz/dartz.dart';
import 'package:event_listing_app/app_export.dart';

abstract class ISettingsRepository {

  Future<Either<Failure, Response>> deleteAccount({
    required String password,
    required String url,
    required String token,
  });
}