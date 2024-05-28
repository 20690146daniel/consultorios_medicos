import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:consultorios_medicos/doctorModel.dart';
import 'package:consultorios_medicos/citas_creen.dart';

class buscarDoctorScreen extends StatefulWidget {
  final String pacienteNombre;

  const buscarDoctorScreen({Key? key, required this.pacienteNombre}) : super(key: key);

  @override
  _buscarDoctorScreenState createState() => _buscarDoctorScreenState();
}

class _buscarDoctorScreenState extends State<buscarDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Center(
          child: Text(
            'Agendar Cita',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: MongoDatabase.getDoctorData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(doctors[index]);
                return ListTile(
                  title: Text(doctor.nombre),
                  subtitle: Text(doctor.especialidad),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CitasScreen(
                          doctor: doctor,
                          pacienteNombre: widget.pacienteNombre,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No hay doctores disponibles'));
          }
        },
      ),
    );
  }
}