import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/ajoutAuPanier.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expopharma/pages/shoppingCard.dart';

List<Vente> listCommande = new List();
//List<ItemForme> formes = [];

Future CheckEmptyMethod() {
  bool empty = false;
  Padding(
      padding: EdgeInsets.only(right: 5),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cmmandeClient')
              .snapshots(),
          builder: (context, snapshot) {
            String result;
            if (snapshot.connectionState == ConnectionState.waiting) {
              result = "";
            } else if (snapshot.hasError) {
              result = "";
            } else if (snapshot.hasData) {
              QuerySnapshot values = snapshot.data;
              if (values != null) {
                result = snapshot.data.size.toString();
              } else {
                result = "";
              }
            }
            return Row(
              children: <Widget>[
                empty
                    ? Container(
                        height: 60,
                        width: 70,
                        child: RaisedButton(
                          elevation: 10,
                          color: Colors.redAccent[200],
                          clipBehavior: Clip.none,
                          padding:
                              EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                          onPressed: () {
//_showMyDialog(context, widget.article);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Ajouter au panier',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                margin: EdgeInsets.only(top: 0),
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Text('Le panier n\'est pas vide'),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 90,
                                child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.green,
                                  clipBehavior: Clip.none,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 2),
                                  onPressed: () {
//_showMyDialog(context, widget.article);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Ajouter d\'autres articles',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin: EdgeInsets.only(top: 0),
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 60,
                                width: 70,
                                child: RaisedButton(
                                  elevation: 10,
                                  color: Colors.green,
                                  clipBehavior: Clip.none,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1, horizontal: 2),
                                  onPressed: () {
//showMyDialogViderpanier(context, widget.article);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Vider le panier ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin: EdgeInsets.only(top: 0),
                                        padding: EdgeInsets.only(left: 10),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
              ],
            );
//
          }));
}
