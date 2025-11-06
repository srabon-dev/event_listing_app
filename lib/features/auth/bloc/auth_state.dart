part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {

  @override
  List<Object> get props => [];
}

class LoginState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;
  final AuthEntity? authEntity;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
    this.authEntity,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message, authEntity];
}

class ForgetState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ForgetState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
class ForgetOtpState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ForgetOtpState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
class ResetPasswordState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ResetPasswordState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}

class SignUpState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const SignUpState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
class SignUpOtpState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;
  final AuthEntity? authEntity;

  const SignUpOtpState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
    this.authEntity,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message, authEntity];
}

class ResendOTPState extends AuthState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ResendOTPState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}


