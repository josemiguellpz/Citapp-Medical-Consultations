import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'flutter_time_picker_spinner.dart';
//import 'package:firebase_core/firebase_core.dart';

class PacienteScreen extends StatelessWidget {
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
                Tab(icon: Icon(Icons.today)),
                Tab(icon: Icon(Icons.description)),
              ],
            ),
            title: Text('Paciente'),
          ),
          body: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                height: 1000,
                child: TabBarView(
                  children: [
                    ListaPacientes(),
                    Formulario(),
                  ],
                ))
          ])),
        ),
      ),
    );
  }
}

//Primer elemento del TAB (Barra de navegacion)
class ListaPacientes extends StatefulWidget {
  @override
  _ListaPacientesState createState() => _ListaPacientesState();
}

class _ListaPacientesState extends State<ListaPacientes> {
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
      db.collection("consultas").get().then((querySnapshot) {
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

    Widget boton() {
      return RaisedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PacienteScreen()));
        },
        child: Text(
          "Actualizar",
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    boton();
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
                          height: 130,
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
                                  Text("Status: " + estado),
                                ],
                              )))))); //Aqui
        });
  }
}

//Segundo elemento del TAB (Barra de navegacion)
class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  String _name;
  String _lastname;
  String _phonenumber;
  String _reason;
  String _fecha; //formato 2020-11-10
  String _hora;
  DateTime _dateTime; //formato 2020-11-10 15:00.00
  DateTime _time;

  //Establece el formato para la fecha y hora
  void establecerFechaTiempo() {
    var x = this._dateTime.toString();
    this._fecha = x.substring(0, 10); // '2020-10-15
    var y = this._time.toString();
    this._hora = y.substring(11, 16);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'required field';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildLastName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'required field';
        }

        return null;
      },
      onSaved: (String value) {
        _lastname = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Telefono'),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'required field';
        }

        return null;
      },
      onSaved: (String value) {
        _phonenumber = value;
      },
    );
  }

  Widget _buildReason() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Motivo'),
      maxLength: 40,
      validator: (String value) {
        if (value.isEmpty) {
          return 'required field';
        }

        return null;
      },
      onSaved: (String value) {
        _reason = value;
      },
    );
  }

  Widget _buildDate() {
    return Column(children: <Widget>[
      Text(" "),
      Text(_dateTime == null ? 'Sin fecha' : _dateTime.toString()),
      Text(" "),
      RaisedButton(
        child: Text('Selecciona una fecha'),
        onPressed: () {
          showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030))
              .then((date) {
            setState(() {
              _dateTime = date;
            });
          });
        },
      ),
      Text(" "),
    ]);
  }

  Widget _buildTime() {
    return TimePickerSpinner(
      is24HourMode: true,
      spacing: 30, //separacion de numero ej. 14   15
      itemWidth: 40,
      itemHeight: 40,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _time = time;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Query a Consultas y almacena datos del formulario
    CollectionReference sto =
        FirebaseFirestore.instance.collection('consultas');
    Future<void> addCita() {
      return sto
          .add({
            'nombre': this._name,
            'apellido': this._lastname,
            'telefono': this._phonenumber,
            'motivo': this._reason,
            'fecha': this._fecha,
            'hora': this._hora,
            'estado': "Espera",
          })
          .then((value) => print("Cita agendada"))
          .catchError((error) => print("Error en: $error"));
    }

    //Widgets para el formulario
    return Scaffold(
      appBar: AppBar(title: Text("Formulario de Cita")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildName(),
              _buildLastName(),
              _buildPhoneNumber(),
              _buildReason(),
              _buildDate(),
              Text("Seleccione la hora"),
              Text(" "),
              _buildTime(),
              SizedBox(height: 20),
              RaisedButton(
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    //Widget de confirmacion
                    builder: (context) => AlertDialog(
                      title: Text("¿Desea confirmar su cita?"),
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
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();
                      //Dar formato a las variables
                      establecerFechaTiempo();
                      //Registrar datos en Firebase
                      addCita();
                      //Mensaje de confirmacion
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                                title: Text("Cita programada"),
                              ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PacienteScreen()));
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
