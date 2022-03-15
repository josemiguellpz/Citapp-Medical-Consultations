import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text('Acerca de CITAPP'),
            ),
            body: new ListView(children: <Widget>[
              Align(alignment: Alignment.center, child: informacion()),
              Align(alignment: Alignment.center, child: integrantes())
            ])),
      ),
    );
  }

  Widget informacion() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                    height: 200,
                    width: 250,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          Text("Objetivo"),
                          SizedBox(height: 10.0),
                          Container(
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                              "Alcanzar la comodidad entre el médico y el paciente en cuanto a la flexiblidad y sencillez de hacer una consulta.",
                              textAlign: TextAlign.justify),
                          SizedBox(height: 15.0),
                          Text("Versión 0.0.1"),
                        ]))))));
  }

  Widget integrantes() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
                elevation: 7.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                    height: 130,
                    width: 250,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(children: <Widget>[
                          Text("Equipo de desarrollo"),
                          SizedBox(height: 10.0),
                          Container(
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                          SizedBox(height: 10.0),
                          Text("José Miguel López Aguilera"),
                          SizedBox(height: 10.0),
                          Text("Bernardo Pérez López"),
                          SizedBox(height: 10.0),
                          Text("José Carlos Flores Rivera"),
                        ]))))));
  }
}
