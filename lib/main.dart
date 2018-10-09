import 'package:flutter/material.dart';
import 'user_interface.dart';

void main() => runApp(BmiApp());

class BmiApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.white,
          primarySwatch: Colors.pink,
          buttonColor: Colors.white,
          textSelectionColor: Colors.white,
          textTheme: TextTheme()),
      home: UserInterface(),
    );
  }
}
