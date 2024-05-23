import 'package:flutter/material.dart';
import 'lista_screen.dart';
import 'historial_screen.dart';
import 'citas_creen.dart';
import 'perfil_screen.dart';

class pacienteScreen extends StatefulWidget {
  const pacienteScreen({super.key});

  @override
  State<pacienteScreen> createState() => _pacienteScreenState();
}

class _pacienteScreenState extends State<pacienteScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const listaScreen(),
    const historialScreen(),
    const citasScreen(),
    const perfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consultorios Médicos',
          style: TextStyle(
            color: Colors.greenAccent,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.blueGrey,),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.blueGrey,),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.blueGrey,),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blueGrey,),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.blueGrey,
      ),
    );
  }
}