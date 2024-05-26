import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'mongodbmodel.dart';

class registroScreen extends StatefulWidget { 
  registroScreen({Key? key }) : super(key: key);
  @override
  _registroScreenState createState() => _registroScreenState();
}

class _registroScreenState extends State<registroScreen> {
  var nombreController = TextEditingController();
  var correoController = TextEditingController();
  var contrasenaController = TextEditingController();

  Future<void> _registro(String nombre, String contrasena, String correo) async {
    final _id = M.ObjectId();
    final data = MongoDbModel(id: _id, nombre: nombre, contrasena: contrasena, correo: correo);
   //var result = await MongoDatabase.insert(data);


       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Datos insertados: " + _id.$oid))
    );

     _limpiar();
  }
  void _limpiar(){
    nombreController.text ="";
    contrasenaController.text ="";
    correoController.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Médicos'),
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
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
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
                  _registro(nombreController.text, contrasenaController.text, correoController.text);
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}