import 'package:flutter/material.dart';

class Svr extends StatefulWidget {
  @override
  _SvrState createState() => _SvrState();
}

class _SvrState extends State<Svr> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,child: Scaffold(
      appBar: AppBar(
        title: Text('مخابر'+'  SVR'),
        centerTitle: true,
      ),
      body: Container(child: Text('Bonjourصباح الخير'),),
    ),);
  }
}