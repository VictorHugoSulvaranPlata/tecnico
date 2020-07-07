import 'package:http/http.dart' as http; //http
import 'dart:convert';
import 'dart:async' show Future;
import 'package:privada_app/src/models/casa_model.dart';
//import 'package:privada_app/src/preferencias_usuario/preferencias_usuario.dart'; //json

class CasaProvider {
  //Url del servicio Firebase.
  final String _url = 'http://192.168.0.43:8080/api/clientescuota';
  final String _id = "1";
  //final _prefs = new PreferenciasUsuario();


  /*
  * Metodo para pedir el listado de Casas
  */

  Future cargarCasas() async {
    final url = '$_url/$_id';
    final resp = await http.get(url);

    final jsonResponse = json.decode(resp.body);
    print("JSON DE RESPUESTA:  ---->$jsonResponse");
    ClienteCuotaList clienteCuotaList = ClienteCuotaList.fromJson(jsonResponse);

    return clienteCuotaList;
  }
}
