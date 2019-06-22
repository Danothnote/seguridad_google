import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Options extends StatefulWidget {
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Opciones"),
       ),
    );
  }
}