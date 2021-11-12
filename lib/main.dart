import 'package:flutter/material.dart';
import 'package:topicos_p2/pages/login.dart';
import 'package:flutter/widgets.dart';

void main() async {
  runApp(TopicosP2());
}

class TopicosP2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
    );
  }
}