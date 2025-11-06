import 'package:dartz/dartz.dart';
import '../../../../app_export.dart';

abstract class IAuthRepository{
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required String url,
  });

  Future<Either<Failure, Response>> forget({
    required String email,
    required String url,
  });

  Future<Either<Failure, Response>> forgetOTP({
    required String code,
    required String email,
    required String url,
  });

  Future<Either<Failure, Response>> resetPassword({
    required String password,
    required String confirmPassword,
    required String email,
    required String url,
  });

  Future<Either<Failure, Response>> signUp({
    String? businessName,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String phone,
    required String url,
  });

  Future<Either<Failure, AuthEntity>> signUpOTP({
    required String code,
    required String email,
    required String url,
  });

  Future<Either<Failure, Response>> resendOTP({
    required String email,
    required String url,
  });
}
