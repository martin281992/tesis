import 'package:apptagit/src/pages/detalleCobro.dart';
import 'package:apptagit/src/pages/grafico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MonthWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categorias;
  final int mes;
  MonthWidget({Key key, this.documents, dias, this.mes})
      : total = documents.map((doc) => doc['valor']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(dias, (int index) {
          return documents
              .where((doc) => doc['dia'] == (index + 1))
              .map((doc) => doc['valor'])
              .fold(0.0, (a, b) => a + b);
        }),
        categorias = documents.fold({}, (Map<String, double> map, docu) {
          if (!map.containsKey(docu['categoria'])) {
            map[docu['categoria']] = 0.0;
          }
          map[docu['categoria']] += docu['valor'];
          //print(map);
          return map;
        }),
        super(key: key);
  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          _costoTotalTag(),
          _grafico(),
          Container(
            color: Colors.deepPurpleAccent.withOpacity(0.15),
            height: 8.0,
          ),
          _listaTag(),
        ],
      ),
    );
  }

  Widget _grafico() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Grafico(
          data: widget.perDay,
        ),
      ),
    );
  }

  Widget _listaTag() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.categorias.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categorias.keys.elementAt(index);
          // print(widget.categorias.keys);
          var data = widget.categorias[key];
          return _item(
              FontAwesomeIcons.car, key, 100 * data ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.deepPurpleAccent.withOpacity(0.15),
            height: 3.0,
          );
        },
      ),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('detalle',
            arguments: ParametrosDetalle(name, widget.mes));
      },
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "$percent% of expenses",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _costoTotalTag() {
    return Column(
      children: <Widget>[
        Text(
          "\$${widget.total.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
        ),
        Text(
          "total a pagar",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blueGrey),
        ),
      ],
    );
  }
}
