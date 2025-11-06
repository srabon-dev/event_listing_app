import 'package:event_listing_app/app_export.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ILocalService db;
  final IAuthRepository repository;

  AuthBloc({
    required this.repository,
    required this.db,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);

    on<ForgetEvent>(_onForget);
    on<ForgetOTPEvent>(_onForgetOTP);
    on<ResetPasswordEvent>(_onResetPassword);

    on<SignUpEvent>(_onSignUp);
    on<SignUpOTPEvent>(_onSignUpOtp);

    on<ResendOTPEvent>(_onResendOtp);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const LoginState(isLoading: true));

      final response = await repository.login(
        email: event.email,
        password: event.password,
        url: ApiUrls.login(),
      );

      await response.fold(
        (failure) async {
          emit(LoginState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (!success.isSuccess) {
            final errorMessage = 'Unknown error';
            emit(SignUpOtpState(isLoading: false, message: errorMessage));
            return;
          }

          db.saveUserdata(
            token: success.accessToken,
            refreshToken: success.refreshToken,
            id: success.userId,
            role: success.role,
          );

          emit(LoginState(isLoading: false, isVerified: true, authEntity: success));
        },
      );
    } catch (e) {
      emit(LoginState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onForget(ForgetEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const ForgetState(isLoading: true));

      final response = await repository.forget(email: event.email, url: ApiUrls.forget());

      await response.fold(
        (failure) async {
          emit(ForgetState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.statusCode != 200) {
            final errorMessage = success.data["message"] ?? 'Unknown error';
            emit(ForgetState(isLoading: false, message: errorMessage));
            return;
          }

          final message = success.data["message"] ?? 'Forget OTP send success';
          emit(ForgetState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(ForgetState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onForgetOTP(ForgetOTPEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const ForgetOtpState(isLoading: true));

      final response = await repository.forgetOTP(
        email: event.email,
        code: event.otp,
        url: ApiUrls.forgetOtpVerify(),
      );

      await response.fold(
        (failure) async {
          emit(ForgetOtpState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.statusCode != 200) {
            final errorMessage = success.data["message"] ?? 'Unknown error';
            emit(ForgetOtpState(isLoading: false, message: errorMessage));
            return;
          }

          final message = success.data["message"] ?? 'Forget OTP verify success';
          emit(ForgetOtpState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(ForgetOtpState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const ResetPasswordState(isLoading: true));

      final response = await repository.resetPassword(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        url: ApiUrls.resetPassword(),
      );

      await response.fold(
        (failure) async {
          emit(ResetPasswordState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.statusCode != 200) {
            final errorMessage = success.data["message"] ?? 'Unknown error';
            emit(ResetPasswordState(isLoading: false, message: errorMessage));
            return;
          }

          final message = success.data["message"] ?? 'Forget OTP verify success';
          emit(ResetPasswordState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(ResetPasswordState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SignUpState(isLoading: true));

      final response = await repository.signUp(
        businessName: event.businessName,
        name: event.name,
        email: event.email,
        role: event.role,
        password: event.password,
        confirmPassword: event.confirmPassword,
        phone: event.phone,
        url: ApiUrls.signUp(),
      );

      await response.fold((failure) async {
          emit(SignUpState(isLoading: false, message: failure.message));
        }, (success) async {
          final message = success.data["message"] ?? 'Sign up success';
          emit(SignUpState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(SignUpState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignUpOtp(SignUpOTPEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SignUpOtpState(isLoading: true));

      final response = await repository.signUpOTP(
        email: event.email,
        code: event.otp,
        url: ApiUrls.signUpOtp(),
      );

      await response.fold(
        (failure) async {
          emit(SignUpOtpState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (!success.isSuccess) {
            final errorMessage = 'Unknown error';
            emit(SignUpOtpState(isLoading: false, message: errorMessage));
            return;
          }

          db.saveUserdata(
            token: success.accessToken,
            refreshToken: success.refreshToken,
            id: success.userId,
            role: success.role,
          );

          final message = 'Sign up success';
          emit(SignUpOtpState(isLoading: false, isVerified: true, message: message, authEntity: success));
        },
      );
    } catch (e) {
      emit(SignUpOtpState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onResendOtp(ResendOTPEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const ResendOTPState(isLoading: true));

      final response = await repository.resendOTP(email: event.email, url: event.url);

      await response.fold(
        (failure) async {
          emit(ResendOTPState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.statusCode == 200) {
            final errorMessage = success.data?["message"] ?? 'Unknown error';
            emit(ResendOTPState(isLoading: false, message: errorMessage));
            return;
          }

          final message = success.data?["message"] ?? 'Sign up success';
          emit(ResendOTPState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(ResendOTPState(isLoading: false, error: e.toString()));
    }
  }
}
