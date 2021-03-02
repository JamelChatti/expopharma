import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expopharma/compount/mydrawer.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/ItemCategorie.dart';
import 'package:expopharma/pages/artlist.dart';
import 'package:expopharma/pages/forme.dart';
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ItemForme.dart';
import 'commandeClients.dart';
import 'displayvene.dart';

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

  int shopCount = 0;

  HashMap<String, String> stockMap = new HashMap();
  List<Item> displayedList = new List();
  bool loading = true;

  // List<Vente> listVentes = new List();

  bool showPrixAchat = currentUser.isAdmin;
  bool addNewVente = false;

  void loadListFromInternet() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('stock.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmplistemed.txt');
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
    // Maintenant on creer nos objet Item a partir de la liste des médicament et la map de stock
    loadListFromInternet2();
  }

  void loadListFromInternet2() async {
    final ref2 = FirebaseStorage.instance.ref().child('listtxt.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmplistemed2.txt');
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
        String forme = s.split('\t').elementAt(10);
        if ((name.length > 0 || barCode.length > 0) && stockMap[id] != null)
          dataList.add(new Item(
              id, name, barCode, prixAchat, prixVente, forme, stockMap[id]));
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
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: false,
          elevation: 5,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 5),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ventes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      QuerySnapshot values = snapshot.data;
                      //print(values.size);
                      return Badge(
                        position: BadgePosition.topEnd(
                          top: 10,
                          end: 30,
                        ),
                        badgeContent: values.size == 0
                            ? Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                values.size.toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 7),
                              ),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 25,
                          ),
                          onPressed: () async {
                            if (values.size != 0) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommandeClient()),
                              ).then((value) {
                                //  if(value == "SAVED"){
                                setState(() {
                                  //  listCommande.clear();
                                  // shopCount = 0;
                                });
                                //}
                              });
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
                    })),
            IconButton(
              icon: Icon(Icons.search),
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
                    } else if (dataSnapshot.hasData) {
                      // vitrines.clear();
                      dataSnapshot.data.docs.forEach((result) {
                        String id = result.id;
                        String name = result["name"];
                        String image = result["image"];
                        ItemVitrine itemVitrine = new ItemVitrine(id,name, image);
                        vitrines.add(itemVitrine);
                      });
                         dataVitrines.addAll(vitrines);

                      return CarouselSlider.builder(
                        itemCount: vitrines.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: GestureDetector(
                                child: Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon%2F'+vitrines.elementAt(index).image+'.jpg?alt=media',
                                    fit: BoxFit.fill),
                                onTap: () {
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
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
          ),
          Container(
            height: 400,
            width: 400,
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
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              color: Colors.blueGrey[200],
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/' +
                                            categories.elementAt(i).image +
                                            '?alt=media'),
                                    height: 70,
                                    width: 100,
                                  ),
                                  SizedBox(height: 15,),
                                  Text(
                                    categories.elementAt(i).name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Categorie(categories.elementAt(i).id)),
                              );
                            },

                            // child: new GridTile(
                            //   footer: new Text(
                            //     categories
                            //         .elementAt(i)
                            //         .name,
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         color: Colors.blue,
                            //         fontWeight: FontWeight.bold),
                            //     textAlign: TextAlign.center,
                            //   ),
                            //   child: Image.network(
                            //       'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/' +
                            //           categories
                            //               .elementAt(i)
                            //               .image +
                            //           '?alt=media'),
                            //just for testing, will fill with image later
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

  // Future getsearchdata() async {
  //   var url = 'http://192.168.42.23/pharmexpo/searchart.php';
  //   var data={'searcharticl' : query};
  //   var response = await http.post(url, body: data);
  //   var responsebody = jsonDecode(response.body);
  //   return responsebody;
  // }

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
// class MyCarousel extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MyCarouselState();
//   }
// }
//
// class _MyCarouselState extends State<MyCarousel> {
//   List<ItemVitrine> vitrines = [];
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       vitrines.forEach((imageUrl) {
//         precacheImage(NetworkImage(imageUrl.image), context);
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Prefetch image slider demo')),
//       body: Container(
//           child: CarouselSlider.builder(
//             itemCount: vitrines.length,
//             options: CarouselOptions(
//               autoPlay: true,
//               aspectRatio: 2.0,
//               enlargeCenterPage: true,
//             ),
//             itemBuilder: (context, index, realIdx) {
//               return Container(
//                 child: Center(
//                     child: Image.network(vitrines.elementAt(index).image, fit: BoxFit.cover, width: 1000)
//                 ),
//               );
//             },
//           )
//       ),
//     );
//   }
// }
