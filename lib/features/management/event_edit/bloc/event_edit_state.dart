part of 'event_edit_bloc.dart';

sealed class EventEditState extends Equatable {
  const EventEditState();
}

final class EventEditInitial extends EventEditState {
  @override
  List<Object> get props => [];
}

class EventEditNewState extends EventEditState {
  final bool isLoading;
  final String? error;
  final String? message;
  final bool isVerified;

  const EventEditNewState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isVerified = false,
  });

  @override
  List<Object?> get props => [isLoading, error, isVerified, message];
}