import 'package:flutter/material.dart';
import 'package:privada_app/src/registrarse/page_three.dart';
import 'package:privada_app/src/registrarse/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';




class CrearCuenta extends StatefulWidget {
  @override
  _CrearCuentaState createState() => _CrearCuentaState();
}

class _CrearCuentaState extends State<CrearCuenta> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<String> _numCondo = ['1', '2', '3', '4'];
  String _opcionSelecionada = "1";

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  // String _name;
  // String _email;
   String errorMessage = '';
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

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
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 30.0),
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
                Text('Crear una cuenta',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 40.0),
                _crearEmail(), // agregar despues el bloc
                SizedBox(height: 30.0),
                _crearCondominio(),
                SizedBox(height: 30.0),
                _crearBoton(context),
                SizedBox(height: 30.0),
                signInButton(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formStateKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: TextFormField(
                validator: validateEmail,
                onSaved: (value) {
                  _emailId = value;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailIdController,
                decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.green,
                        width: 2,
                        style: BorderStyle.solid),
                  ),
                  labelText: "Email Id",
                  icon: Icon(
                    Icons.email,
                    color: Colors.green,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: TextFormField(
                validator: validatePassword,
                onSaved: (value) {
                  _password = value;
                },
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.green,
                          width: 2,
                          style: BorderStyle.solid)),
                  labelText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),

          ],
        ),
        
      ),
      );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  List<DropdownMenuItem<String>> getOpciones() {
    List<DropdownMenuItem<String>> listaCondo = new List();
    _numCondo.forEach((poder) {
      listaCondo.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });
    return listaCondo;
  }

  Widget _crearCondominio() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 90.0),
      child: Row(
        children: <Widget>[
          Text(
            "Condominio",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(width: 30.0),
          Expanded(
            child: DropdownButton(
                value: _opcionSelecionada,
                items: getOpciones(),
                onChanged: (opt) {
                  setState(() {
                    _opcionSelecionada = opt;
                  });
                }),
          )
        ],
      ),
    );
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  Widget _crearBoton(context) {
    return Builder(
      builder: (context) => RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Registrarse'),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.blue[900],
          textColor: Colors.white,
          onPressed: () {
             if (_formStateKey.currentState.validate()) {
               _formStateKey.currentState.save();
              //  print('error----- $errorMessage');
                //  if(errorMessage == ""){
               signUp(_emailId, _password).whenComplete(() {

                 print('Registered Successfully.');
                 if(emails != null || name != null){

                  //  Scaffold.of(context).showSnackBar(SnackBar(
                  //    content: Text('se ha guardado con exito'),
                  //    duration: Duration(seconds: 3),
                  //  ));

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PageThree(_opcionSelecionada, name, emails);
                        },
                      ),
                    );
                 }else{
                   Scaffold.of(context).showSnackBar(SnackBar(
                     content: Text('el email ya existe'),
                     duration: Duration(seconds: 3),
                   ));
                    print('error**__________*** $errorMessage');

                 }
                 } );
                 }
              
          }
          ),
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
              Icon(Icons.home, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Condominio',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }

  Widget signInButton(BuildContext context) {
    return Container(
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.white,
            child: Image(
              image: new AssetImage("assets/img/face.png"),
              height: 30.0,
              width: 30.0,
            ),
            onPressed: () {

            },
          ),
          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.white,
            child: Image(
              image: new AssetImage("assets/img/google.png"),
              height: 30.0,
              width: 30.0,
            ),
            onPressed: () {
               signInWithGoogle().whenComplete(() {
                 Navigator.of(context).push(
                   MaterialPageRoute(
                     builder: (context) {
                       return PageThree(_opcionSelecionada, name, emails);
                     },
                   ),
                 );
               });
            },
          ),
        ],
      ),
    );
  }
}
