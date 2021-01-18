import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Avene extends StatefulWidget {
  @override
  _AveneState createState() => _AveneState();
}

class _AveneState extends State<Avene> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Aveneمخابر'),
            centerTitle: true,
          ),
          body: ListView(
            children: <Widget>[
              //debut de la liste
              Container(
                height: 200,
                width: 100,
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Image.asset('images/labo/avene/avecmi.jfif'),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              height: 200,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              )))
                      //Expended التمدد
                    ],
                  ),
                ),
              )
              //fin de la liste
            ],
          )),
    );
  }
}
