import 'package:mongo_dart/mongo_dart.dart';
import 'package:consultorios_medicos/conexion/constantes.dart';
//import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:consultorios_medicos/MongoDbModel.dart';
import 'package:consultorios_medicos/citasModel.dart';

class MongoDatabase {
  static var userCollection, medicoCollection, collection, citasCollection;
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
      collection = db.collection(collection_medico);
      citasCollection = db.collection(collection_cita);
    } catch (e) {
      print('Error al conectarse a MongoDB Atlas: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getDoctorData() async {
    final doctors = await collection.find().toList();
    return doctors;
  }

  static Future<void> agendarCita(CitaModel cita) async {
    await citasCollection.insert(cita.toJson());
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await medicoCollection.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Datos insertados ";
      } else {
        return "Algunos datos no fueron insertados";
      }
    } catch (e) {
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

  static Future<void> insertarCita(Map<String, dynamic> data) async {
    await collection.insertOne(data);
  }

  static Future<List<Map<String, dynamic>>> getHistorial() async {
    final historial = await citasCollection.find().toList();
    return List<Map<String, dynamic>>.from(historial);
  }

  static Future<void> updateCitaStatus(ObjectId id, String newStatus) async {
    await citasCollection.update(
      where.id(id),
      modify.set('status', newStatus),
    );
  }
}
