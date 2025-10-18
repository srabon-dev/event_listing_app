/*
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class ForgetEvent extends AuthEvent {
  const ForgetEvent({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}
class ForgetOTPEvent extends AuthEvent {
  const ForgetOTPEvent({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}
class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}
class SignUpOTPEvent extends AuthEvent {
  const SignUpOTPEvent({required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  List<Object?> get props => [email, otp];
}

class ResendOTPEvent extends AuthEvent {
  const ResendOTPEvent({required this.email, required this.url});

  final String email;
  final String url;

  @override
  List<Object?> get props => [email, url];
}
*/
