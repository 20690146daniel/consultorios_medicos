import 'package:mongo_dart/mongo_dart.dart';
import 'constantes.dart'; 
import 'dart:io' show Platform; 
import 'package:flutter/foundation.dart'; 

class MongoDatabase {
   Future<void> connect() async {
    try {
      var db = await Db.create(mongoUrl);

      if (kIsWeb) {
        print('Ejecutando en la web');
      }

      await db.open();
      print('¡Conectado a MongoDB Atlas!');
     
    } catch (e) {
      print('Error al conectarse a MongoDB Atlas: $e');
    } 
  }
}