import 'package:apptagit/src/pages/grafico.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  PageController _controller;
  int currentPage = 8;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.3,
    );
  }

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
            height: 8.0,
          ),
          _listaTag(),
        ],
      ),
    );
  }

  Widget _pageItem(String nombre, int posicion) {
    var _alignmen;

    final selected = TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent);

    final unselected = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey.withOpacity(0.4));

    if (posicion == currentPage) {
      _alignmen = Alignment.center;
    } else if (posicion > currentPage) {
      _alignmen = Alignment.centerRight;
    } else {
      _alignmen = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignmen,
      child: Text(
        nombre,
        style: posicion == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _mes() {
    return SizedBox.fromSize(
        size: Size.fromHeight(70.0),
        child: PageView(
          onPageChanged: (newPage){
            setState(() {
             currentPage = newPage;
            });
          },
          controller: _controller,
          children: <Widget>[
            _pageItem('Enero', 0),
            _pageItem('Febrero', 1),
            _pageItem('Marzo', 2),
            _pageItem('Abril', 3),
            _pageItem('Mayo', 4),
            _pageItem('Junio', 5),
            _pageItem('Julio', 6),
            _pageItem('Agosto', 7),
            _pageItem('Septiembre', 8),
            _pageItem('Octubre', 9),
            _pageItem('Noviembre', 10),
            _pageItem('Diciembre', 11),
          ],
        ));
  }

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
        separatorBuilder: (BuildContext context, int index) {
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
