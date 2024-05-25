import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'paciente_screen.dart';

class registroScreen extends StatefulWidget {
  @override
  _registroScreenState createState() => _registroScreenState();
}

class _registroScreenState extends State<registroScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  Future<void> _registro(BuildContext context) async {
    final String mongoUrl =
        'mongodb+srv://admin:admin1@consutorio.sisyumk.mongodb.net/test?retryWrites=true&w=majority&appName=consutorio';

    final Map<String, String> userData = {
      'nombre': _nombreController.text,
      'correo': _correoController.text,
      'contrasena': _contrasenaController.text, // Hash and salt password before sending
    };

    final response = await http.post(
      Uri.parse('$mongoUrl/paciente'), // Endpoint for user registration
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pacienteScreen()),
      );
    } else {
      // Handle registration error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrarse')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
            TextField(
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _registro(context),
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}