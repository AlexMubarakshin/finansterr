import 'package:flutter/material.dart';

import 'package:finansterr/pages/home.dart';

void main() => runApp(new App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
