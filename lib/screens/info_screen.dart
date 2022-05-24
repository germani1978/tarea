import 'package:flutter/material.dart';
import 'package:notas/widgets/widgets.dart';

String text1 = '''Un día de 1918, en su búsqueda por aumentar la eficiencia de su equipo y descubrir mejores formas de hacer las cosas, Schwab organizó una reunión con una consultora de productividad muy respetada llamada Ivy Lee.Lee fue un exitoso hombre de negocios por derecho propio y es ampliamente recordado como un pionero en el campo de las relaciones públicas. Según cuenta la historia, Schwab llevó a Lee a su oficina y le dijo: “Muéstrame una manera de hacer más cosas”.“Dame 15 minutos con cada uno de tus ejecutivos”, respondió Lee.“¿Cuánto me costará?”, preguntó Schwab.“Nada”, dijo Lee. A menos que funcione. Después de tres meses, puede enviarme un cheque por lo que crea que vale la pena para usted”.El método Ivy Lee Durante sus 15 minutos con cada ejecutivo,Ivy Lee explicó su sencilla rutina diaria para lograr la máxima productividad: 

''';
String text2 = '''
1- Al final de cada día de trabajo, anota las seis cosas más importantes que debes lograr mañana.

2- No escriba más de seis tareas.

3- Priorice esos seis elementos en orden de su verdadera importancia.

4- Cuando llegues mañana, concéntrate solo en la primera tarea. 

5- Trabaje hasta que termine la primera tarea antes de pasar a la segunda tarea.

6- Acérquese al resto de su lista de la misma manera.

7- Al final del día, mueva los elementos sin terminar a una nueva lista de seis tareas para el día siguiente.

8- Repita este proceso todos los días hábiles.

 ''';

String text3 = '''La estrategia parecía simple, pero Schwab y su equipo ejecutivo en Bethlehem Steel la intentaron. Después de tres meses, Schwab estaba tan encantado con el progreso que había logrado su compañía que llamó a Lee a su oficina y le hizo un cheque por \$25,000.Un cheque de \$25,000 escrito en 1918 es el equivalente a un cheque de \$400,000 en 2015. ''';

class InfoScreen extends StatelessWidget {
  const InfoScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text('El método Ivy Lee' , style: fontGoogle( size: 22, spacing: 1, color: Colors.white ,weight: FontWeight.w200) ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: text1, 
                      style: TextStyle( color: Colors.black),
                      children: [
                        TextSpan(
                          text: text2,
                          style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold),
                         ),
                        TextSpan(
                          text: text3,
                          style: TextStyle( color: Colors.black),
                        ),
                        
                      ],

                  ),
              
            ),
          ),
        ),
      )
    );
  }
}