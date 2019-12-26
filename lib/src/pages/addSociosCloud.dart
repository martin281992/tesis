import 'package:apptagit/src/cloudstore/firestore_service.dart';
import 'package:apptagit/src/cloudstore/sociosCloud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptagit/src/bloc/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddSociosCloud extends StatefulWidget {
  // AddSociosCloud({Key key}) : super(key: key);
  final Socios socio;
  const AddSociosCloud({Key key, this.socio}) : super(key: key);

  @override
  _AddSociosCloudState createState() => _AddSociosCloudState();
}

class _AddSociosCloudState extends State<AddSociosCloud> {
  final _key = GlobalKey<FormState>();
  //GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nombreControler;
  TextEditingController _emailControler;
  TextEditingController _encargadoControler;
  TextEditingController _informacionControler;
  TextEditingController selectedCurrency;
  FocusNode _focusFiel;
  FocusNode _focusFiel2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreControler =
        TextEditingController(text: isEditMode ? widget.socio.nombre : '');
    _emailControler =
        TextEditingController(text: isEditMode ? widget.socio.correo : '');
    _encargadoControler =
        TextEditingController(text: isEditMode ? widget.socio.encargado : '');
    _informacionControler =
        TextEditingController(text: isEditMode ? widget.socio.informacion : '');

    _focusFiel = FocusNode();
    _focusFiel2 = FocusNode();
  }

  get isEditMode => widget.socio != null;

  @override
  Widget build(BuildContext context) {
    List<String> _accounttype = <String>['hola', 'chao', 'algo'];
    return Scaffold(
      // key: scaffolkey,
      appBar: AppBar(
        title: Text(
            isEditMode ? 'Actualiza informacion' : 'Agrega un nuevo socio'),
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
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _key,
          //child obligatorio de los FORM
          child: Column(
            children: <Widget>[
              _crearNombre(context),
              SizedBox(height: 20.0),
              _crearCorreo(context),
              SizedBox(height: 20.0),
              _crearInformacion(context),
              SizedBox(height: 20.0),
              _agregarSocioPadre(context),
              SizedBox(height: 20.0),
              SizedBox(
                height: 20.0,
              ),
              _submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    final bloc = Provider.of(context);

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text(isEditMode ? 'Actualizar' : 'guardar'),
      icon: Icon(Icons.save),
      //usamos el trigger para que se apliquen las validaciones
      onPressed: () async {
        if (_key.currentState.validate()) {
          _key.currentState.save();
          try {
            if (isEditMode) {
              Socios socio = Socios(
                  nombre: _nombreControler.text,
                  correo: _emailControler.text,
                  encargado: bloc.email,
                  informacion: _informacionControler.text,
                  id: widget.socio.id);

              FirestoreService().updateSocio(socio);
            } else {
              Socios socio = Socios(
                  nombre: _nombreControler.text,
                  correo: _emailControler.text,
                  encargado: bloc.email,
                  informacion: _informacionControler.text);

              await FirestoreService().addSocio(socio);
            }
            //print("entro a agregar socio");

            //print(socio);
            Navigator.pushNamed(context, 'socioscloud');
          } catch (e) {
            print(e);
          }
        } else {
          print("nunca entro porque el valide esta malo");
        }
      },
    );
  }

  Widget _crearNombre(context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel);
      },
      controller: _nombreControler,
      validator: (value) {
        if (value.length < 4 || value == null || value.isEmpty) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _crearCorreo(context) {
    return TextFormField(
      focusNode: _focusFiel,
      textInputAction: TextInputAction.next,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_focusFiel2);
      },
      controller: _emailControler,
      validator: (value) {
        if (value.length < 4 || value == null || value.isEmpty) {
          return 'ingrese el correo correctamente';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Correo',
      ),
      //onSaved: (value) => socio.nombre = value,
    );
  }

  Widget _crearInformacion(context) {
    return TextFormField(
      focusNode: _focusFiel2,
      controller: _informacionControler,
      validator: (value) {
        if (value.length < 4 || value == null || value.isEmpty) {
          return 'ingrese alguna informacion de contacto';
        } else {
          return null;
        }
      },
      textCapitalization: TextCapitalization.sentences,
      // para numeros
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Informaciones',
      ),
      //onSaved: (value) => socio.informacion = value,
    );
  }

  Widget _agregarSocioPadre(context) {
    final bloc = Provider.of(context);

    return TextFormField(
      // initialValue: bloc.email,
      controller: _encargadoControler,

      enabled: false,
      //initialValue: bloc.email,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: bloc.email,
      ),

      //onSaved: (value) => socio.encargado = value,
    );
  }
}
