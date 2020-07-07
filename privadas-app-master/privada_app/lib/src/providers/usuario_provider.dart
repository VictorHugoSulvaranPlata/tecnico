import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:privada_app/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  final String _firebasToken = 'AIzaSyC-9ZoxgJSN72Vmm1vwz7-U_oYbDCMaAEo';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebasToken',
        body: json.encode(authData));
    print(authData);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp['localId']);
    print(decodedResp['email']);


    if (decodedResp.containsKey('idToken')) {
      //salvar
      _prefs.token = decodedResp['idToken'];
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebasToken',
        body: json.encode(authData));
    print(authData);
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      _prefs.token = decodedResp['idToken'];

      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
