import 'package:apptagit/src/cloudstore/sociosCloud.dart';
import 'package:apptagit/src/pages/addSociosCloud.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';
import 'package:apptagit/src/cloudstore/firestore_service.dart';

class SociosCloud extends StatefulWidget {
  @override
  _SociosCloudState createState() => _SociosCloudState();
}

class _SociosCloudState extends State<SociosCloud> {
  // Stream<QuerySnapshot> _query;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final email = bloc.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Socios'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: FirestoreService().getSocios(email),
        builder: (BuildContext context, AsyncSnapshot<List<Socios>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Socios socio = snapshot.data[index];
              return ListTile(
                title: Text(socio.nombre),
                subtitle: Text(socio.correo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => AddSociosCloud(socio: socio),
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
                      onPressed: () => _deleteSocio(context, socio.id),
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

  void _deleteSocio(BuildContext context, String id) async {
    if (await _mensaje(context)) {
      try {
        await FirestoreService().deleteSocio(id);
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
              content: Text("estas seguro de eliminar a este socio?"),
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
      onPressed: () => Navigator.pushNamed(context, 'addsocioscloud'),
    );
  }
}
