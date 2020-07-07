import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:privada_app/src/pages/login_page.dart';
import 'package:privada_app/src/providers/login_provider.dart';
import 'package:privada_app/src/utils/constantes.dart';

LoginPage login = new LoginPage();

class GradientAppBar extends StatelessWidget { 
  final String title;
  final double barHeight = 66.0;
  final AuthService _auth = AuthService();

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Stack(children: <Widget>[
        new Center(
          child: new Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 30.0)),
        ),
        new PopupMenuButton<String>(
          onSelected: choiceAction,
          itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        )
      ]),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [const Color(0xFF3366FF), const Color(0xFF00CCFF)],
            begin: const FractionalOffset(0, 1),
            end: const FractionalOffset(2, 0),
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp),
      ),
    );
  }

  void choiceAction(String choice) async{
    if (choice == Constants.Settings) {
      print('Settings');

    } else if (choice == Constants.SignOut) {
      await _auth.logOut();
      print('LogOut');  
      Get.toNamed("login");
    }
  }
}
