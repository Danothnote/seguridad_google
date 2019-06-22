import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Options extends StatefulWidget {
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  PermissionStatus _status;
  
  @override
  void initState() {
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse).then(_updateStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Opciones"),
       ),
       body: ListTile(
         title: Text("Dar permisos de ubicación"),
         onTap: _askPermission,
       ),
    );
  }

  Future<void> _updateStatus(PermissionStatus status) async {
    if (status != _status) {
      setState(() {
       _status = status;
      });
    }
  }

  Future<void> _askPermission() async {
    PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
  }

  Future<void> _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) async {
    final status = statuses[PermissionGroup.locationWhenInUse];
    if (status != PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
    } else {
    _updateStatus(status);
    }
  }
}