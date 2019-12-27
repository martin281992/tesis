import 'dart:async';

import 'package:apptagit/src/pages/mes_widget.dart';
import 'package:apptagit/src/utils/utils.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  PageController _controller;
  int currentPage = DateTime.now().month - 1;
  int currentIndex = 0;

  Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _query = Firestore.instance
        .collection('Cobros')
        .where("mes", isEqualTo: currentPage + 1)
        .snapshots();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadisticas mensuales'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _mes(),
          StreamBuilder<QuerySnapshot>(
            stream: _query,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
              if (data.hasData) {
                return MonthWidget(
                  dias: diasEnMes(currentPage + 1),
                  documents: data.data.documents,
                  mes: currentPage,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget _pageItem(String nombre, int posicion) {
    var _alignmen;

    final selected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent);

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
          onPageChanged: (newPage) {
            setState(() {
              currentPage = newPage;
              _query = Firestore.instance
                  .collection('Cobros')
                  .where("mes", isEqualTo: currentPage + 1)
                  .snapshots();
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
}
