import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_add_event.dart';
part 'event_add_state.dart';

class EventAddBloc extends Bloc<EventAddEvent, EventAddState> {
  EventAddBloc() : super(EventAddInitial()) {
    on<EventAddEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
