part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

final class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordAddNewState extends ChangePasswordState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ChangePasswordAddNewState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}