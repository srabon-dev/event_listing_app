part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsUpdate extends SettingsState{
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const SettingsUpdate({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
