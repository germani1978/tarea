import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle StyleTextUno() => GoogleFonts.montserrat(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black
);

TextStyle StyleTextDos() => GoogleFonts.montserrat (
   fontWeight: FontWeight.bold,
   fontSize: 18,
   decoration: TextDecoration.lineThrough,
 );
