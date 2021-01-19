import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
                              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children:<Widget> [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Tube 50 ml',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    Expanded(

                                      child:   Text(
                                        'CRÈME MINÉRALE SPF 50',textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),),

                                    ],
                              ),
                                  Text(
                                    'Sans filtre chimique',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Sans parfum',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Très haute protection solaire de la peau intolérante du visage',textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Très résistant à l’eau',textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Très large protection UVB-UVA',textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                 Container(margin: EdgeInsets.only(top: 10),
                                   decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                                   padding:EdgeInsets.all(5) ,
                                   child: Text(

                                    'Prix : 48.500 DT',
                                    style: TextStyle(color: Colors.green,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ), )
                                ],
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
