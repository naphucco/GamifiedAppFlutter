import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(DuolingoApp());
}

class DuolingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo Style App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: DuolingoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}