import 'package:flutter/material.dart';
import 'package:privada_app/src/providers/usuario_provider.dart';
import 'package:privada_app/src/utils/utils.dart';
import 'package:privada_app/src/bloc/provider.dart';

class FormLogin extends StatefulWidget {
  FormLogin({Key key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final usuarioProvider = new UsuarioProvider();
  var passKey = GlobalKey<FormFieldState>();
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          child: _loginRegistro(bloc),
        ),
        SizedBox(height: 30.0),
        Row(
          children: <Widget>[_loginBtns(bloc), _crearBotonRegistro(bloc)],
        ),
      ],
    ));
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            obscureText: true,
            key: passKey,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
            validator: (password) {
              var result = password.length < 4
                  ? "Password should have at least 4 characters"
                  : null;
              return result;
            },
          ),
        );
      },
    );
  }

  Widget _confirmarPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
            labelText: 'Repetir Contraseña'),
        obscureText: true,
        validator: (confirmation) {
          var password = passKey.currentState.value;
          return (confirmation == password)
              ? null
              : "Confirm Password should match password";
        },
      ),
    );
  }

  Widget _crearBotonLogin(LoginBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 0.0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snapshot.hasData ? () => _login(bloc, context) : null);
        },
      ),
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }

  Widget _crearBotonRegistro(LoginBloc bloc) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Text('Registrarse'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _isLogin = false;
            });
          },
        ));
  }

  Widget _crearBotonTengoCuenta() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Text('Ya tengo Cuenta'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _isLogin = true;
            });
          },
        ));
  }

  Widget _loginRegistro(bloc) {
    if (_isLogin == true) {
      return Column(
        children: <Widget>[
          _crearEmail(bloc),
          _crearPassword(bloc),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _crearEmail(bloc),
          _crearPassword(bloc),
          _confirmarPass(),
        ],
      );
    }
  }

  Widget _loginBtns(bloc) {
    if (_isLogin == true) {
      return _crearBotonLogin(bloc);
    } else {
      return _crearBotonTengoCuenta();
    }
  }
}
