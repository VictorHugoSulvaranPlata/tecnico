import 'package:flutter/material.dart';
import 'package:privada_app/src/models/casa_model.dart';

import 'package:privada_app/src/providers/casa_provider.dart';
import 'package:privada_app/src/widgets/casa_row.dart';

class CasasPage extends StatelessWidget {
  final casasProvider = new CasaProvider();
  final id = 2;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _crearListado());
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: casasProvider.cargarCasas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Listado de Casas
          final ClienteCuotaList casas = snapshot.data;
          print(snapshot.data.toString());
          return ListView.builder(
            itemCount: casas.casasLista.length,
            itemBuilder: (context, i) => CasasRow(casas: casas, index: i),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
