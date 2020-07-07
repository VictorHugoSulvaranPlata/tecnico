import 'package:flutter/material.dart';
import 'package:privada_app/src/providers/login_provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:privada_app/src/widgets/form_login_widget.dart';

class LoginPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  final FormLogin _formLogin = FormLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 130.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                Container(
                  child: _formLogin,
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Text("or"),
                SizedBox(
                  height: 10.0,
                ),
                _facebook(context),
                SizedBox(
                  height: 10.0,
                ),
                _google(context)
              ],
            ),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _facebook(BuildContext context) {
    return SignInButton(
      Buttons.Facebook,
      onPressed: () {
        try {
          _auth.initiateSignIn("FB");
        } catch (e) {}
      },
      text: "Login with Facebook",
      mini: false,
    );
  }

  Widget _google(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        try {
          _auth.initiateSignIn("G");
        } catch (e) {}
      },
      text: "Login with Google",
      mini: false,
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(22, 97, 97, 1.0),
        Color.fromRGBO(38, 87, 235, 0.8)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.home, color: Colors.white, size: 90.0),
              SizedBox(height: 1.0, width: double.infinity),
              Text('TesoAdmin',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
