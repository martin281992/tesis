import 'dart:async';
import 'dart:math';

import 'package:apptagit/src/cloudstore/portales.dart';
import 'package:apptagit/src/cloudstore/portalesService.dart';
//import 'package:apptagit/src/pages/agregar_coordenada.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
//import 'package:apptagit/src/cloudstore/firestore_service.dart';
import 'package:apptagit/src/cloudstore/cobros.dart';

class HomePageTagit extends StatefulWidget {
  const HomePageTagit({Key key}) : super(key: key);

  @override
  _HomePageTagitState createState() => _HomePageTagitState();
}

class _HomePageTagitState extends State<HomePageTagit> {
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
      body: StreamBuilder(
        stream: FirestoreService().getPortales(),
        builder: (BuildContext context, AsyncSnapshot<List<Portal>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Portal portal = snapshot.data[index];
                var location = new Location();

                location.onLocationChanged().listen(
                  (LocationData currentLocation) {
                    //  print('latitud ${currentLocation.latitude}');
                    // print('Longitud ${currentLocation.longitude}');

                    var locationemit = currentLocation.longitude.toString();

                    StreamBuilder(
                      stream: FirestoreService().getPortalesCobro(locationemit),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Portal>> snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Portal portal = snapshot.data[index];

                              for (var i = 0; i < snapshot.data.length; i++) {
                                var temp = snapshot.data[i];
                                print(temp.costo);
                                if (portal.longitud == locationemit) {
                                  print(
                                      'portal: ${portal.longitud} = ${locationemit}');
                                  print("lo lograste emitiendo y captnado");
                                  final valor = temp.costo;

                                  final dia = 17;
                                  final mes = 12;
                                  final categoria = "tag";

                                  Cobros cobro = Cobros(
                                    categoria: categoria,
                                    dia: 17,
                                    mes: 12,
                                    valor: valor,
                                  );

                                  // FirestoreService().addCobro(cobro);
                                }
                                //print('que tengo aca ${temp}');
                              }
                            });
                        //return ListTile();
                      },
                    );
                  },
                );
                return ListTile();
              });
        },
      ),

      /* StreamBuilder(
                stream: FirestoreService().getPortales(),
                builder: (BuildContext context, AsyncSnapshot<List<Portal>> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData)
                    return CircularProgressIndicator();

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Portal portal = snapshot.data[index];

                      var geolocator = Geolocator();
                      var locationOptions = LocationOptions(
                          accuracy: LocationAccuracy.high, distanceFilter: 10);

                      StreamSubscription<Position> positionStream = geolocator
                          .getPositionStream(locationOptions)
                          .listen((Position position) {
                        print(position == null
                            ? 'Unknown'
                            : position.latitude.toString() +
                                ', ' +
                                position.longitude.toString());

                        var posLat = position.latitude.toString();
                        var posLon = position.longitude.toString();

                        if (portal.latitud == posLat) {
                          print('hola coordenada');
                          print(portal.latitud);
                        }
                      });
                    },
                  );
                },
              ), */

      /* Stack(
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
              ),*/
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
