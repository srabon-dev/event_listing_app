part of 'remove_notification_cubit.dart';

sealed class RemoveNotificationState extends Equatable {
  const RemoveNotificationState();
}

final class RemoveNotificationInitial extends RemoveNotificationState {
  @override
  List<Object> get props => [];
}

class RemoveNotificationStatus extends RemoveNotificationState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;
  final String? deletingId;

  const RemoveNotificationStatus({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
    this.deletingId,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message, deletingId];
}