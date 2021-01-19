import 'package:flutter/material.dart';

class Vichy extends StatefulWidget {
  @override
  _VichyState createState() => _VichyState();
}

class _VichyState extends State<Vichy> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,child: Scaffold(
      appBar: AppBar(
        title: Text('مخابر'+'  Vichy'),
        centerTitle: true,
      ),
      body: Container(child: Text('Bonjourصباح الخير'),),
    ),);
  }
}