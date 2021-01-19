import 'package:flutter/material.dart';

class DetailArt extends StatefulWidget {
  @override
  _DetailArtState createState() => _DetailArtState();
}

class _DetailArtState extends State<DetailArt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'+'التفاصيل'),
        centerTitle: true,
      ),
       body: Container(child:Text('bonjour'))
    );
}
}
