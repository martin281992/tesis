import 'dart:math';

import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';

class HomePageTagit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    var data = bloc.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('No te dejes cobrar de mas'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: _newMenu(context, data),
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

  Drawer _newMenu(BuildContext context, data) {
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
              Navigator.pushNamed(context, 'socioscloud');
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
