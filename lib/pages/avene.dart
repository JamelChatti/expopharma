import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:expopharma/compount/artlist.dart';
class Avene extends StatefulWidget {
  @override
  _AveneState createState() => _AveneState();
}

class _AveneState extends State<Avene> {
  var artlist = [{
    'nom': 'Creme minérale spf50+',
    'forme': 'Créme',
    'indication': 'écran solaire',
    'utilisation': 'renouvelez fréquemment l’application',
    'proprietes': 'trés résistant à l\'eau',
    'contenance': '50ml',
    'prix': '48500 dt'
  },
    {
      'nom': 'Cleanance gel nettoyant ',
      'forme': 'Gel',
      'indication': 'Bouton et imperfection',
      'utilisation': 'une à deux fois par jour',
      'proprietes': 'nettoyant matifiant apaisant',
      'contenance': '200ml',
      'prix': '30300 dt'
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
          itemCount: artlist.length,
          itemBuilder: (context, i) {
            return ArtList(nom: artlist[i]['nom'],
                forme: artlist[i]['forme'],
                indication: artlist[i]['indication'],
                proprietes: artlist[i]['proprietes'],
                utilisation: artlist[i]['utilisation'],
                contenance: artlist[i]['contenance'],
                prix: artlist[i]['prix']); //debut de la liste

          },


          //fin de la liste

        ));
  }
}

