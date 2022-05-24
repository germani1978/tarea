// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notas/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0,
        ),
        // appBarTheme: AppBarTheme(
        //   color: Colors.black26,
        //   elevation: 0,
        // ),
      ),
    );
  }

}