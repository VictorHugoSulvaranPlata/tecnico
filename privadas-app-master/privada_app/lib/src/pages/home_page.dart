
import 'package:flutter/material.dart';
import 'package:privada_app/src/widgets/app_bar_widget.dart';

import 'body_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new GradientAppBar("Tesoadmin"),
          Expanded(child: HomePageBody())
          
          
        ],
      ),
    );
  }
}
