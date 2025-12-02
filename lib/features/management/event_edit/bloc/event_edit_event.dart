part of 'event_edit_bloc.dart';

sealed class EventEditEvent extends Equatable {
  const EventEditEvent();
}

class EventEditNewEvent extends EventEditEvent {
  final String id;
  final EventAddEntities entities;
  final List<String> imagePath;

  const EventEditNewEvent({
    required this.id,
    required this.entities,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, entities, imagePath];
}