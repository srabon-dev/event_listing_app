/*
import 'package:my_rv_app/app_export.dart';
import 'package:my_rv_app/features/auth/domain/entities/auth_entity.dart';
import 'package:my_rv_app/features/auth/domain/usecases/login_usecase.dart';

import '../domain/usecases/forget_otp_usecase.dart';
import '../domain/usecases/forget_usecase.dart';
import '../domain/usecases/resend_otp_usecase.dart';
import '../domain/usecases/reset_password_usecase.dart';
import '../domain/usecases/sign_up_otp_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ILocalService db;
  final LoginUseCase loginUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  final ForgetUseCase forgetUseCase;
  final ForgetOtpUseCase forgetOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  final SignUpUseCase signUpUseCase;
  final SignUpOtpUseCase signUpOtpUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.resendOtpUseCase,
    required this.forgetUseCase,
    required this.forgetOtpUseCase,
    required this.resetPasswordUseCase,
    required this.signUpUseCase,
    required this.signUpOtpUseCase,
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

      final response = await loginUseCase.call(
        email: event.email,
        password: event.password,
        url: ApiUrls.login(),
      );

      await response.fold(
        (failure) async {
          emit(LoginState(isLoading: false, message: failure.message));
        },
        (success) async {
          Future.wait([
            db.saveUserdata(
              token: success.accessToken,
              refreshToken: success.refreshToken,
              id: success.userId,
            ),
            db.saveChassis(
              id: success.chassisId,
            ),
            db.saveRv(
              id: success.rvId,
            ),
          ]);
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

      final response = await forgetUseCase.call(email: event.email, url: ApiUrls.forget());

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

      final response = await forgetOtpUseCase.call(
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

      final response = await resetPasswordUseCase.call(
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

      final response = await signUpUseCase.call(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
        phone: "",
        url: ApiUrls.signUp(),
      );

      await response.fold(
        (failure) async {
          emit(SignUpState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.statusCode != 201) {
            final errorMessage = success.data["message"] ?? 'Unknown error';
            emit(SignUpState(isLoading: false, message: errorMessage));
            return;
          }

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

      final response = await signUpOtpUseCase.call(
        email: event.email,
        code: event.otp,
        url: ApiUrls.signUpOtp(),
      );

      await response.fold(
        (failure) async {
          emit(SignUpOtpState(isLoading: false, message: failure.message));
        },
        (success) async {
          if (success.success != true) {
            final errorMessage = success.message ?? 'Unknown error';
            emit(SignUpOtpState(isLoading: false, message: errorMessage));
            return;
          }

          await db.saveUserdata(
            token: success.accessToken ?? "",
            refreshToken: success.refreshToken ?? "",
            id: success.user?.id ?? "",
          );

          final message = success.message ?? 'Sign up success';
          emit(SignUpOtpState(isLoading: false, isVerified: true, message: message));
        },
      );
    } catch (e) {
      emit(SignUpOtpState(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onResendOtp(ResendOTPEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const ResendOTPState(isLoading: true));

      final response = await resendOtpUseCase.call(email: event.email, url: event.url);

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
*/
