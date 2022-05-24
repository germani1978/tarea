import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle fontGoogle( {double size = 18, bool marcadoHecho = false , FontWeight weight = FontWeight.bold , Color color = Colors.white ,double? spacing = null }) {
  return GoogleFonts.montserrat(
    fontSize: size,
    decoration: marcadoHecho ? TextDecoration.lineThrough : null,
    fontWeight: weight,
    color: color,
    letterSpacing: spacing,
  );
}