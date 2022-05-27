import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notas/model/task.dart';
import 'dart:convert';

class Datos {

  Datos._private();
  static final Datos _instance = Datos._private();
  factory Datos() { return _instance; }
  
  late FlutterSecureStorage storage;

  Future<Tareas> cargarTareas() async {
    //  yaTieneDatos = false; 
     storage = FlutterSecureStorage();
     final rs = await storage.read(key: 'lista');
    //  yaTieneDatos = true;
     if (rs == null)  return Tareas([]);
     final aux = (json.decode(rs) as List).map((e) => e as Map<String,dynamic>).toList();
     return Tareas.fromMap(aux);  
  }

  Future saveData( Tareas tareas) async {
    await storage.write(key: 'lista', value: json.encode(tareas.toMap()));
  }
}