import 'package:flutter/material.dart';
import 'inicio_screen.dart'; 
import 'mongodb.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   final mongoDatabase = MongoDatabase();
   await mongoDatabase.connect();

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consultorios Médicos', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => inicioScreen(), 
        
      },
    );
  }
}