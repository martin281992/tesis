import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:apptagit/src/share_pref/preferencias_usuario.dart';

import 'package:apptagit/src/models/carModel.dart';

class CarProvider {
  final String _url = 'https://tagit-813ec.firebaseio.com';
  // final  _prefes = new PreferenciasUsuario();

  // peticiones REST para api firebase

  Future<bool> addcar(CarModel car) async {
    // aca haremos la peticion post a esta direccion
    //final url = '$_url/car.json?auth=${_prefes.token}';
    final url = '$_url/car.json';

    // lo que sea que regrese este post que es un FUTURE RESPONS

    //ALMACENAMOS EN UNA VARIABLE

    final resp = await http.post(url, body: carModelToJson(car));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<CarModel>> listCar() async {
    //final url = '$_url/car.json?auth=${_prefes.token}';
    final url = '$_url/car.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<CarModel> cars = new List();

    //  print(decodeData);
    if (decodeData == null) return [];

    decodeData.forEach((id, car) {
      final carsTemp = CarModel.fromJson(car);
      carsTemp.id = id;
      cars.add(carsTemp);
    });
    print(cars[0].id);
    return cars;
  }

  Future<int> deleteCars(String id) async {
    //final url = '$_url/car/$id.json?auth=${_prefes.token}';
    final url = '$_url/car/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<bool> editCar(CarModel car) async {
    //final url = '$_url/car/${car.id}.json?auth=${_prefes.token}';
    final url = '$_url/car/${car.id}.json';
    final resp = await http.put(url, body: carModelToJson(car));

    final decodeData = json.decode(resp.body);

    print(decodeData);

    return true;
  }
}
