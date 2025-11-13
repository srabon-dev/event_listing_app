part of 'event_add_bloc.dart';

sealed class EventAddState extends Equatable {
  const EventAddState();
}

final class EventAddInitial extends EventAddState {
  @override
  List<Object> get props => [];
}

class EventState extends EventAddState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const EventState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}
