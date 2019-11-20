import 'package:apptagit/src/pages/grafico.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _mes(),
          _costoTotalTag(),
          _grafico(),
           Container(
            color: Colors.deepPurpleAccent.withOpacity(0.15),
            height: 8.0,),
          _listaTag(),
        ],
      ),
    );
  }

  Widget _mes() => Container();
  Widget _grafico() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(height: 200.0, child: Grafico()),
    );
  }

  Widget _item(IconData icon, String nombre, int percent, double value) {
    return ListTile(
      leading: Icon(icon, size: 32.0),
      title: Text(
        nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      subtitle: Text(
        "$percent% del cobro",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.deepPurple,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget _listaTag() {
    return Expanded(
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) =>
            _item(FontAwesomeIcons.car, "costo", 14, 145.12),
        separatorBuilder: (BuildContext context, int index){
          return Container(
            color: Colors.deepPurpleAccent.withOpacity(0.15),
            height: 3.0,

            );
        },
      ),
    );
  }

  Widget _costoTotalTag() {
    return Column(
      children: <Widget>[
        Text(
          "\$2365.1",
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
