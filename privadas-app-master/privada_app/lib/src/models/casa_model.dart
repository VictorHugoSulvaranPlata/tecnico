
/*
* Clase Model con los datos de ClienteYCuota para traer las casas del  cliente
*/
class CasaModel {
  int id;
  String nombre;
  double saldo;
  double montoDeuda;
  int numDeuda;

//Constructor
  CasaModel(
      {this.id,
      this.nombre = '',
      this.saldo = 0.0,
      this.montoDeuda = 0.0,
      this.numDeuda = 0});

// metodo FromJson para insertar los daros del Json en el Modelo.
  factory CasaModel.fromJson(Map<String, dynamic> json) => CasaModel(
        id: json["id"],
        nombre: json["nombre"],
        saldo: json["saldo"],
        montoDeuda: json["monto"],
        numDeuda: json["numdeuda"],
      );
}

/*
*   La siguiente es una clase de listas de la CasasModel para que el json 
*   recorra la lista de objetos que trae CasaModel.
*/
class ClienteCuotaList {
  final List<CasaModel> casasLista;

  ClienteCuotaList({
    this.casasLista,
  });

  factory ClienteCuotaList.fromJson(List<dynamic> parsedJson) {
    List<CasaModel> casasLista = new List<CasaModel>();
    casasLista = parsedJson.map((i) => CasaModel.fromJson(i)).toList();
    return new ClienteCuotaList(
      casasLista: casasLista
    );
  }
}
