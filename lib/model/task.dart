class Task {
  //propiedades
  String task;
  bool realizada;

  //constructor
  Task({required this.task, this.realizada = false});

  //Metodos
  Map<String,dynamic> toMap() => { "task": task,"realizada" : realizada};  

}

class ListaTareas {
  //propiedades
  late List<Task> listaTareas;

  //constructor
  ListaTareas(this.listaTareas);
  ListaTareas.fromMap(List<Map<String, dynamic>> listMap ){
    listaTareas = listMap.map((task) => Task( task: task['task'], realizada: task['realizada']) ).toList();
  }


  //metodos
  List<Map<String, dynamic>> toMap() => listaTareas.map((task) => task.toMap()).toList();
  agregaElem(String elem) => listaTareas.add(Task(task: elem));
  eliminaElemIndex(int index) =>listaTareas.removeAt(index);
}
