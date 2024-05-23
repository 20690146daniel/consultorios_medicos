import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registro_screen.dart';
import 'medico_screen.dart';


class inicioScreen extends StatefulWidget {
  @override
  _inicioScreenState createState() => _inicioScreenState();
}

class _inicioScreenState extends State<inicioScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Consultorios Médicos',
            style: TextStyle(
              color: Colors.blue, 
              fontSize: 24, 
            ),
          ),
        ),
        bottom: TabBar(
          labelColor: Colors.blue, 
          unselectedLabelColor: Colors.blueGrey, 
          labelStyle: TextStyle(
            fontSize: 18, 
            fontWeight: FontWeight.bold, 
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16, 
          ),
          controller: _tabController,
          tabs: [
            Tab(text: 'Pacientes'),
            Tab(text: 'Registrarse'),
            Tab(text: 'Médico'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          loginScreen(),
          registroScreen(),
          medicoScreen(),
        ],
      ),
    );
  }
}