import 'package:mongo_dart/mongo_dart.dart';
import 'package:consultorios_medicos/conexion/constantes.dart'; 
//import 'dart:io' show Platform; 
import 'package:flutter/foundation.dart'; 
import 'package:consultorios_medicos/MongoDbModel.dart';

class MongoDatabase {
  static var  userCollection;
   Future<void> connect() async {
    try {
      var db = await Db.create(mongoUrl);

      if (kIsWeb) {
        print('Ejecutando en la web');
      }

      await db.open();
      print('¡Conectado a MongoDB Atlas!');
      userCollection = db.collection(collection_name);
     
    } catch (e) {
      print('Error al conectarse a MongoDB Atlas: $e');
    } 
  }
static Future<List<Map<String, dynamic>>> getData() async {
  final cursor = await userCollection.find();
  final data = await cursor.toList();
  return data;
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
}
