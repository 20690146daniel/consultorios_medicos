import 'package:consultorios_medicos/conexion/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:consultorios_medicos/MongoDbModel.dart';

class listaScreen extends StatefulWidget {
  const listaScreen({super.key});

  @override
 _listaScreenState createState() => _listaScreenState();
}

class _listaScreenState extends State<listaScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
          
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else {
              if(snapshot.hasData){
                var totalData = snapshot.data.length;
                print("**TOTAL MEDICOS**" + totalData.toString());
                return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return displayCard(MongoDbModel.fromJson(snapshot.data[index]));
          
                });
              }else{
                return Center(
                  child: Text("no disponible"),
                  
                  );
              } 
            }
          }),
        )),
    );
  }
 Widget displayCard(MongoDbModel data){
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text("${data.nombre}"),
          SizedBox(height: 5),
          Text("${data.correo}"),
        ],
      
        ),
    ),);
 }

}