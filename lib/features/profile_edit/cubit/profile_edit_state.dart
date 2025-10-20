part of 'profile_edit_cubit.dart';

sealed class ProfileEditState extends Equatable {
  const ProfileEditState();
}

final class ProfileEditInitial extends ProfileEditState {
  @override
  List<Object> get props => [];
}

class ProfileUpdate extends ProfileEditState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const ProfileUpdate({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
