import 'package:flutter/material.dart';
import 'package:flutter_netflix_ui/screens/nav_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Netflix UI',
        theme: ThemeData.dark(),
        home: NavScreen());
  }
}
