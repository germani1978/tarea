class Task {
  //propiedades
  String task;
  bool realizada;

  @override
 String toString() {
   return task;
 }

  //constructor
  Task({required this.task, this.realizada = false});

  //Metodos
  Map<String,dynamic> toMap() => { "task": task,"realizada" : realizada};  

}

class Tareas {
  //propiedades
 List<Task> lista = [];

 @override
 String toString() {
   return lista.toString();
 }

  //constructor
  Tareas(this.lista);
  Tareas.fromMap(List<Map<String, dynamic>> listMap ){
    lista = listMap.map((task) => Task( task: task['task'], realizada: task['realizada']) ).toList();
  }
  Tareas copyWith() {
    return Tareas(this.lista.map((e) => e).toList());
  }


  //metodos
  List<Map<String, dynamic>> toMap() => lista.map((task) => task.toMap()).toList();
  agregaElem(String elem) => lista.add(Task(task: elem));
  eliminaElemIndex(int index) =>lista.removeAt(index);
}
