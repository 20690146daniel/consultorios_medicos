import 'package:consultorios_medicos/inicio_screen.dart';
import 'package:flutter/material.dart';

class perfilScreen extends StatelessWidget {
  const perfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: _contrasenaController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),*/
            SizedBox(height: 20),
           ElevatedButton(
          onPressed: () => Navigator.push(
             context,
          MaterialPageRoute(builder: (context) => inicioScreen()),
  ),
  child: Text('Registrarse'),
),
          ],
        ),
      )
    );
  }
}