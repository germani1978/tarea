// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notas/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeScreen(),
      // theme: ThemeCustom(),
    );
  }

  ThemeData ThemeCustom() {
    return ThemeData().copyWith(
      appBarTheme: AppBarTheme(
        // backgroundColor: Colors.black12,
        elevation: 0,
        titleTextStyle: TextStyle(
          // color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
    );    
  }

}