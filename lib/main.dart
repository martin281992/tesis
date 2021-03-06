
import 'package:flutter/material.dart';

import 'package:apptagit/src/bloc/provider.dart';

//simport 'package:formvalidation/src/pages/home_page.dart';
import 'package:apptagit/src/pages/login_page.dart';
import 'package:apptagit/src/pages/inicio.dart';
import 'package:apptagit/src/pages/autos.dart';
import 'package:apptagit/src/pages/socios.dart';
import 'package:apptagit/src/pages/home.dart';
import 'package:apptagit/src/pages/agregar_autos.dart';
import 'package:apptagit/src/pages/registro_page.dart';
import 'package:apptagit/src/share_pref/preferencias_usuario.dart';
import 'package:apptagit/src/pages/home_page.dart';
import 'package:apptagit/src/pages/agregar__socios.dart';

//import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    print(prefs.token);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'homealternative',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'inicio': (BuildContext context) => InicioPage(),
          'autos': (BuildContext context) => Autos(),
          'socios': (BuildContext context) => Socios(),
          'homealternative': (BuildContext context) => HomePage(),
          'home': (BuildContext context) => HomePageTagit(),
          'addcar': (BuildContext context) => AgregarAutos(),
          'addsocio': (BuildContext context) => AgregarSocios(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,

        ),
      ),
    );
  }
}
