import 'dart:async';

import 'package:apptagit/src/models/portalesModel.dart';
import 'package:apptagit/src/service/portalesService.dart';
//import 'package:apptagit/src/cloudstore/cobroService.dart';

import 'package:flutter/material.dart';
import 'package:apptagit/src/bloc/provider.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:apptagit/src/models/cobroModel.dart';

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
        if (snapshot.hasError || !snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          StreamSubscription<LocationData> locationSubscription;

          var location = new Location();

          locationSubscription = location.onLocationChanged().listen(
            (LocationData currentLocation) {
              var locationemit = currentLocation.longitude.toString();
              var locationemit2 = currentLocation.latitude.toString();

              var arr = [];

              print('longitud ${locationemit} + latitud ${locationemit2}');

              for (var i = 0; i < snapshot.data.length; i++) {
                var temp = snapshot.data[i];

                var longitud = locationemit.substring(0, 6);
                var latitud = locationemit2.substring(0, 6);

                if (longitud == temp.longitud && latitud == temp.latitud) {
                  arr.add(temp.longitud);
                  arr.add(temp.latitud);

                  int valor = int.parse(temp.costo);
                  var now = new DateTime.now();

                  var formatter = new DateFormat('yyyy-MM-dd');
                  String formatted = formatter.format(now);

                  String mesTemp = formatted.substring(5, 7);
                  String diaTemp = formatted.substring(8, 10);

                  var dia = int.parse(diaTemp);
                  dia = dia - 1;
                  // print(dia);

                  var mes = int.parse(mesTemp);

                  var horatemp = new DateFormat('hh:mm a');
                  String horaformat = horatemp.format(now);

                  String horasub = horaformat.substring(0, 2);
                  var hora = int.parse(horasub);

                  var horafinal;
                  String tarifa;

                  if (hora >= 8 && hora <= 10 || hora >= 18 && hora <= 20) {
                    valor = int.parse(temp.costoAlta);
                    tarifa = 'Tarifa alta';
                    horafinal = horaformat;
                  } else if (hora >= 14 && hora <= 16) {
                    valor = int.parse(temp.costoMedia);
                    tarifa = 'Tarifa media';
                    horafinal = horaformat;
                  } else {
                    valor = int.parse(temp.costo);
                    horafinal = horaformat;
                    tarifa = 'Tarifa baja';
                  }

                  String categoria;

                  if (temp.categoria == 'Tag') {
                    categoria = temp.categoria;
                  } else if (temp.categoria == 'Peaje') {
                    categoria = temp.categoria;
                  } else {
                    categoria = temp.categoria;
                  }
                  final bloc = Provider.of(context);

                  String cliente = bloc.email;

                  if (categoria != null &&
                      categoria != '' &&
                      dia != null &&
                      dia != 0 &&
                      mes != null &&
                      mes != 0 &&
                      valor != null &&
                      valor != 0 &&
                      temp.nombreP != null &&
                      temp.nombreP != '' &&
                      temp.nombreC != null &&
                      temp.nombreC != '' &&
                      horafinal != null &&
                      horafinal != '') {
                    Future.delayed(Duration(seconds: 1), () {
                      Cobros cobro = Cobros(
                          categoria: categoria,
                          dia: dia,
                          mes: mes,
                          valor: valor,
                          nombrePortal: temp.nombreP,
                          nombreCon: temp.nombreC,
                          hora: horafinal,
                          tarifa: tarifa,
                          cliente: cliente);
                      FirestoreService().addCobro(cobro);
                      locationSubscription.cancel();

                      print('se cobro');
                    });

                    Timer(Duration(seconds: 1),
                        () => locationSubscription.resume());
                  } else {
                    print('no entro');
                  }
                }
              }
            },
          );

          return ListTile();
        }
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 70.0, top: 50.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'bienvenido',
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
