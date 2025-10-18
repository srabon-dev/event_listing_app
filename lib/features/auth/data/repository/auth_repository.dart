/*
import 'package:dartz/dartz.dart';
import 'package:my_rv_app/features/auth/data/model/sign_up_model.dart';
import 'package:my_rv_app/features/auth/domain/entities/auth_entity.dart';
import 'package:my_rv_app/features/auth/domain/interface/i_auth_repository.dart';
import '../../../../app_export.dart';
import '../model/auth_model.dart';

class AuthRepository extends IAuthRepository {
  final IApiClient apiClient;

  AuthRepository({required this.apiClient});

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required String url,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      final authModel = AuthModel.fromJson(success.data);
      return Right(authModel.toEntity());
    });
  }

  @override
  Future<Either<Failure, Response>> forget({
    required String email,
    required String url,
  }) async {
    final body = {
      'email': email,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }

  @override
  Future<Either<Failure, Response>> forgetOTP({
    required String code,
    required String email,
    required String url,
  }) async {
    final body = {
      'email': email,
      'code': code,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }

  @override
  Future<Either<Failure, Response>> resetPassword({
    required String password,
    required String confirmPassword,
    required String email,
    required String url,
  }) async {
    final body = {
      "email": email,
      "confirmPassword": confirmPassword,
      "newPassword": password,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }

  @override
  Future<Either<Failure, Response>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String url,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      return Right(success);
    });
  }

  @override
  Future<Either<Failure, SignUpModel>> signUpOTP({
    required String code,
    required String email,
    required String url,
  }) async {
    final body = {
      'email': email,
      'code': code,
    };

    final response =  await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure){
      return Left(failure);
    }, (success){
      final authModel = SignUpModel.fromJson(success.data);
      return Right(authModel);
    });
  }

  @override
  Future<Either<Failure, Response>> resendOTP({
    required String email,
    required String url,
  }) async {
    final body = {
      'email': email,
    };

    final response = await apiClient.post(
      url: url,
      body: body,
    );

    return response.fold((failure) {
      return Left(failure);
    }, (success) {
      return Right(success);
    });
  }
}*/
