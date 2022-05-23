// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notas/model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late FlutterSecureStorage storage;
  late ListaTareas datos;
  late bool datosCargados;

  void inicioDatos() async {
    datosCargados = false;
    storage = FlutterSecureStorage();
    String? lista = await storage.read(key: 'lista');
    if (lista != null) {
      final aux = (json.decode(lista) as List).map((elem) => elem as Map<String,dynamic>).toList(); 
      datos = (lista != null)
        ? ListaTareas.fromMap(aux)
        : ListaTareas([]);
      datosCargados = true;
      setState(() {
        
      });
    }
  }

  @override
  void initState() {
    inicioDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(title: Text('Tareas'),),
        body: datosCargados
            ? ListView.builder(
                itemCount: datos.listaTareas.length,
                itemBuilder: ((context, index) => Container(
                      child: tareas(datos.listaTareas, index),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )),
              )
            : Center(child: CircularProgressIndicator()),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Task'),
          backgroundColor: Colors.black,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: datosCargados ? () {
            final textController = TextEditingController();
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Row(children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          width: width * 0.8,
                          child: TextField(controller: textController,autofocus: true, onSubmitted: (value) async{
                              datos.agregaElem(value.trim());
                              final m = json.encode(datos.toMap());
                              await storage.write(key: 'lista', value: m);
                              Navigator.pop(context);
                            
                          } ,),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              final task = textController.text.trim();
                              datos.agregaElem(task);
                              final m = json.encode(datos.toMap());
                              await storage.write(key: 'lista', value: m);
                              Navigator.pop(context);
                            },
                            child: Text('Add'),
                            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black))),
                      ]),
                    ));
          }
          : null,
        ));
  }

  ListTile tareas(List<Task> listaTareas, int index) {
    return ListTile(
      title: Text(listaTareas[index].task,
          style:!listaTareas[index].realizada ? StyleTextUno() : StyleTextDos()),
      onTap: () async {
          listaTareas[index].realizada = !listaTareas[index].realizada;
          final m = json.encode(datos.toMap());
          await storage.write(key: 'lista', value: m);
        setState(() {
        });
      },
      onLongPress: () async{
          listaTareas.removeAt(index);
          final m = json.encode(datos.toMap());
          await storage.write(key: 'lista', value: m);
        setState(() {
        });
      },
    );
  }
}

TextStyle StyleTextUno() =>TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
TextStyle StyleTextDos() => TextStyle(fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.lineThrough);
