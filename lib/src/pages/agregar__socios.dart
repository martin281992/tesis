import 'package:flutter/material.dart';
//import 'package:appTagit/src/utils/utils.dart' as utils;
import 'package:apptagit/src/models/sociosModel.dart';
import 'package:apptagit/src/providers/socios_provider.dart';
import 'package:apptagit/src/bloc/provider.dart';

class AgregarSocios extends StatefulWidget {
  @override
  _AgregarAutosState createState() => _AgregarAutosState();
}

class _AgregarAutosState extends State<AgregarSocios> {
  final newkey = GlobalKey<FormState>();
  final scaffolkey = GlobalKey<ScaffoldState>(); // key para enlazar el snackbar
  final socioProvider = new SocioProvider();

  SociosModel socio = new SociosModel();
  bool _buttondisable = false;

  @override
  Widget build(BuildContext context) {
    //final SociosModel sociosData = ModalRoute.of(context).settings.arguments;

    /*if (sociosData != null) {
      socio = sociosData;
      print(sociosData);
    }*/
    return Scaffold(
      key: scaffolkey,
      appBar: AppBar(
        title: Text('Agrega otro socio'),
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
                _crearCorreo(),
                SizedBox(height: 20.0),
                _crearInformacion(),
                SizedBox(height: 20.0),
                _agregarSocioPadre(context),
                SizedBox(height: 20.0),
                _estado(),
                SizedBox(
                  height: 20.0,
                ),
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
      initialValue: socio.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => socio.nombre = value,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCorreo() {
    return TextFormField(
      initialValue: socio.correo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Correo',
      ),
      onSaved: (input) => socio.correo = input,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese el correo correctamente';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearInformacion() {
    return TextFormField(
      initialValue: socio.informacion,
      textCapitalization: TextCapitalization.sentences,
      // para numeros
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Informaciones',
      ),
      onSaved: (value) => socio.informacion = value,
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

  Widget _estado() {
    return SwitchListTile(
      value: socio.estado,
      title: Text('Estado'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        socio.estado = value;
      }),
    );
  }

  Widget _agregarSocioPadre(BuildContext context) {
    final bloc = Provider.of(context);

    return TextFormField(
      enabled: false,
      initialValue: bloc.email,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: '',
      ),
      onSaved: (value) => socio.encargado = value,
      validator: (value) {
        if (value.length < 4) {
          return 'ingrese el nombre correctamente';
        } else {
          return null;
        }
      },
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
    if (!newkey.currentState.validate()) return;
    newkey.currentState.save();
    setState(() {
      _buttondisable = true;
    });
    if (socio.id == null) {
      socioProvider.addsocio(socio);
    } else {
      socioProvider.editSocio(socio);
    }

    mostrasMensaje('Registro ingresado');
    setState(() {
      _buttondisable = false;
    });
    Navigator.pop(context);
  }
  void mostrasMensaje(String mensaje) {
    final msje = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 5000),
    ); //para utilizar snackbar se necesita una referencia al scaffold quien puede emitir o mostrar el snackbar
    scaffolkey.currentState.showSnackBar(msje);
  }
}
