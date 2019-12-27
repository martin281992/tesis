import 'package:apptagit/src/models/clienteModel.dart';
import 'package:apptagit/src/providers/car_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/models/carModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgregarAutos extends StatefulWidget {
  final Cliente encargado;

  const AgregarAutos({Key key, this.encargado}) : super(key: key);

  @override
  _AgregarAutosState createState() => _AgregarAutosState();
}

class _AgregarAutosState extends State<AgregarAutos> {
  final newkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>(); // key para enlazar el snackbar
  final carProvider = new CarProvider();
  var selectedType, selectedCurrency;

  //creacion de carro
  CarModel car = new CarModel();
  bool _buttondisable = false;

  @override
  Widget build(BuildContext context) {
    final CarModel carData = ModalRoute.of(context).settings.arguments;

    if (carData != null) {
      car = carData;
      print(carData);
    }

    return Scaffold(
      key: scaffolkey, // se agregar la key para snackbar
      appBar: AppBar(
        title: Text('Agrega otro vehiculo'),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: newkey,
            //child obligatorio de los FORM
            child: Column(
              children: <Widget>[
                _crearNombre(),
                SizedBox(height: 20.0),
                _crearMarca(),
                SizedBox(height: 20.0),
                _crearPatente(),
                SizedBox(height: 20.0),
                _autoPrincipal(),
                SizedBox(
                  height: 20.0,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("socios").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        const Text("Loading.....");
                      else {
                        List<DropdownMenuItem> currencyItems = [];
                        for (int i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          currencyItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.data['nombre'],
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
                              ),
                              value: "${snap.data['nombre']}",
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.personBooth,
                                size: 25.0, color: Colors.deepPurpleAccent),
                            SizedBox(width: 50.0),
                            DropdownButton(
                              items: currencyItems,
                              onChanged: (currencyValue) {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'El encargado de este auto es $currencyValue',
                                    style: TextStyle(
                                        color: Colors.deepPurpleAccent),
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  selectedCurrency = currencyValue;

                                  if (selectedCurrency != null) {
                                    // getCurrency(selectedCurrency);

                                    /*Encargo encargado = Encargo(

                                        nombreEncargado:selectedCurrency,
                                        nombreAuto:

                                    );
                                    FirestoreService().addEncargado(encargado);*/
                                  } else {
                                    print(selectedCurrency);
                                  }
                                });
                              },
                              value: selectedCurrency,
                              isExpanded: false,
                              hint: new Text(
                                "Elige al socio para tu auto",
                                style: TextStyle(color: Colors.deepPurple),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                _submitButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: car.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre vehiculo',
      ),
      onSaved: (value) => car.nombre = value,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearMarca() {
    return TextFormField(
      initialValue: car.marca,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Marca',
      ),
      onSaved: (input) => car.marca = input,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese el marca correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPatente() {
    return TextFormField(
      initialValue: car.patente,
      textCapitalization: TextCapitalization.sentences,
      // para numeros
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Patente',
      ),
      onSaved: (value) => car.patente = value,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese la patente correctamente';
        } else {
          return null;
        }
      },
      /*
       validator: (value) {
        if( utils.isNumeric(value) ){
          // es un numero, pasa la validacion
          return null;
        }else{
          return 'No paso la validacion';
        }
      },

     */
    );
  }

  Widget _autoPrincipal() {
    return SwitchListTile(
      value: car.principal,
      title: Text('Auto principal'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        car.principal = value;
      }),
    );
  }

  Widget _submitButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('guardar'),
      icon: Icon(Icons.save),
      //usamos el trigger para que se apliquen las validaciones
      onPressed: (_buttondisable) ? null : _triggerSubmite,
    );
  }

  _triggerSubmite() {
    // aca retornamos un boleano si el formulario se completa bien
    //si no es asi indicara en rojo en los campos

    if (!newkey.currentState.validate()) return;
    // si no es valido quiere decir que todos los campos son correctos y se va abajo

    newkey.currentState.save();
    setState(() {
      _buttondisable = true;
    });

    // se activo el cambio en el button
    // se debe agregar un state para cambiar el estado de  un widget

    if (car.id == null) {
      carProvider.addcar(car);
    } else {
      carProvider.editCar(car);
    }

    mostrasMensaje('enviado');
    //luego de que se lanza snackbar se cancela el boton
    Navigator.pop(context);
  }

  void mostrasMensaje(String mensaje) {
    final msje = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 4000),
    ); //para utilizar snackbar se necesita una referencia al scaffold quien puede emitir o mostrar el snackbar
    //se debe crear una key para ello

    //con el key añadida en el Scaffold

    scaffolkey.currentState.showSnackBar(msje);
  }
}
