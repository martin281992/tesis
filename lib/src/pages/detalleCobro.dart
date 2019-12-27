import 'package:apptagit/src/bloc/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ParametrosDetalle {
  final String nombre;
  final int mes;

  ParametrosDetalle(this.nombre, this.mes);
}

class DetalleCobro extends StatefulWidget {
  final ParametrosDetalle params;

  const DetalleCobro({Key key, this.params}) : super(key: key);
  @override
  _DetalleCobroState createState() => _DetalleCobroState();
}

class _DetalleCobroState extends State<DetalleCobro> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    print(bloc.email);
    var _query = Firestore.instance
        .collection('Cobros')
        .where("mes", isEqualTo: widget.params.mes + 1)
        .where("categoria", isEqualTo: widget.params.nombre)
        .where("cliente", isEqualTo: bloc.email)
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.params.nombre),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _query,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
            if (data.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var document = data.data.documents[index];

                  return Dismissible(
                    key: Key(document.documentID),
                    onDismissed: (direction) {
                      Firestore.instance
                          .collection('Cobros')
                          .document(document.documentID)
                          .delete();
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      leading: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            size: 40,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 8,
                            child: Text(
                              document["dia"].toString(),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      title: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            " ${document["nombreCon"]} - ${document["nombrePortal"]} y su valor es \$ ${document["valor"]} y fue cobrada: ${document["hora"]} en el horario de ${document["tarifa"]} ",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: data.data.documents.length,
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
