import 'package:flutter/material.dart';
import 'package:consultorios_medicos/conexion/constantes.dart';
import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:consultorios_medicos/citasModel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:consultorios_medicos/doctorModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class CitasScreen extends StatefulWidget {
  final DoctorModel doctor;
  final String pacienteNombre;

  const CitasScreen(
      {Key? key, required this.doctor, required this.pacienteNombre})
      : super(key: key);

  @override
  _CitasScreenState createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  DateTime _selectedDay = DateTime.now();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Agendar Cita',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Seleccione una fecha:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 365)),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    int roundedMinute = (pickedTime.minute / 30).round() * 30;
                    TimeOfDay adjustedTime = TimeOfDay(
                        hour: pickedTime.hour, minute: roundedMinute % 60);
                    if (roundedMinute >= 60) {
                      adjustedTime = TimeOfDay(
                          hour: (pickedTime.hour + 1) % 24, minute: 0);
                    }
                    setState(() {
                      _selectedTime = adjustedTime;
                    });
                  }
                },
                child: Text('Seleccionar Hora'),
              ),
              SizedBox(height: 20),
              if (_selectedTime != null)
                Text(
                  'Hora seleccionada: ${_selectedTime!.format(context)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedTime != null) {
                      final newCita = CitaModel(
                        id: mongo.ObjectId(),
                        doctorId: widget.doctor.id,
                        doctorNombre: widget.doctor.nombre,
                        pacienteNombre: widget.pacienteNombre,
                        fecha: _selectedDay,
                        hora: _selectedTime!.format(context),
                        status: "En espera",
                      );

                      await saveCita(newCita);
                    }
                  },
                  child: Text('Agendar Cita'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Volver'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveCita(CitaModel cita) async {
    final db = await mongo.Db.create(mongoUrl);
    await db.open();
    final collection = db.collection(collection_cita);
    await collection.insert(cita.toJson());
    await db.close();
  }
}
