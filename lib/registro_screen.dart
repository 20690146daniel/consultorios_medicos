import 'package:flutter/material.dart';

class registroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(

      //padding: const EdgeInsets.all(16.0),
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
        child:  Column(
          mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Usuario'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Accion de registro
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
      ),
    );
  }
}