import 'package:mongo_dart/mongo_dart.dart';

class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.informacion,
    required this.horaCierre,
    required this.horaInicio,
  });

  ObjectId id;
  String nombre;
  String especialidad;
  String informacion;
  String horaCierre;
  String horaInicio;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    id: json["_id"],
    nombre: json["Nombre"] ?? '', 
    especialidad: json["Especialidad"] ?? '',
    informacion: json["Informacion"] ?? '',
    horaCierre: json["Hora cierre"] ?? '',
    horaInicio: json["Hora inicio"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Nombre": nombre,
    "Especialidad": especialidad,
    "Informacion": informacion,
    "Hora cierre": horaCierre,
    "Hora inicio": horaInicio,
  };
}
