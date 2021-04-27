import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/articlVitrine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:expopharma/pages/data.dart';

class AjousupArtvitrine extends StatefulWidget {
  @override
  _AjousupArtvitrineState createState() => _AjousupArtvitrineState();
}

class _AjousupArtvitrineState extends State<AjousupArtvitrine> {
  List<Item> articles = [];
  List<ArticlVitrine> articlvitrin = new List();
  bool addNewMed = false;
  String articleNameChoisi = '';
  String articleIdChoisi = '';
  Item articleSelected;
  String imageName;
  List<ArticlVitrine> medicaments = new List();
  String idVitrine;
  String image;
  String name;


  @override
  void initState() {
    super.initState();
    fetchProduit();
  }

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
  Future<List<ArticlVitrine>> fetchProduit() async {
    articlvitrin.clear();
    FirebaseFirestore.instance
        .collection('vitrine')
        .orderBy('name', descending: false)
        .snapshots()
        .forEach((data) {
      data.docs.forEach((doc) {
        print(doc.id);
        articlvitrin.add(new ArticlVitrine(doc.id, doc["image"], doc["name"]));
      });
      print("done");
      articlvitrin.length > 0 ? addNewMed = false : addNewMed = true;
      setState(() {
        // myController.clear();
        //FocusScope.of(context).requestFocus(FocusNode());
        addNewMed;
        articlvitrin;
      });
    }).whenComplete(() {});
    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajouter ou retirer un article de la vitrine'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Faites un long appuis sur l\'article que vous voulez retirer de la vitrine',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(


                  child: Container(
                      padding: EdgeInsets.all(20),
                      child: Text('Ajouter un article',style: TextStyle(fontSize: 20,),)),
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
                                        articlvitrin.clear();
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left: 30),
                  child: ListView.builder(
                    itemCount: articlvitrin.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onLongPress: () {
                                suppressionDialog(index);
                              },
                              child: Text(
                                articlvitrin[index].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )));
                    },
                  ),
                ),
              ),
            ],
          ),
          //       ElevatedButton(onPressed: () {}, child: Text('Supprimer')),
          //     ],
          //   ),
          // ),
        ));
  }

  Future<List<ArticlVitrine>> removeProduit(String id, String name) async {
    FirebaseFirestore.instance
        .collection('vitrine')
        .doc(id)
        .delete()
        .whenComplete(() {
      print("complete");
      final snackBar = SnackBar(
          content: Text(
        name + '   supprime',
        textAlign: TextAlign.center,
      ));
      Scaffold.of(context).showSnackBar(snackBar);
      articlvitrin.clear();
      fetchProduit();
    });
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

  Future<void> suppressionDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Retirer un article'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous retirer  : ' +
                    articlvitrin[index].name + '  de la vitrine?'
                    ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('NON'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OUI'),
              onPressed: () {
                removeProduit(
                    articlvitrin[index].idVitrine, articlvitrin[index].name);
                setState(() {
                  articlvitrin.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
