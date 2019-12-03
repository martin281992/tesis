import 'dart:convert';
import 'package:apptagit/src/share_pref/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

import 'package:apptagit/src/models/sociosModel.dart';
import 'package:apptagit/src/bloc/provider.dart';


class SocioProvider {
  final String _url = 'https://tagit-813ec.firebaseio.com';
  final _prefes = new PreferenciasUsuario();

  // peticiones REST para api firebase

  Future<bool> addsocio(SociosModel socio) async {
    // aca haremos la peticion post a esta direccion
    // final url = '$_url/socios.json?auth=${_prefes.token}';
    final url = '$_url/socios.json';
    // lo que sea que regrese este post que es un FUTURE RESPONS

    //ALMACENAMOS EN UNA VARIABLE

    final resp = await http.post(url, body: sociosModelToJson(socio));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<SociosModel>> listSocios() async {
    //final url = '$_url/socios.json?auth=${_prefes.token}';

    final url = '$_url/socios.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);


    final List<SociosModel> socios = new List();

    //  print(decodeData);
    if (decodeData == null) return [];

    decodeData.forEach((id, data) {
      final sociosTemp = SociosModel.fromJson(data);
      sociosTemp.id = id;
      //final encargadoTemp = ${data['encargado']};
      socios.add(sociosTemp);
    });
    return socios;
  }

  Future<int> deleteSocio(String id) async {
   // final url = '$_url/socios/$id.json?auth=${_prefes.token}';
    final url = '$_url/socios/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<bool> editSocio(SociosModel socios) async {
    //final url = '$_url/socios/${socios.id}.json?auth=${_prefes.token}';
    final url = '$_url/socios/${socios.id}.json';
    final resp = await http.put(url, body: sociosModelToJson(socios));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }
}
