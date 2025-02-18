import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'MongoDbModel.dart';
import 'paciente_screen.dart';

class registroScreen extends StatefulWidget {
  registroScreen({Key? key}) : super(key: key);
  @override
  _registroScreenState createState() => _registroScreenState();
}

class _registroScreenState extends State<registroScreen> {
  var nombreController = TextEditingController();
  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();
  
  Future<void> _registro(
      String nombre, String contrasena, String correo) async {
    if (contrasena.length < 8 ||
        !contrasena.contains(RegExp(r'[!@#$%^&*(),._":]'))) {
      _showErrorDialog(
          "La contraseña es muy corta o no contiene al menos 1 carácter especial");
      _limpiar();
      return;
    }

    bool? usuexistente =
        await MongoDatabase.getByusuario(nombre, correo); // Allow null return
    if (usuexistente == null || usuexistente) {
      _showErrorDialog(
          "Este usuario ya está registrado o hubo un error al verificar");
      _limpiar();
      return;
    }

    final _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id, nombre: nombre, contrasena: contrasena, correo: correo);
    var result = await MongoDatabase.insert(data);

    if (result == "Datos insertados ") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Datos insertados: " + _id.$oid)),
      );
      if (data != null) {
        // Ensure data is not null
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pacienteScreen(user: data),
          ),
        );
      } else {
        _showErrorDialog("Error al crear el modelo de datos");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrar: $result")),
      );
    }

    _limpiar();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _limpiar() {
    nombreController.clear();
    contrasenaController.clear();
    correoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: correoController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contrasenaController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _registro(nombreController.text, contrasenaController.text,
                        correoController.text);
                  },
                  child: Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
