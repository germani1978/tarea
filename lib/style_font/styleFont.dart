import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle StyleTextUno() => GoogleFonts.montserrat(
  fontSize: 19,
  fontWeight: FontWeight.w700,
  color: Color.fromARGB(255, 24, 27, 106)
);

TextStyle StyleTextDos() => GoogleFonts.montserrat (
   fontWeight: FontWeight.w700,
   fontSize: 19,
   decoration: TextDecoration.lineThrough,
  color: Color.fromARGB(255, 24, 27, 106)

 );

 
// TextStyle StyleTextUno() => TextStyle(
//   fontSize: 18,
//   fontWeight: FontWeight.bold,
//   color: Colors.black
// );

// TextStyle StyleTextDos() => TextStyle(
//    fontWeight: FontWeight.bold,
//    fontSize: 18,
//    decoration: TextDecoration.lineThrough,
//  );

