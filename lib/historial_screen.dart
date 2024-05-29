import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:consultorios_medicos/citasModel.dart';

class historialScreen extends StatefulWidget {
  final String pacienteNombre;
  const historialScreen({Key? key, required this.pacienteNombre}) : super(key: key);

  @override
  _historialScreenState createState() => _historialScreenState();
}

class _historialScreenState extends State<historialScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Center(
          child: Text(
            'Historial de citas',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
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
                  child: Text(
                    "Error al cargar los datos.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var citasUsuario = snapshot.data!
                    .where((cita) => cita['pacienteNombre'] == widget.pacienteNombre)
                    .map((cita) {
                  DateTime fechaCita = DateTime.parse(cita['fecha']);
                  if (fechaCita.isBefore(DateTime.now()) && cita['status'] != 'Cancelado') {
                    cita['status'] = 'Atendida';
                  }
                  return cita;
                }).toList();

                if (citasUsuario.isNotEmpty) {
                  return ListView.builder(
                    itemCount: citasUsuario.length,
                    itemBuilder: (context, index) {
                      return displayCard(CitaModel.fromJson(citasUsuario[index]));
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "No hay citas para mostrar.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              } else {
                return Center(
                  child: Text(
                    "No disponible",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Doctor: ${data.doctorNombre}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Paciente: ${data.pacienteNombre}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Fecha: ${data.fecha.toLocal()}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Hora de inicio: ${data.hora}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 5),

            Text(
              "Estado: ${data.status}",
              style: TextStyle(
                fontSize: 14,
                color: data.status == 'Atendida' ? Colors.green : Colors.red,
              ),
            ),

            Text("Estado: ${data.status}"),
            SizedBox(height: 10),
            if (data.status == "En espera")
              OutlinedButton(
                onPressed: () async {
                  await MongoDatabase.updateCitaStatus(data.id, "Cancelado");
                  setState(() {});
                },
                child: Text("Cancelar"),
              ),
          ],
        ),
      ),
    );
  }
}
