import 'package:mongo_dart/mongo_dart.dart';

class CitaModel {
  CitaModel(
      {required this.id,
      required this.doctorId,
      required this.doctorNombre,
      required this.fecha,
      required this.hora,
      required this.pacienteNombre,
      required this.status});

  ObjectId id;
  ObjectId doctorId;
  String doctorNombre;
  String pacienteNombre;
  DateTime fecha;
  String hora;
  String status;

  factory CitaModel.fromJson(Map<String, dynamic> json) {
    return CitaModel(
      id: json["_id"] as ObjectId,
      doctorId: json["doctorId"] as ObjectId,
      doctorNombre: json["doctorNombre"] as String? ?? '',
      pacienteNombre: json["pacienteNombre"] as String? ?? '',
      fecha: DateTime.parse(json["fecha"] as String),
      hora: json["hora"] as String? ?? '',
      status: json["status"] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "doctorId": doctorId,
        "doctorNombre": doctorNombre,
        "pacienteNombre": pacienteNombre,
        "fecha": fecha.toIso8601String(),
        "hora": hora,
        "status": status,
      };
}
