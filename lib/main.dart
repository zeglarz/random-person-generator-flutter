import 'package:flutter/material.dart';
import 'package:randompersongenerator/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Person Generator',
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
