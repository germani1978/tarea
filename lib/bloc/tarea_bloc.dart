import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notas/model/task.dart';

part 'tarea_event.dart';
part 'tarea_state.dart';

class TareaBloc extends Bloc<TareaEvent, TareaState> {
  TareaBloc() : super(TareaInitial()) {

    on<agregarTarea>((event, emit) {});

    on<eliminarTarea>((event, emit) {});

    on<interCambiaPos>((event, emit) {});
    
  }
}
