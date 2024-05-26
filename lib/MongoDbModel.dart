
//final mongolibModel mongolbModelFromJson(jsonString);

import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.nombre,
    required this.contrasena,
    required this.correo,
  });

  ObjectId id;
  String nombre;
  String contrasena;
  String correo;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    nombre: json["Nombre"],
    contrasena: json["Contraseña"],
    correo: json["Correo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Nombre": nombre,
    "Contraseña": contrasena,
    "Correo": correo,
  };
}
