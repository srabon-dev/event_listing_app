part of 'event_details_cubit.dart';

sealed class EventDetailsState extends Equatable {
  const EventDetailsState();
}

final class EventDetailsInitial extends EventDetailsState {
  @override
  List<Object> get props => [];
}

final class EventDetailsLoading extends EventDetailsState {
  @override
  List<Object> get props => [];
}

class EventDetailsLoaded extends EventDetailsState {
  final Map<String, String> data;
  const EventDetailsLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class EventDetailsError extends EventDetailsState {
  final String message;
  const EventDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
