import 'package:flutter/material.dart';


class PageThree extends StatefulWidget {

final String opcionSelecionada;
final String name;
final String email;


PageThree(this.opcionSelecionada, this.email, this.name);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contactos'),
          backgroundColor: Colors.blue[900],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container( 
                child:Text(widget.email),
      ),
      Container( 
                child:Text(widget.opcionSelecionada),
      ),
      Container( 
                child:Text(widget.name),
      ),
            ],
          ),
        ),
      )
    );
  }

}