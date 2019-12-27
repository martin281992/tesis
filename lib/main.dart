import 'package:apptagit/src/pages/addSociosCloud.dart';
import 'package:apptagit/src/pages/agregar_coordenada.dart';
import 'package:apptagit/src/pages/detalleCobro.dart';
import 'package:apptagit/src/pages/estadisticas.dart';
import 'package:apptagit/src/pages/login_page_socio.dart';
import 'package:apptagit/src/pages/portales.dart';
import 'package:apptagit/src/pages/sociosCloud.dart';
import 'package:flutter/material.dart';

import 'package:apptagit/src/bloc/provider.dart';

//simport 'package:formvalidation/src/pages/home_page.dart';
import 'package:apptagit/src/pages/login_page.dart';
import 'package:apptagit/src/pages/autos.dart';
import 'package:apptagit/src/pages/home.dart';
import 'package:apptagit/src/pages/agregar_autos.dart';
import 'package:apptagit/src/pages/registro_page.dart';
import 'package:apptagit/src/share_pref/preferencias_usuario.dart';

//import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => RegisterPage(),
          'autos': (BuildContext context) => Autos(),
          'home': (BuildContext context) => HomePageTagit(),
          'addcar': (BuildContext context) => AgregarAutos(),
          'admin': (BuildContext context) => AgregarCoordenada(),
          'login_socios': (BuildContext context) => LoginSocios(),
          'estadisticas': (BuildContext context) => Estadisticas(),
          'socioscloud': (BuildContext context) => SociosCloud(),
          'addsocioscloud': (BuildContext context) => AddSociosCloud(),
          'portales': (BuildContext context) => Portales(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == 'detalle') {
            ParametrosDetalle params = settings.arguments;
            return MaterialPageRoute(builder: (BuildContext context) {
              return DetalleCobro(
                params: params,
              );
            });
          }
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
