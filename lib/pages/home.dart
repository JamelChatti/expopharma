import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expopharma/compount/mydrawer.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/ItemCategorie.dart';
import 'package:expopharma/pages/artlist.dart';
import 'package:expopharma/pages/client.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:expopharma/pages/categorie.dart';
import 'package:expopharma/pages/imageScreen.dart';
import 'package:expopharma/pages/itemVitrine.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/searchArticleByForme.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:expopharma/pages/shoppingCard.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ItemForme.dart';
import 'commandeAExecuter.dart';
import 'displayvente.dart';

// import 'package:medicamentlist/Item.dart';
// import 'package:medicamentlist/ListVente.dart';
// import 'package:medicamentlist/Vente.dart';
// import 'package:medicamentlist/data.dart';
// import 'package:medicamentlist/history.dart';
//import 'package:badges/badges.dart';

//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:fluttericon/font_awesome5_icons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItemCategorie> categories = [];
  List<ItemVitrine> vitrines = [];
  String idarticle;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vitrines.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl.image), context);
      });
    });
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
    // dataList est uine listé enregistrer dans le fichier data.dart
    // si le fichier contient deja les elément( chargé depuit internet), on l'affiche directement
    if (dataList.length == 0) {
      // on va chargé la liste des sock et la liste des médicaments et creer des objets Item
      loadListFromInternet();
    } else {
      loading = false;
    }
  }

  TextEditingController myTextFieldController;

 // int shopCount = 0;

  HashMap<String, String> stockMap = new HashMap();

  List<Item> displayedList = new List();
  bool loading = true;
  List<Item> articles = [];

  // List<Vente> listVentes = new List();
  //
  // bool showPrixAchat = currentUser.isAdmin;
  // bool addNewVente = false;

  void loadListFromInternet() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('stock.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpstock.txt');
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    await tempFile2.create();
    assert(await tempFile2.readAsString() == "");
    await ref2.writeToFile(tempFile2);
    Uint8List contents2 = await tempFile2.readAsBytes();
    LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
      if (s.split('\t').length > 5) {
        String id = s.split('\t').elementAt(0);
        String stock = s.split('\t').elementAt(2);
        if (stock != null && stock.length > 0) {
          int stockInt =
              int.tryParse(stock.replaceAll(new RegExp(r"\s+"), "")) ?? 0;
          if (id.length > 0 && stockInt > 0) {
            stockMap.putIfAbsent(id, () => stock);
          }
        }
      }
    }).toList();

    print(stockMap.length);

    // On a chargé la liste de stock dans une map
    // Maintenant on cree
    // nos objet Item a partir de la liste des médicament et la map de stock

    loadListFromInternet3();

  }
  HashMap<String, int> dateExpMap = new HashMap();

  void loadListFromInternet3() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('perm.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpsperm.txt');
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    await tempFile2.create();
    assert(await tempFile2.readAsString() == "");
    await ref2.writeToFile(tempFile2);
    Uint8List contents2 = await tempFile2.readAsBytes();
    LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
        String id = s.split('\t').elementAt(0);
        String dateString = s.split('\t').elementAt(4);
        dateString= dateString.split('\/').reversed.join();
        print(dateString);
        int dateStringInt =
            int.tryParse(dateString.replaceAll(new RegExp(r"\s+"), "")) ?? 0;

         if (id.length > 0 && dateStringInt >0) {
          dateExpMap.putIfAbsent(id, () => dateStringInt);
         }

    }).toList();

    print(dateExpMap.length );
    loadListFromInternet2();
    // On a chargé la liste de stock dans une map
    // Maintenant on cree
    // nos objet Item a partir de la liste des médicament et la map de stock
    //loadListFromInternet2();
  }

  void loadListFromInternet2() async {
    final ref2 = FirebaseStorage.instance.ref().child('listtxt.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmplisttxt.txt');
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    await tempFile2.create();
    assert(await tempFile2.readAsString() == "");
    await ref2.writeToFile(tempFile2);
    Uint8List contents2 = await tempFile2.readAsBytes();
    LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
      if (s.split('\t').length > 7) {
        String id = s.split('\t').elementAt(0);
        String name = s.split('\t').elementAt(2);
        String barCode = s.split('\t').elementAt(1);
        String prixAchat = s.split('\t').elementAt(5);
        String prixVente = s.split('\t').elementAt(6);
        String forme = s.split('\t').elementAt(11);
        if ((name.length > 0 || barCode.length > 0) && stockMap[id] != null)
         // if ((name.length > 0 || barCode.length > 0) && stockMap[id] != null)
          dataList.add(new Item(
              id, name, barCode, prixAchat, prixVente, forme, stockMap[id],dateExpMap[id]));
      }
    }).toList();
    setState(() {
      loading = false;
    });

    print(dataList.length);


  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'عرض لجميع مواد الصيدلية',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: false,
          elevation: 5,
          actions: <Widget>[
           // MyShoppingCard("ventes"),
            MyShoppingCard("commandeClient"),
            IconButton(
              icon: Icon(Icons.person,size: 20,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Client()),
                );
              },
            ),

            IconButton(
              icon: Icon(Icons.search,size: 20,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchArticle()),
                );
              },
            )
          ],
          backgroundColor: Colors.deepPurple,
          titleSpacing: 1,
        ),
       drawer: MyDrawer(),
        body: ListView(children: <Widget>[
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('vitrine')
                      .snapshots(),
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (dataSnapshot.hasError) {
                      return Container();
                    } else if (dataSnapshot.hasData) {
                      // vitrines.clear();
                      dataSnapshot.data.docs.forEach((result) {
                        String id = result.id;
                        String name = result["name"];
                        String image = result["image"];
                        ItemVitrine itemVitrine =
                            new ItemVitrine(id, name, image);
                        vitrines.add(itemVitrine);
                      });
                      dataVitrines.addAll(vitrines);

                      return CarouselSlider.builder(
                        //itemCount: vitrines.length,
                        itemCount: 4,
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(5),
                            // decoration: BoxDecoration(color: Colors.amber),
                            child: GestureDetector(
                                child: Stack(fit: StackFit.expand, children: <
                                    Widget>[
                                  Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/articles%2F' +
                                        vitrines.elementAt(index).image +
                                        '?alt=media',
                                    fit: BoxFit.fill,
                                    //height: 120,
                                  ),
                                  // Padding(
                                  //     padding: EdgeInsets.only(bottom: 10),
                                  //     child:
                                  Positioned.fill(
                                    bottom: 10,
                                    top: 10,
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: 4, top: 4),
                                            height: 25,
                                            width: double.infinity,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            child: Text(
                                              vitrines.elementAt(index).name,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ))),
                                  )
                                  //),
                                ]),
                                onTap: () {
                                  idarticle = vitrines
                                      .elementAt(index)
                                      .image
                                      .substring(
                                          0,
                                          vitrines
                                              .elementAt(index)
                                              .image
                                              .indexOf('.'));
                                  print(vitrines.elementAt(index).image);
                                  Item article = dataList.firstWhere(
                                      (element) => element.id == idarticle);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailArticl(article)),
                                  );
                                }),
                          );
                        },
                      );
                    }
                  })),
          Divider(
            height: 10,
            color: Colors.blue,
            thickness: 2,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Tapper sur votre choix',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.width,
            // width: 400,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('categorie')
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (dataSnapshot.hasData) {
                    categories.clear();
                    dataSnapshot.data.docs.forEach((result) {
                      String id = result.id;
                      String name = result["name"];
                      String image = result["image"];
                      ItemCategorie itemCategorie =
                          new ItemCategorie(id, name, image);
                      categories.add(itemCategorie);
                    });
                    dataCategories.addAll(categories);
                    return GridView.builder(
                      itemCount: categories.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      // crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (context, i) {
                        return new Card(
                          elevation: 5,
                          shadowColor: Colors.cyanAccent,
                          child: InkWell(
                            child: Container(
                              height: 500,
                              padding: EdgeInsets.all(20),
                              color: Colors.blueGrey[200],
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                      flex: 5,
                                      child: Container(
                                        child: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/categorie%2F' +
                                                categories.elementAt(i).image +
                                                '?alt=media'),
                                        // height: 70,
                                        //  width: 100,
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  categories.elementAt(i).name.length > 20
                                      ? Flexible(
                                          flex: 3,
                                          child: Text(
                                            categories.elementAt(i).name,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ))
                                      : Flexible(
                                          flex: 2,
                                          child: Text(
                                            categories.elementAt(i).name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Categorie(
                                        categories.elementAt(i).id,
                                        categories.elementAt(i).name)),
                              );
                            },
                          ),
                          //
                        );
                      },
                    );
                  }
                }),
          ),
        ]),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<dynamic> list;

  DataSearch({this.list});

  Future getsearchdata() async {
    return dataList;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //action pour l'appbar
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icon leading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //resultats de recherche
    return FutureBuilder(
        future: getsearchdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return ArticleList();
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //ce que apparait quand on est entrain de rechercher
    var searchlist =
        query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
        itemCount: searchlist.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.label),
            title: Text(searchlist[i]),
            onTap: () {
              query = searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
