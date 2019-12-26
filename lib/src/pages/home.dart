import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:apptagit/src/cloudstore/portales.dart';
import 'package:apptagit/src/cloudstore/portalesService.dart';
import 'package:apptagit/src/pages/portales.dart';
//import 'package:apptagit/src/pages/agregar_coordenada.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
//import 'package:apptagit/src/cloudstore/firestore_service.dart'
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
        drawer: _newMenu(data),
        body: _body());
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

  _body() {
    return StreamBuilder(
      stream: FirestoreService().getPortales(),
      builder: (BuildContext context, AsyncSnapshot<List<Portal>> snapshot) {
        //var count = snapshot.data.length;
        //print(count);
        if (snapshot.hasError || !snapshot.hasData)
          return CircularProgressIndicator();

        return ListView.builder(
            itemCount: snapshot.data.length - (snapshot.data.length - 1),
            itemBuilder: (BuildContext context, int index) {
              // Portal portal = snapshot.data[index];

              StreamSubscription<LocationData> locationSubscription;

              var location = new Location();

              locationSubscription = location.onLocationChanged().listen(
                (LocationData currentLocation) {
                  var locationemit = currentLocation.longitude.toString();
                  var locationemit2 = currentLocation.latitude.toString();

                  var arr = [];

                  for (var i = 0; i < snapshot.data.length; i++) {
                    var temp = snapshot.data[i];

                    var cuanto = snapshot.data.length;

                    if (locationemit == temp.longitud &&
                        locationemit2 == temp.latitud) {
                      //print(temp.nombreP);
                      //print(temp.costo);
                      arr.add(temp.longitud);
                      arr.add(temp.latitud);

                      int valor = int.parse(temp.costo);

                      final muyFuture =
                          Future.delayed(Duration(seconds: 2), () {
                        Cobros cobro = Cobros(
                            categoria: 'tag', dia: 5, mes: 12, valor: valor);

                        print('dentro del if ${cuanto}');

                        //FirestoreService().addCobro(cobro);
                      });
                      //FirestoreService().addCobro(cobro))

                      locationSubscription.pause();

                      var timer = Timer(Duration(seconds: 60),
                          () => locationSubscription.resume());
                    }
                  }

                  //if (locationemit == temp.longitud) {}
                },
              );

              // return ListTile();
              return ListTile();
            });
      },
    );
  }

  Drawer _newMenu(data) {
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
