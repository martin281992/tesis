import 'package:flutter/material.dart';

import 'package:apptagit/src/models/sociosModel.dart';
import 'package:apptagit/src/providers/socios_provider.dart';

class Socios extends StatefulWidget {
  @override
  _SociosState createState() => _SociosState();
}

class _SociosState extends State<Socios> {
  final socioProvider = new SocioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Socios'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _listSocios(),
          ],
        ),
      ),
      floatingActionButton: _crearButton(context),
    );
  }

  _crearButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'addsocio'),
    );
  }

  Widget _listSocios() {
    return FutureBuilder(
      future: socioProvider.listSocios(),
      //metodo builder que regresa lista de carMODEL
      builder:
          (BuildContext context, AsyncSnapshot<List<SociosModel>> snapshot) {
        if (snapshot.hasData) {
          final socios = snapshot.data;
          return new ListView.builder(
            shrinkWrap: true, //si no puede hacer wrap no se muestra en pantalla

            itemCount: socios.length,
            itemBuilder: (context, i) => _searchSocios(context, socios[i]),
            //esto es una instancia del widget listcar que lo requiere
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _searchSocios(BuildContext context, SociosModel socio) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.purple,
      ),
      onDismissed: (persona) {
        socioProvider.deleteSocio(socio.id);
        //TO-DO
      },
      child: ListTile(
        title: Text('${socio.nombre}-${socio.correo}'),
        subtitle: Text('${socio.informacion}'),
        onTap: () => Navigator.pushNamed(context, 'addsocio', arguments: socio),
         isThreeLine: true,
      ),
    );
  }
}
