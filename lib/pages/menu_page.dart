import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'generate.dart';
import 'scan.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR and Bar Code Reader & Generator demo"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Scan Code"),
              leading: Icon(MaterialCommunityIcons.qrcode_scan),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ScanPage()));
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Generate QR Code"),
              leading: Icon(MaterialCommunityIcons.qrcode_edit),

              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GeneratePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}