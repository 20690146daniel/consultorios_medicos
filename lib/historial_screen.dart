import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:consultorios_medicos/citasModel.dart';
import 'package:consultorios_medicos/MongoDbModel.dart'; // Importa tu modelo MongoDbModel

class historialScreen extends StatefulWidget {
  final String pacienteNombre;
  const historialScreen({Key? key, required this.pacienteNombre})
      : super(key: key);

  @override
  _historialScreenState createState() => _historialScreenState();
}

class _historialScreenState extends State<historialScreen> {
  // Variable para almacenar el nombre del usuario actual

  @override
  void initState() {
    super.initState();
    // Obtener el usuario actual cuando se inicializa el estado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Historial de citas',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: MongoDatabase.getHistorial(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print("Error en el FutureBuilder: ${snapshot.error}");
                return Center(
                  child: Text("Error al cargar los datos."),
                );
              } else if (snapshot.hasData) {
                var citasUsuario = snapshot.data!
                    .where((cita) =>
                        cita['pacienteNombre'] == widget.pacienteNombre)
                    .toList();
                if (citasUsuario.isNotEmpty) {
                  return ListView.builder(
                    itemCount: citasUsuario.length,
                    itemBuilder: (context, index) {
                      return displayCard(
                          CitaModel.fromJson(citasUsuario[index]));
                    },
                  );
                } else {
                  return Center(
                    child: Text("No hay citas para mostrar."),
                  );
                }
              } else {
                return Center(
                  child: Text("No disponible"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget displayCard(CitaModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Doctor: ${data.doctorNombre}"),
            SizedBox(height: 5),
            Text("Paciente: ${data.pacienteNombre}"),
            SizedBox(height: 5),
            Text("Fecha: ${data.fecha.toLocal()}"), // Muestra la fecha local
            SizedBox(height: 5),
            Text("Hora de inicio: ${data.hora}"),
          ],
        ),
      ),
    );
  }
}
