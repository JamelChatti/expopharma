import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/ItemForme.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/forme.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expopharma/pages/shoppingCard.dart';

class Categorie extends StatefulWidget {
  final String categorie;
  final String name;

  Categorie(this.categorie,this.name);

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<ItemForme> formes = [];
  final fireStoreInstance = FirebaseFirestore.instance.collection('forme');

  List<Vente> listCommande = new List();
  int shopCount = 0;

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
        title: Text(widget.name),
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        // Padding(
        //     padding: EdgeInsets.only(right: 5),
        //     child: StreamBuilder(
        //         stream: FirebaseFirestore.instance
        //             .collection('ventes')
        //             .snapshots(),
        //         builder: (context, snapshot) {
        //           QuerySnapshot values = snapshot.data;
        //           //print(values.size);
        //           return Badge(
        //             position: BadgePosition.topEnd(
        //               top: 10,
        //               end: 30,
        //             ),
        //             badgeContent: values !=null && values.size == 0
        //                 ? Text(
        //               '',
        //               style: TextStyle(color: Colors.white),
        //             )
        //                 : Text(
        //               values.size.toString(),
        //               style:
        //               TextStyle(color: Colors.white, fontSize: 7),
        //             ),
        //             child: IconButton(
        //               icon: Icon(
        //                 Icons.add_shopping_cart,
        //                 color: Colors.white,
        //                 size: 20,
        //               ),
        //               onPressed: () async {
        //                 if (values.size != 0) {
        //                   await Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => CommandeClient()),
        //                   ).then((value) {
        //                     //  if(value == "SAVED"){
        //                     setState(() {
        //                       //  listCommande.clear();
        //                       // shopCount = 0;
        //                     });
        //                     //}
        //                   });
        //                 } else {
        //                   final snackBar = SnackBar(
        //                       content: Text(
        //                         ' Vente vide, veillez ajouter au moins un article',
        //                         textAlign: TextAlign.center,
        //                       ));
        //                   Scaffold.of(context).showSnackBar(snackBar);
        //                 }
        //               },
        //             ),
        //           );
        //         })),
          MyShoppingCard("commandeClient"),
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
                    String id = result["id"];
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
                          footer:Container(
                          height: 40,
                          color: Colors.grey.withOpacity(1),
                      alignment: Alignment.center,
                         child: new Text(

                            formes.elementAt(i).name,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          child:Container(
                            padding: EdgeInsets.only(bottom: 45,top: 30,right: 30,left: 30),
                            color: Colors.blueGrey[100],
                            child:Image.network(
                             //'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/forme%2F105.png?alt=media',
                            'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/forme%2F' +
                                formes.elementAt(i).image +
                                '?alt=media',
                            fit: BoxFit.fill,
                            //height: 100,
                          ), )
                          //just for testing, will fill with image later
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Forme(
                                    formes.elementAt(i).id, "FORME",formes.elementAt(i).name)),
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

