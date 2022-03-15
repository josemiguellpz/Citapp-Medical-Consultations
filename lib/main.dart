import 'package:flutter/material.dart';
import 'pacienteScreen.dart';
import 'doctorScreen.dart';
import 'infoScreen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CITAPP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

/*
Cada Widget esta dentro de un Container
Los botones redirigen a otra ventana (Paciente, Doctor)
*/
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("MainScreen")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 80,
                width: double.infinity,
                child: Center(
                    child: Text("CITAPP",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 20)))),
            Container(
                height: 80,
                width: double.infinity,
                child: Center(
                    child: Text("Seleccione un modo",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 20)))),
            Container(
                child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PacienteScreen()));
              },
              child: Text(
                "Paciente",
                style: TextStyle(fontSize: 20),
              ),
            )),
            Container(
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DoctorScreen()));
                },
                child: Text(
                  "Medico",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfoScreen()));
                },
                child: Text(
                  "Nuestra app",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        )));
  }
}
