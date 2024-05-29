import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:consultorios_medicos/doctorModel.dart';
import 'citas_creen.dart';  

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
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Center(
          child: Text(
            'Agendar Cita',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: MongoDatabase.getDoctorData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los datos',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No hay doctores disponibles',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            );
          } else {
            var doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(doctors[index]);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      doctor.nombre,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    subtitle: Text(
                      doctor.especialidad,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
