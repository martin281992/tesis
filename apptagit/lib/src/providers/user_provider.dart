import 'dart:convert';

import 'package:apptagit/src/share_pref/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _firebaseToken = 'AIzaSyDudo2CTh0KD4HybNwmfyHFInqVIn0IXWA';

  final prefs = new PreferenciasUsuario();

// LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      //salvar el token en Storage
      prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      // si el email existe envia mensaje de error
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }

  // NUEVO USUARIO

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        //https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]

        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      //salvar el token en Storage
      prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      // si el email existe envia mensaje de error
      return {'ok': false, 'message': decodedResp['error']['message']};
    }
  }
}
