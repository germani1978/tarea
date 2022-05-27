// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/bloc/tarea_bloc.dart';
import 'package:notas/model/task.dart';
import 'package:notas/screens/screens.dart';
import 'package:notas/style_font/styleFont.dart';
import 'package:notas/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void inicioDatos() {
    final tareasBloc = BlocProvider.of<TareaBloc>(context);
    tareasBloc.add(cargarTareas());
  }
  
  @override
  void initState() {
    inicioDatos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final tareasBloc = BlocProvider.of<TareaBloc>(context);

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: notasAppBar(context),
        body: BlocBuilder<TareaBloc, TareaState>(
          builder: (context, state) {
            // return Container();
            return tareasBloc.state is TareaInitial  
                      ? Center(child: CircularProgressIndicator())
                      : notaListView( context);
          },
        ),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: btnAddTask(context, width));
  }

  ReorderableListView notaListView( BuildContext context) {
    final tareasBloc = BlocProvider.of<TareaBloc>(context);
    final listaTareas = tareasBloc.state.tareas?.lista ?? [];
    

    return ReorderableListView.builder(
              itemCount: listaTareas.length,
              onReorder: (int oldIndex, int newIndex) { 
                tareasBloc.add(interCambiaPos(oldIndex, newIndex));
              },
              itemBuilder: (context, index) => Container(
                              key: Key('$index'),
                              child: tareaTile(listaTareas, index),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                           ), 
            );
  }


  FloatingActionButton btnAddTask(BuildContext context, double width) {

    return FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add Task', style: fontGoogle(size: 15, weight: FontWeight.w400,spacing: 0.5 )),
        backgroundColor: Color.fromRGBO(1, 41, 241, 0.65),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          final tareasBloc = BlocProvider.of<TareaBloc>(context);
          if (tareasBloc.state is TareaLoad) {
            final textController = TextEditingController();
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Row(children: [
                        boxInputText(
                            width: width, textController: textController),
                        btnAddText(textController: textController),
                      ]),
                    ));
          }
        }
         
      );
  }

  AppBar notasAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Color(0xA10129F1),
        title: Text('Lista de Tareas', style: fontGoogle( size: 22, spacing: 1, color: Colors.white ,weight: FontWeight.w500) ),
        leading: Icon(Icons.assignment_turned_in, size: 33, ),
        actions: [ IconButton(onPressed: (() {
         Navigator.push(context, MaterialPageRoute(builder: (context) => InfoScreen() ));
        }), 
            icon: Icon(Icons.info_outline))
          ],
      );
  }

  ListTile tareaTile(List<Task> listaTareas, int index) {

    final tareasBloc = BlocProvider.of<TareaBloc>(context);

    return ListTile(
      // leading: Text('$index',style: fontGoogle( color:  Color(0xA10129F1) )),
      title: Text('${listaTareas[index].task}',
          style:!listaTareas[index].realizada ? StyleTextUno() : StyleTextDos()),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Color.fromARGB(255, 161, 173, 180),), 
        onPressed: () {
         tareasBloc.add(eliminarTarea(index));
        }
      ,),
      onTap: ()  {
         tareasBloc.add(invertStateTarea(index)); 
      },
    );
  }
}

class boxInputText extends StatelessWidget {

  
  const boxInputText({
    Key? key,
    required this.width,
    required this.textController,
  }) : super(key: key);

  final double width;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {

    final tareasBloc = BlocProvider.of<TareaBloc>(context);

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
                final val = value.trim();
                if (val != "") {
                  tareasBloc.add( agregarTarea( val ));
                  Navigator.pop(context);
                }
              } 
      ),
    );
  }
}

class btnAddText extends StatelessWidget {

  const btnAddText({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {

    final tareasBloc = BlocProvider.of<TareaBloc>(context);

    return ElevatedButton(
        onPressed: ()  {
          final val = textController.text.trim();  
          if (val.length > 0)    {
            tareasBloc.add( agregarTarea( textController.text.trim()) );
            Navigator.pop(context);
          }
        },
        child: Text('Agregar', style: fontGoogle( size: 12, spacing: 0.5, weight: FontWeight.w600)),
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)));
  }
}


