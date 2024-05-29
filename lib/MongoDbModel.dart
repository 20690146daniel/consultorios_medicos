import 'package:mongo_dart/mongo_dart.dart';

class MongoDbModel {
  final ObjectId id;
  final String nombre;
  final String correo;
  final String contrasena;

  MongoDbModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  factory MongoDbModel.fromMap(Map<String, dynamic> map) {
    return MongoDbModel(
      id: map['_id'] as ObjectId,
      nombre: map['nombre'] as String,
      correo: map['correo'] as String,
      contrasena: map['contrasena'] as String,
    );
  }
}
