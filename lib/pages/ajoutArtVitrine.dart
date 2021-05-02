import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/articlVitrine.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:expopharma/pages/data.dart';

class AjoutArticlevitrine extends StatefulWidget {
  @override

  _AjoutArticlevitrineState createState() => _AjoutArticlevitrineState();
}

class _AjoutArticlevitrineState extends State<AjoutArticlevitrine> {
  List<Item> articles = [];
  List<Item> displayedList = new List();
 String idVitrine;
  String image;
  String name;

  String articleNameChoisi = '';
  String articleIdChoisi = '';
  Item articleSelected;
  String imageName;
  List<ArticlVitrine> medicaments = new List();
  bool addNewMed = false;
  final fireStoreInstance = FirebaseFirestore.instance;
  @override
  Future<List<ArticlVitrine>> fetchArticlVitrine() async {
    medicaments.clear();
    FirebaseFirestore.instance
        .collection('vitrine')
        .orderBy('name', descending: false)
        .snapshots().forEach((data) {
      data.docs.forEach((doc) {
        print(doc.id);
        medicaments.add(new ArticlVitrine(doc.id, doc["image"],
            doc["name"]));
      });
      print("done");
      medicaments.length > 0 ? addNewMed = false : addNewMed = true;
      setState(() {
       addNewMed;
        medicaments;
      });
    }).whenComplete(() {
    });
    return null;
  }
  Future<ArticlVitrine> saveArticle(String idVitrine , String image , String name) async {
    FirebaseFirestore.instance.collection("vitrine").add({
      //'ventes': myList.toMap(),
      'idVitrine': idVitrine,
      'image':image ,
      'name': name,
    }).then((value) {
      print(name);
      FocusScope.of(context).requestFocus(FocusNode());

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un article à la vitrine'),
      ),
      body:  Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(


                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text('Choisir un article',style: TextStyle(fontSize: 20,),)),
                onPressed: () {
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chercher article'),
                          content: Center(
                            child: Column(
                              children: <Widget>[
                                TypeAheadField(
                                  textFieldConfiguration:
                                  TextFieldConfiguration(
                                      autofocus: true,
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder())),
                                  suggestionsCallback: (pattern) async {
                                    return getListArticles(pattern);
                                  },
                                  itemBuilder: (context, Item suggestion) {
                                    return ListTile(
                                      //leading: Icon(Icons.shopping_cart),
                                      title: Text(suggestion.name),
                                      subtitle: Text(suggestion.barCode),
                                    );
                                  },
                                  onSuggestionSelected: (Item suggestion) {
                                    print(suggestion);
                                    articleSelected = suggestion;
                                    imageName = suggestion.id + '.png';
                                    articleNameChoisi = suggestion.name;
                                    articleIdChoisi= suggestion.id;
                                    setState(() {
                                      idVitrine=articleIdChoisi;
                                      image=imageName;
                                      name=articleNameChoisi;
                                      saveArticle(idVitrine,image,name);
                                      print(name);

                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            Container(child: Text(articleNameChoisi),),
            ElevatedButton(onPressed:(){
              idVitrine=articleIdChoisi;
              image=imageName;
              name=articleNameChoisi;
              saveArticle(idVitrine,image,name);
              print(name);
            } , child: Container(padding: EdgeInsets.all(20),child: Text('Ajouter')))

          ],
        ),
      ),
    );
  }
  List<Item> getListArticles(String value) {
    articles.clear();
    dataList.forEach((element) {
      if (element.name.toLowerCase().startsWith(value.toLowerCase())) {
        articles.add(element);
      }
    });
    print(articles.length);
    return articles;
  }
}
