import 'package:apptagit/src/cloudstore/cobros.dart';
import 'package:apptagit/src/cloudstore/portales.dart';
import 'package:apptagit/src/cloudstore/portalesService.dart';
import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:location/location.dart';

class Home2 extends StatefulWidget {
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new MyhomePage(),
    );
  }
}

class MyhomePage extends StatefulWidget {
  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    var data = bloc.email;
    return Scaffold(
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _pagina2(),
        _pagina1(),
      ],
    );
  }

  _pagina2() {
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

  _pagina1() {
    return Stack(
      children: <Widget>[
        _imagenFondo(),
        _colorFondo(),
        _textosInicio(),
      ],
    );
  }

  _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      //color: Color.fromRGBO(8, 192, 218, 0.0),
    );
  }

  _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('asset/fondo3.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  _textosInicio() {
    final estiloTextos = TextStyle(color: Colors.white, fontSize: 25.0);
    final estiloTextos2 = TextStyle(color: Colors.white, fontSize: 14.0);
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0, top: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'bienvenido test@gmail.com',
                style: estiloTextos,
              ),
              SizedBox(height: 200.0),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.purple,
                textColor: Colors.white,
                child: Text(
                  'Revisa tus estadisticas',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'estadisticas');
                },
              ),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: Text(
                  '      Agrega un Socio     ',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'socioscloud');
                },
              ),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                child: Text(
                  '  Agrega un vechiculo  ',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'autos');
                },
              ),
            ]),
      ),
    );
  }
}
