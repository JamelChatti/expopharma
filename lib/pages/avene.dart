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
  var articlelist = [{
     'nom':'Creme minérale spf50+',
    'forme':'Créme',
    'indication':'écran solaire',
    'utilisation':'renouvelez fréquemment l’application',
    'proprietes':'trés résistant à l\'eau',
    'prix':'48500 dt'
  },
    {
      'nom':'Cleanance gel nettoyant ',
      'forme':'Gel',
      'indication':'Bouton et imperfection',
      'utilisation':'une à deux fois par jour',
      'proprietes':'nettoyant matifiant apaisant',
      'prix':'30300 dt'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Aveneمخابر'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: articlelist.length,
          itemBuilder: (context,i){
            return//debut de la liste
              InkWell(
                child: Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          'Designation: ',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            articlelist[i]['nom'],
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                        Row(
                                          children: [
                                            Text(
                                              'Forme: ',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              articlelist[i]['forme'],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '    Indication: ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              articlelist[i]['indication'],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),

                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        Text(
                                          'Proprités: ',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              articlelist[i]['proprietes'],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'Sans parfum',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'Très résistant à l’eau',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              'Très large protection ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [Text(
                                        'Prix :',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                        Container(
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.red)),
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            articlelist[i]['prix'],
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      'Pour plus d\'information taper sur l\'image',
                                      style: TextStyle(
                                          color: Colors.orange, fontSize: 10),
                                    )
                                  ],
                                )))
                        //Expended التمدد
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              );
          },



            //fin de la liste

        ));
  }
}
