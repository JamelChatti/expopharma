import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/commandeAExecuter.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/displayvente.dart';
import 'package:flutter/material.dart';

class MyShoppingCard extends StatefulWidget {
  final String type;
  MyShoppingCard(this.type);
  @override
  _MyShoppingCardState createState() => _MyShoppingCardState();
}

class _MyShoppingCardState extends State<MyShoppingCard> {
  @override
  Widget build(BuildContext context) {

    String streamBuilderType;

    if(widget.type == "ventes"){
      streamBuilderType = "ventes";
    }
    if(widget.type == "commandeClient"){
      streamBuilderType = "commandeClient";
    }

    return Padding(
        padding: EdgeInsets.only(right: 5),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(streamBuilderType)
                .snapshots(),
            builder: (context, snapshot) {
              String result;
              if(snapshot.connectionState == ConnectionState.waiting) {
                result = "";
              }
              else if(snapshot.hasError){
                result = "";
              } else if(snapshot.hasData){
                QuerySnapshot values = snapshot.data;
                if(values !=null){
                  result = snapshot.data.size.toString();
                } else {
                  result = "";
                }
              }
              return Badge(
                position: BadgePosition.topEnd(
                  top: 10,
                  end: 30,
                ),
                badgeContent: Text(
                  result,
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () async {
                   if (result != '') {
                     if(widget.type=='ventes'){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => CommandeAExecuter()),

                       );
                     }else if(widget.type=='commandeClient') {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => DisplayVente()));

                     }

                   } else {
                     final snackBar = SnackBar(
                         content: Text(
                           ' Vente vide, veillez ajouter au moins un article',
                           textAlign: TextAlign.center,
                         ));
                     Scaffold.of(context).showSnackBar(snackBar);
                   }
                  },
                ),
              );
            }));
  }
}