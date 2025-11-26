part of 'event_delete_cubit.dart';

sealed class EventDeleteState extends Equatable {
  const EventDeleteState();
}

final class EventDeleteInitial extends EventDeleteState {
  @override
  List<Object> get props => [];
}

class DeleteEventState extends EventDeleteState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const DeleteEventState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}