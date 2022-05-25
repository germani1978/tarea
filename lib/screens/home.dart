// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/bloc/tarea_bloc.dart';
import 'package:notas/model/task.dart';
import 'package:notas/screens/screens.dart';
import 'package:notas/services/datosLocal.dart';
import 'package:notas/style_font/styleFont.dart';
import 'package:notas/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // late FlutterSecureStorage storage;
  // late ListaTareas datos;

  late Datos datos;
  late bool datosCargados;
  late Tareas tareas;

  void inicioDatos() async {

    final tareasBloc = BlocProvider.of<TareaBloc>(context);

    datos = Datos();
    datosCargados = Datos.yaTieneDatos;
    tareas = await datos.cargarTareas();
    setState(() {
      datosCargados = Datos.yaTieneDatos;
    });
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
        appBar: notasAppBar(context),
        body: datosCargados
            ? notaListView()
            : Center(child: CircularProgressIndicator()),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: btnAddTask(context, width));
  }

  ReorderableListView notaListView() {
    return ReorderableListView.builder(
              itemCount: tareas.lista.length,
              onReorder: (int oldIndex, int newIndex) { 
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Task task = tareas.lista.removeAt(oldIndex);
                  tareas.lista.insert(newIndex, task);
                  datos.saveData(tareas);
                });
              },
              itemBuilder: (context, index) => Container(
                              key: Key('$index'),
                              child: tareaTile(tareas.lista, index),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                           ), 
            );
  }


  FloatingActionButton btnAddTask(BuildContext context, double width) {
    return FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add Task', style: fontGoogle(size: 15, weight: FontWeight.w400,spacing: 0.5 )),
        backgroundColor: Colors.black,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: datosCargados ? () {
          final textController = TextEditingController();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Row(children: [
                      boxInputText(width: width, textController: textController, datos: datos, tareas: tareas,),
                      btnAddText(textController: textController, datos: datos, tareas: tareas,),
                    ]),
                  ));
        }
        : null,
      );
  }

  AppBar notasAppBar(BuildContext context) {
    return AppBar(
        // backgroundColor: Colors.black,
        title: Text('Lista de Tareas', style: fontGoogle( size: 22, spacing: 1, color: Colors.white ,weight: FontWeight.w200) ),
        leading: Icon(Icons.assignment_turned_in, size: 33),
        actions: [ IconButton(onPressed: (() {
         Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen() ));
        }), 
            icon: Icon(Icons.info_outline))
          ],
      );
  }

  ListTile tareaTile(List<Task> listaTareas, int index) {
    return ListTile(
      title: Text('${listaTareas[index].task}',
          style:!listaTareas[index].realizada ? StyleTextUno() : StyleTextDos()),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.blueGrey[300],), 
        onPressed: () {
          setState(() {
            listaTareas.removeAt(index);
          });
        }
      ,),
      onTap: () async {
          listaTareas[index].realizada = !listaTareas[index].realizada;
          await datos.saveData(tareas);
        setState(() {
        });
      },
    );
  }
}

class boxInputText extends StatelessWidget {
  const boxInputText({
    Key? key,
    required this.width,
    required this.textController,
    required this.tareas,
    required this.datos,
    

  }) : super(key: key);

  final double width;
  final TextEditingController textController;
  final Tareas tareas;
  final Datos datos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: width * 0.75,
      child: TextField( 
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              controller: textController,
              style: StyleTextUno(),
              autofocus: true, 
              onSubmitted: (value) async{
                  tareas.agregaElem(value.trim());
                  await datos.saveData(tareas);
                  Navigator.pop(context);
              } 
      ),
    );
  }
}

class btnAddText extends StatelessWidget {
  const btnAddText({
    Key? key,
    required this.textController,
    required this.tareas,
    required this.datos,
  }) : super(key: key);

  final TextEditingController textController;
   final Tareas tareas;
  final Datos datos;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final task = textController.text.trim();
          tareas.agregaElem(task);
          // final m = json.encode(tareas.toMap());
          await datos.saveData(tareas);

          Navigator.pop(context);
        },
        child: Text('Agregar', style: fontGoogle( size: 12, spacing: 0.5, weight: FontWeight.w600)),
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)));
  }
}


