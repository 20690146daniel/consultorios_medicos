import 'package:consultorios_medicos/inicio_screen.dart';
import 'package:flutter/material.dart';
import 'MongoDbModel.dart';


class perfilScreen extends StatelessWidget {
  final MongoDbModel user;

  perfilScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.indigo,
        title: Center(
          child: Text(
            'Datos Personales',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre del Usuario: ${user.nombre}',selectionColor: Colors.deepOrange ,style: TextStyle(fontSize: 18)),
              Text('Correo: ${user.correo}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => inicioScreen(),
                    ),
                  );
                },
                child: Text('Cerrar Sesión'),
              ),
            ],
            
          ),
          

        ),
      ),
    );
  }
}
