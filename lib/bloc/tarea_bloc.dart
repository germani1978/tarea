import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tarea_event.dart';
part 'tarea_state.dart';

class TareaBloc extends Bloc<TareaEvent, TareaState> {
  TareaBloc() : super(TareaInitial()) {
    on<TareaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
