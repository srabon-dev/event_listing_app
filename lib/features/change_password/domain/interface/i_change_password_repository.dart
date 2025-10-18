import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IChangePasswordRepository {
  Future<Either<Failure, Response>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String url,
    required String token,
  });
}