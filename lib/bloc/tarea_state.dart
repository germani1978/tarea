part of 'tarea_bloc.dart';


abstract class TareaState {
    Tareas? tareas;
    TareaState({this.tareas});
}

class TareaInitial extends TareaState {}

class TareaLoad extends TareaState {
  final Tareas tareasNew;
  TareaLoad({required this.tareasNew}){
    tareas = tareasNew;
    print(tareas);
  }
}
