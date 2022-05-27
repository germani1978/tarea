// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notas/bloc/tarea_bloc.dart';
import 'package:notas/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => TareaBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.green[30],
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xA10129F1),
            // color: Colors.black,
            // elevation: 0,
          ),  
        ),
      ),
    );
  }

}