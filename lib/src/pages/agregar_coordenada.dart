import 'dart:async';

import 'package:apptagit/src/cloudstore/portalesService.dart';
import 'package:apptagit/src/cloudstore/portales.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

class AgregarCoordenada extends StatefulWidget {
  final Portal portal;
  const AgregarCoordenada({Key key, this.portal}) : super(key: key);
  @override
  _AgregarCoordenadaState createState() => _AgregarCoordenadaState();
}

class _AgregarCoordenadaState extends State<AgregarCoordenada> {
  Position _currentPosition;
  double _currentLat;
  double _currentLon;
  final _key = GlobalKey<FormState>();
  //GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nombrePortalControler;
  TextEditingController _consecionariaControler;
  TextEditingController _costoControler;
  TextEditingController _costoMediaControler;

  TextEditingController _costoAltaControler;

  TextEditingController _coordenadaLonControler;
  TextEditingController _coordenadaLatControler;

  FocusNode _focusFiel;
  FocusNode _focusFiel2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombrePortalControler =
        TextEditingController(text: isEditMode ? widget.portal.nombreP : '');
    _costoControler =
        TextEditingController(text: isEditMode ? widget.portal.costo : '');
    _costoMediaControler =
        TextEditingController(text: isEditMode ? widget.portal.costoMedia : '');
    _costoAltaControler =
        TextEditingController(text: isEditMode ? widget.portal.costoAlta : '');
    _consecionariaControler =
        TextEditingController(text: isEditMode ? widget.portal.nombreC : '');

    _coordenadaLonControler =
        TextEditingController(text: isEditMode ? widget.portal.longitud : '');
    _coordenadaLatControler =
        TextEditingController(text: isEditMode ? widget.portal.latitud : '');
    _focusFiel = FocusNode();
    _focusFiel2 = FocusNode();
  }

  get isEditMode => widget.portal != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _newMenu(context),
      appBar: AppBar(
        title: Text(isEditMode ? 'Actualiza portala' : 'Agrega portal'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _key,
          //child obligatorio de los FORM
          child: Column(
            children: <Widget>[
              _nombreConsecionaria(context),
              SizedBox(height: 20.0),
              _nombrePortal(context),
              SizedBox(height: 20.0),
              _costoPortal(context),
              SizedBox(height: 10.0),
              _costoMediaPortal(context),
              SizedBox(height: 10.0),
              _costoAltaPortal(context),
              SizedBox(height: 10.0),
              _coordenadaLon(context),
              _coordenadaLat(context),
              SizedBox(height: 10.0),
              SizedBox(
                height: 10.0,
              ),
              _submitButton2(context),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nombreConsecionaria(context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _consecionariaControler,
      validator: (value) {
        if (value.length < 4 || value == null || value.isEmpty) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre consecionaria',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _nombrePortal(context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _nombrePortalControler,
      validator: (value) {
        if (value.length < 4 || value == null || value.isEmpty) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre Portal',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _costoPortal(context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _costoControler,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Costo horario normal',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _costoMediaPortal(context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _costoMediaControler,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Costo horario medio',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _costoAltaPortal(context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _costoAltaControler,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Costo horario alto',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _currentLat = position.latitude;
        _currentLon = position.longitude;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Drawer _newMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/fondo2.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Listar Portales'),
            onTap: () {
              Navigator.pushNamed(context, 'portales');
            },
          ),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text(isEditMode ? 'Actualizar portal' : 'guardar nuevo portal'),
      icon: Icon(Icons.save),
      //usamos el trigger para que se apliquen las validaciones
      onPressed: () async {
        if (_key.currentState.validate()) {
          _key.currentState.save();
          try {
            if (isEditMode) {
              Portal portal = Portal(
                  nombreC: _consecionariaControler.text,
                  nombreP: _nombrePortalControler.text,
                  costo: _costoControler.text,
                  latitud: _currentLat.toString(),
                  longitud: _currentLon.toString(),
                  id: widget.portal.id);
              FirestoreService().updatePortal(portal);
            } else {
              Portal portal = Portal(
                  nombreC: _consecionariaControler.text,
                  nombreP: _nombrePortalControler.text,
                  costo: _costoControler.text,
                  latitud: _currentLat.toString(),
                  longitud: _currentLon.toString());

              await FirestoreService().addPortal(portal);
            }

            //print("entro a agregar socio");

            //print(socio);
            Navigator.pushNamed(context, 'portales');
          } catch (e) {
            print(e);
          }
        } else {
          print("nunca entro porque el valide esta malo");
        }
      },
    );
  }

  Widget _submitButton2(BuildContext context) {
    // final bloc = Provider.of(context);

    return RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label:
            Text(isEditMode ? 'actualizar coordenada' : 'obtener coordenadas'),
        icon: Icon(Icons.local_library),
        //usamos el trigger para que se apliquen las validaciones
        onPressed: () {
          _getCurrentLocation();
          print(_currentPosition);
        });
  }

  get isPress => _currentLon != null;

  Widget _coordenadaLon(context) {
    return TextFormField(
      enabled: false,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },

      controller: _coordenadaLonControler,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: isPress ? _currentLon.toString() : 'Longitud',
      ),

      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _coordenadaLat(context) {
    return TextFormField(
      enabled: false,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _coordenadaLatControler,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: isPress ? _currentLat.toString() : 'Latitud',
      ),

      //onSaved: (value) => socio.nombre = value,
    );
  }
}
