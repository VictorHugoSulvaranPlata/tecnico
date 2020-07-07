import 'package:flutter/material.dart';
import 'package:privada_app/src/models/casa_model.dart';

class CasasRow extends StatelessWidget {
  final ClienteCuotaList casas;
  final int index;
  CasasRow({@required this.casas, @required this.index});

  @override
  Widget build(BuildContext context) {
    final casaThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage("assets/img/casa.png"),
        height: 92.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
              height: 124.0,
              margin: new EdgeInsets.only(left: 46.0),
              decoration: new BoxDecoration(
                color: new Color(0xFF333366),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Container(
                margin: new EdgeInsets.fromLTRB(0.0, 10.0, 90.0, 16.0),
                constraints: new BoxConstraints.expand(),
                child: Column(
                  children: <Widget>[
                    new Container(height: 4.0),
                    new Text('Casa :  ${casas.casasLista[index].nombre}',
                        style: headerTextStyle),
                    new Container(height: 10.0),
                    new Text('Saldo: ${casas.casasLista[index].saldo}  ',
                        style: subHeaderTextStyle),
                    new Container(
                        margin: new EdgeInsets.symmetric(vertical: 8.0),
                        height: 2.0,
                        width: 18.0,
                        color: new Color(0xff00c6ff)),
                    new Text(
                        'Monto: ${casas.casasLista[index].montoDeuda} (${casas.casasLista[index].numDeuda})  ',
                        style: regularTextStyle),
                  ],
                  //onTap: () => Navigator.pushNamed(context, 'casa', arguments: casa),
                ),
              ),
            ),
            casaThumbnail
          ],
        ));
  }
}
