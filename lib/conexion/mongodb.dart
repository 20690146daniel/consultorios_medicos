import 'package:mongo_dart/mongo_dart.dart';
import 'package:consultorios_medicos/conexion/constantes.dart'; 
//import 'dart:io' show Platform; 
import 'package:flutter/foundation.dart'; 
import 'package:consultorios_medicos/MongoDbModel.dart';

class MongoDatabase {
  static var  userCollection,medicoCollection;
   Future<void> connect() async {
    try {
      var db = await Db.create(mongoUrl);

      if (kIsWeb) {
        print('Ejecutando en la web');
      }

      await db.open();
      print('¡Conectado a MongoDB Atlas!');
      userCollection = db.collection(collection_name);
      medicoCollection = db.collection(collection_medico);
     
    } catch (e) {
      print('Error al conectarse a MongoDB Atlas: $e');
    } 
  }
static Future<List<Map<String, dynamic>>> getData() async {
  final arrData = await medicoCollection.find().toList();
  return arrData;
}
  static Future<String> insert(MongoDbModel data ) async {
    try{
      var result =await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Datos insertados ";
      }else {
        return "Algunos datos no fueron insertados";

      }

    } catch (e){
      print(e.toString());
      return e.toString();
    }
  }
  static Future<MongoDbModel?> getUser(String correo, String contrasena) async {
    var user = await userCollection.findOne({
      'correo': correo,
      'contrasena': contrasena,
    });

    if (user != null) {
      return MongoDbModel.fromMap(user);
    } else {
      return null;
    }
  }

   // Método para verificar la existencia de un usuario por nombre y correo electrónico
  static Future<bool> getByusuario(String nombre, String correo) async {
    try{
    var user = await userCollection.findOne({
      'nombre': nombre,
      'correo': correo,
    });

    return user != null;
  }catch(e){
    print('Error al buscar usuario en la base de datos: $e');
    return false;
  }
}
}
