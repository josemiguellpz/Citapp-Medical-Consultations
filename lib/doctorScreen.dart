import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_backspace),
                onPressed: () {
                  Navigator.pop(context);
                }),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: Text('Medico'),
          ),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                height: 1000,
                child: TabBarView(
                  children: [
                    ListaPacientesAceptados(),
                    ListaPacientesEspera(),
                  ],
                ))
          ])),
        ),
      ),
    );
  }
}

class ListaPacientesAceptados extends StatefulWidget {
  ListaPacientesAceptados({Key key}) : super(key: key);

  @override
  _ListaPacientesAceptadosState createState() =>
      _ListaPacientesAceptadosState();
}

class _ListaPacientesAceptadosState extends State<ListaPacientesAceptados> {
  List<int> indice = List<int>();
  List<String> nombres = List<String>();
  List<String> apellidos = List<String>();
  List<String> estados = List<String>();
  List<String> fechas = List<String>();
  List<String> horas = List<String>();
  List<String> motivos = List<String>();

  @override
  Widget build(BuildContext context) {
    void contar() {
      int numDatos = 0;
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("consultas")
          .where("estado", isEqualTo: "Aceptado")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          numDatos = numDatos + 1;
          indice.add(numDatos);
          nombres.add(result.get("nombre"));
          apellidos.add(result.get("apellido"));
          estados.add(result.get("estado"));
          fechas.add(result.get("fecha"));
          horas.add(result.get("hora"));
          motivos.add(result.get("motivo"));
        });
      });
    }

    contar();
    int tope = this.indice.length;
    return ListView.builder(
        itemCount: this.indice.length,
        itemBuilder: (context, index) {
          this.indice.length = 0;
          String nombre, apellido, estado, fecha, hora, motivo;
          var aux = index;
          for (var i = 0; i <= tope; i++) {
            if (i == aux) {
              nombre = nombres[i];
              apellido = apellidos[i];
              estado = estados[i];
              fecha = fechas[i];
              hora = horas[i];
              motivo = motivos[i];
            }
          }
          return Center(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                      elevation: 7.0,
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                          height: 180,
                          width: 250,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Nombre: " + nombre + " " + apellido),
                                  SizedBox(height: 10.0),
                                  Container(
                                    height: 0.5,
                                    width: double.infinity,
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text("Fecha: " + fecha),
                                  SizedBox(height: 15.0),
                                  Text("Hora: " + hora),
                                  SizedBox(height: 15.0),
                                  Text("Status: " + estado),
                                  SizedBox(height: 15.0),
                                  Text("Motivo: " + motivo),
                                ],
                              )))))); //Aqui
        });
  }
}

class ListaPacientesEspera extends StatefulWidget {
  ListaPacientesEspera({Key key}) : super(key: key);

  @override
  _ListaPacientesEsperaState createState() => _ListaPacientesEsperaState();
}

class _ListaPacientesEsperaState extends State<ListaPacientesEspera> {
  List<int> indice = List<int>();
  List<String> nombres = List<String>();
  List<String> apellidos = List<String>();
  List<String> estados = List<String>();
  List<String> fechas = List<String>();
  List<String> horas = List<String>();
  List<String> motivos = List<String>();

  @override
  Widget build(BuildContext context) {
    CollectionReference sto =
        FirebaseFirestore.instance.collection('consultas');
    Future<void> saveCita(
        String nombre, apellido, fecha, hora, motivo, estado) {
      return sto
          .add({
            'nombre': nombre,
            'apellido': apellido,
            'motivo': motivo,
            'fecha': fecha,
            'hora': hora,
            'estado': "Aceptado",
          })
          .then((value) => print("Cita agendada"))
          .catchError((error) => print("Error en: $error"));
    }

    void contar() {
      int numDatos = 0;
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("consultas")
          .where("estado", isEqualTo: "Espera")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          numDatos = numDatos + 1;
          indice.add(numDatos);
          nombres.add(result.get("nombre"));
          apellidos.add(result.get("apellido"));
          estados.add(result.get("estado"));
          fechas.add(result.get("fecha"));
          horas.add(result.get("hora"));
          motivos.add(result.get("motivo"));
        });
      });
    }

    contar();
    int tope = this.indice.length;
    return ListView.builder(
        itemCount: this.indice.length,
        itemBuilder: (context, index) {
          this.indice.length = 0;
          String nombre, apellido, estado, fecha, hora, motivo;
          var aux = index;
          for (var i = 0; i <= tope; i++) {
            if (i == aux) {
              nombre = nombres[i];
              apellido = apellidos[i];
              estado = estados[i];
              fecha = fechas[i];
              hora = horas[i];
              motivo = motivos[i];
            }
          }
          return Center(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Material(
                      elevation: 7.0,
                      borderRadius: BorderRadius.circular(7.0),
                      child: Container(
                          height: 220,
                          width: 250,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Nombre: " + nombre + " " + apellido),
                                  SizedBox(height: 10.0),
                                  Container(
                                    height: 0.5,
                                    width: double.infinity,
                                    color: Colors.red,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text("Fecha: " + fecha),
                                  SizedBox(height: 15.0),
                                  Text("Hora: " + hora),
                                  SizedBox(height: 15.0),
                                  Text("Status: " + estado),
                                  SizedBox(height: 15.0),
                                  Text("Motivo: " + motivo),
                                  RaisedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        //Widget de confirmacion
                                        builder: (context) => AlertDialog(
                                          title:
                                              Text("¿Desea confirmar la cita?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Si"),
                                              onPressed: () {
                                                Navigator.of(context).pop("Si");
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("No"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      ).then((result) {
                                        if (result == "Si") {
                                          saveCita(nombre, apellido, fecha,
                                              hora, motivo, estado);
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Aceptar",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              )))))); //Aqui
        });
  }
}
