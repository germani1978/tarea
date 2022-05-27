import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notas/model/task.dart';
import 'package:notas/services/datosLocal.dart';

part 'tarea_event.dart';
part 'tarea_state.dart';

class TareaBloc extends Bloc<TareaEvent, TareaState> {

  TareaBloc() : super(TareaInitial()) {

    on<cargarTareas>((event, emit) async {
      Tareas tareas = await Datos().cargarTareas();
      emit( TareaLoad(tareasNew: tareas) );
      // emit(state.copyWith( isLoading: false, tareas: tareas ));
      print('ya Tareas Load');
    });


    on<agregarTarea>((event, emit) async {
      Tareas tareas = state.tareas!.copyWith();
      tareas.agregaElem(event.tarea);
      await Datos().saveData(tareas);
      emit( TareaLoad(tareasNew: tareas) );
      // emit( state.copyWith(tareas: tareas) );
    });


    on<eliminarTarea>((event, emit) async {
      final datos = Datos();
      Tareas tareas = state.tareas!.copyWith();
      tareas.eliminaElemIndex(event.index);
      await datos.saveData(tareas);
      emit( TareaLoad(tareasNew: tareas) );
    });


    on<invertStateTarea>((event, emit) async {
      Tareas tareas = state.tareas!.copyWith();  
      tareas.lista[event.index].realizada = !tareas.lista[event.index].realizada;
      await Datos().saveData(tareas);
      emit( TareaLoad(tareasNew: tareas) );
    });


    on<interCambiaPos>((event, emit) async{
        int oldI = event.oldIndex;
        int newI = event.newIndex;
        if (oldI < newI) {
             newI -= 1;
        }
        Tareas tareas = state.tareas!.copyWith();
        final task = tareas.lista.removeAt(oldI);
        tareas.lista.insert(newI, task);
        emit( TareaLoad(tareasNew: tareas) );
    });

  }
}
