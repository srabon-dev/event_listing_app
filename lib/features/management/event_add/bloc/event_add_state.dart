part of 'event_add_bloc.dart';

sealed class EventAddState extends Equatable {
  const EventAddState();
}

final class EventAddInitial extends EventAddState {
  @override
  List<Object> get props => [];
}
