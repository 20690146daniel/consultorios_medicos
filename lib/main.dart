import 'package:flutter/material.dart';
//import 'login_screen.dart';
// import 'menuMedic_screen.dart';
//import 'registro_screen.dart';
//import 'medico_screen.dart';
import 'inicio_screen.dart';
//import 'paciente_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consultorios Médicos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
       '/': (context) => inicioScreen(),
       // '/': (context) => pacienteScreen(),
      //   '/': (context) => menuMedicScreen(),
      },
    );
  }
}