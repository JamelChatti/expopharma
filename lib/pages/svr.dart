
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/artlist.dart';
import 'package:expopharma/pages/data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';





class Svr extends StatefulWidget {
  @override
  _SvrState createState() => _SvrState();
}

class _SvrState extends State<Svr> {


  List<Item> medicaments = new List();

  FirebaseFirestore firestore = FirebaseFirestore . instance ;

  @override
  void initState() {
    super.initState();
    fetchProduit();
  }

  Future<List<Item>> fetchProduit() async {
    medicaments.clear();
   FirebaseFirestore.instance
        .collection('produits')
        .orderBy('name', descending: false)
        .snapshots().forEach((data) {
      // data.documents.forEach((doc) {
      //   print(doc.documentID);
      //   medicaments.add(new Article(doc.documentID, doc["name"].toUpperCase(),
      //       doc["nbreDemande"], doc["timestamp"]));
      // });
      print("done");
      // medicaments.length > 0 ? addNewMed = false : addNewMed = true;
      // setState(() {
      //   myController.clear();
      //   //FocusScope.of(context).requestFocus(FocusNode());
      //   addNewMed;
      //   medicaments;
      // });
    }).whenComplete(() {

    });

    return null;
  }

 //  Future getData() async {
  //   var url = 'http://192.168.42.23/pharmexpo/index.php';
  //   var response = await http.get(url);
  //   var responseody = jsonDecode(response.body);
  //   return responseody;
  // }

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Avene'),
          centerTitle: true,
        ),
        //drawer: MyDrawer(),
        body: FutureBuilder(
            // future: getData(),
           // future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ArticleList(
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}

