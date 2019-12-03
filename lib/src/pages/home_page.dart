import 'package:apptagit/src/pages/agregar_coordenada.dart';
import 'package:apptagit/src/pages/autos.dart';
import 'package:apptagit/src/pages/home.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart' as prefix0;

class HomePage extends StatefulWidget {
  // const name({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      body: _cargarPagina(currentIndex),

      bottomNavigationBar: _buttonNavigationBarAlt(),
      //child: child,
    );
  }

  _cargarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return HomePageTagit();
      case 1:
        return Autos();
     /* case 2:
        return Socios();*/
    }
  }

  Widget _buttonNavigationBarAlt() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_car_wash),
          title: Text('autos'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('socios'),
        ),
      ],
    );
  }
}
