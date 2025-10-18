part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class ChangePasswordAddNewEvent extends ChangePasswordEvent {
  const ChangePasswordAddNewEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  @override
  List<Object?> get props => [
    oldPassword,
    newPassword,
    confirmPassword,
  ];
}