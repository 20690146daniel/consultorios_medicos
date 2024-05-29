import 'package:mongo_dart/mongo_dart.dart';

class DoctorModel {
  DoctorModel({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.informacion,
  });

  ObjectId id;
  String nombre;
  String especialidad;
  String informacion;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json["_id"],
    nombre: json["Nombre"] ?? '',
    especialidad: json["Especialidad"] ?? '',
    informacion: json["Informacion"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Nombre": nombre,
    "Especialidad": especialidad,
    "Informacion": informacion,
  };
}
