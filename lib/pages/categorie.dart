import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/cosmeto/deo.dart';
import 'package:expopharma/pages/ItemForme.dart';
import 'package:expopharma/pages/forme.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Categorie extends StatefulWidget {
  final String categorie;

  Categorie(this.categorie);

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<ItemForme> formes = [];
  final fireStoreInstance = FirebaseFirestore.instance.collection('forme');

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   myTextFieldController = new TextEditingController();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Cosmétique'),
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[300],
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('categorie').doc(widget.categorie).collection("forme").snapshots(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  print(widget.categorie);
                  return Center(child: CircularProgressIndicator());
                } else if (dataSnapshot.hasData) {
                  formes.clear();
                  dataSnapshot.data.docs.forEach((result) {
                    int id = result["id"];
                    String name = result["name"];
                    String image = result["image"];
                    ItemForme itemForme = new ItemForme(id, name, image);
                    formes.add(itemForme);
                  });
                  dataFormes.addAll(formes);
                  return GridView.builder(
                    itemCount: formes.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    // crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                    itemBuilder: (context, i) {
                      return new Card(
                          child: InkWell(
                        child: new GridTile(
                          footer: new Text(
                            formes.elementAt(i).name,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          child:Container(padding: EdgeInsets.all(30),
                            height: 100,
                            width: 100,
                            color: Colors.blueGrey[100],
                            child:Image.network(
                            // 'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon.jfif?alt=media',
                            'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/' +
                                formes.elementAt(i).image +
                                '?alt=media',
                            fit: BoxFit.cover,
                            height: 100,
                          ), )
                          //just for testing, will fill with image later
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Forme(
                                    formes.elementAt(i).id, "FORME")),
                          );
                        },
                      ));
                    },
                  );
                }
              })),
    );
  }
}

