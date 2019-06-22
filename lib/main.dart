import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seguridad Turística',
      theme: ThemeData(
        primaryColor: Color(0xFF3863F3),
      ),
      home: HomePage(),
    );
  }
}
