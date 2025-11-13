part of 'event_add_bloc.dart';

sealed class EventAddEvent extends Equatable {
  const EventAddEvent();
}

class EventAdd extends EventAddEvent {
  final EventAddEntities entities;
  final List<String> imagePath;

  const EventAdd({
    required this.entities,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [entities, imagePath];
}