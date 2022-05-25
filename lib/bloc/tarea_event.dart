part of 'tarea_bloc.dart';

@immutable
abstract class TareaEvent {}

class agregarTarea extends TareaEvent {
  final Task tarea;
  agregarTarea(this.tarea);

}

class eliminarTarea extends TareaEvent {
  final int index;
  eliminarTarea(this.index);
  
}

class interCambiaPos extends TareaEvent {
  final int oldIndex, newIndex;
  interCambiaPos(this.oldIndex, this.newIndex);
}
