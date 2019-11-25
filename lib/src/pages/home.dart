import 'dart:math';

import 'package:flutter/material.dart';

class HomePageTagit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No te dejes cobrar de mas'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: _newMenu(context),
      body: Stack(
        children: <Widget>[
          //_fondoApp(),

          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                //_botonesHome(context),
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: _buttonNavigatorBar(context),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(3.9, 0.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ],
        ),
      ),
    );

    final cajaEstilosa = Transform.rotate(
      angle: -pi / 3,
      child: Container(
        height: 300.0,
        width: 250.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(201, 122, 122, 1.0)
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaEstilosa,
        ),
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Tarifa actual',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Bienvenido, el color te indicara el ',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            Text(
              'horario para el cobro de tu tag ',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonNavigatorBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
          primaryColor: Colors.pinkAccent,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
      child: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_calendar, size: 30.0),
            title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq, size: 30.0), title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add, size: 30.0), title: Container()),
      ]),
    );
  }

  Widget _botonesHome(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _crearModulo(
            context,
            Colors.red,
            Icons.account_circle,
            'Perfil',
          ),
          _crearModulo(context, Colors.blueAccent, Icons.group_add, 'socios'),
        ]),
        TableRow(children: [
          _crearModulo(context, Colors.purple, Icons.local_car_wash, 'Autos'),
          _crearModulo(
              context, Colors.orange, Icons.location_searching, 'Mis Cobros'),
        ]),
        TableRow(children: [
          _crearModulo(context, Colors.pinkAccent, Icons.grain, 'Estadisticas'),
          _crearModulo(context, Colors.green, Icons.book, 'Reportes'),
        ]),
      ],
    );
  }

  Widget _crearModulo(
      BuildContext context, Color color, IconData icon, String texto) {
    return Container(
      child: Container(
        height: 130,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: color,
              radius: 30.0,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              texto,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _newMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/fondo2.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Mis Autos'),
            onTap: () {
              Navigator.pushNamed(context, 'autos');
            },
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Mis socios'),
            onTap: () {
              Navigator.pushNamed(context, 'socios');
            },
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Mis estadisticas'),
            onTap: () {
              Navigator.pushNamed(context, 'estadisticas');
            },
          ),
        ],
      ),
    );
  }
}
