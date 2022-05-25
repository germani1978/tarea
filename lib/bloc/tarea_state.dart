part of 'tarea_bloc.dart';

@immutable
abstract class TareaState {
  bool isLoading = true;
  Tareas? tareas;
}

class TareaInitial extends TareaState {
  TareaInitial() {
    isLoading = true;
  }
}

class SetTarea extends TareaState {
  Tareas setTarea;
  SetTarea({required this.setTarea}) {
    tareas = setTarea;
    isLoading = false;
  }
}
