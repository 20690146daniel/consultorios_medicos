

import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:consultorios_medicos/ScheduleModel.dart';

class listaScreen extends StatefulWidget {
  const listaScreen({super.key});

  @override
  _listaScreenState createState() => _listaScreenState();
}

class _listaScreenState extends State<listaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'MEDICOS DISPONIBLES',
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
          child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var totalData = snapshot.data.length;
                print("**TOTAL MEDICOS** " + totalData.toString());
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return displayCard(
                      ScheduleModel.fromJson(snapshot.data[index]),
                    );
                  },
                );
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

  Widget displayCard(ScheduleModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${data.id.toHexString()}"),
            SizedBox(height: 5),
            Text("${data.nombre}"),
            SizedBox(height: 5),
            Text("${data.especialidad}"),
            SizedBox(height: 5),
            Text("${data.informacion}"),
            SizedBox(height: 5),
            Text("Hora de inicio: ${data.horaInicio}"),
            SizedBox(height: 5),
            Text("Hora de cierre: ${data.horaCierre}"),
          ],
        ),
      ),
    );
  }
}
