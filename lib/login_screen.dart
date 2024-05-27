import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'paciente_screen.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();

  Future<void> _login(String correo, String contrasena) async {
    var user = await MongoDatabase.getUser(correo, contrasena);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inicio de sesión exitoso")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => pacienteScreen(user: user), 
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correo o contraseña incorrectos")),
      );
    }

    _limpiar();
  }

  void _limpiar(){
    correoController.text = "";
    contrasenaController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text('Inicio de Sesión'),
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
              TextField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                controller: contrasenaController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(correoController.text, contrasenaController.text);
                },
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
