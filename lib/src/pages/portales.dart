import 'package:apptagit/src/cloudstore/portales.dart';

import 'package:apptagit/src/pages/agregar_coordenada.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/cloudstore/portalesService.dart';

class Portales extends StatefulWidget {
  @override
  _Portales createState() => _Portales();
}

class _Portales extends State<Portales> {
  // Stream<QuerySnapshot> _query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portales agregados'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: FirestoreService().getPortales(),
        builder: (BuildContext context, AsyncSnapshot<List<Portal>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Portal portal = snapshot.data[index];
              return ListTile(
                title: Text(portal.nombreC),
                subtitle: Text(portal.nombreP),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AgregarCoordenada(portal: portal),
                          )),
                      /* onPressed:
                      () => Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => AddSociosCloud(socio: socio),
                          )),*/
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deletePortal(context, portal.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _crearButton(context),
    );
  }

  void _deletePortal(BuildContext context, String id) async {
    if (await _mensaje(context)) {
      try {
        await FirestoreService().deletePortal(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _mensaje(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("estas seguro de eliminar a este portal?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  child: Text("Eliminar"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.deepPurpleAccent,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                )
              ],
            ));
  }

  _crearButton(context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'admin'),
    );
  }
}
