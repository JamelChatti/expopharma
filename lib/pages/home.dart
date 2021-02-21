import 'package:expopharma/compount/mydrawer.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/artlist.dart';
import 'package:expopharma/pages/cosmetforme.dart';
import 'package:expopharma/pages/cosmeto.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/searchArticleByForme.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
    // dataList est uine listé enregistrer dans le fichier data.dart
    // si le fichier contient deja les elément( chargé depuit internet), on l'affiche directement
    if(dataList.length == 0){
      // on va chargé la liste des sock et la liste des médicaments et creer des objets Item
      loadListFromInternet();
    } else {
      loading = false;
    }
  }

 // final fireStoreInstance = Firestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore . instance ;
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
        if(stock != null && stock.length >0){
          int stockInt = int.tryParse(stock.replaceAll(new RegExp(r"\s+"), "")) ?? 0;
          if(id.length>0 && stockInt > 0 ){
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
        String prixAchat = s.split('\t').elementAt(5) ;
        String prixVente = s.split('\t').elementAt(6) ;
        String forme = s.split('\t').elementAt(10) ;
        if((name.length>0 || barCode.length>0) && stockMap[id] != null)
          dataList.add(new Item(id, name, barCode, prixAchat, prixVente,forme, stockMap[id]));
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
          title: Text('عرض لجميع مواد الصيدلية'),
          centerTitle: true,
          elevation: 5,
          actions: <Widget>[
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
        body: ListView(

            children: <Widget>[
          Container(
            height: 180.0,
            width: double.infinity,
            child: Carousel(
              boxFit: BoxFit.fill,
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 3.0,
              dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.grey.withOpacity(0.4),
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 5.0,
              images: [
                // NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                // NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                // ExactAssetImage("assets/images/LaunchImage.jpg"),
                AssetImage(
                  'images/bv.jpg',
                ),
                AssetImage(
                  'images/cadu.jpg',
                ),
                AssetImage(
                  'images/ph.jpg',
                ),
              ],
            ),
          ),
          Divider(height: 10,color: Colors.blue,thickness: 2,),
        Directionality(
            textDirection: TextDirection.ltr,
           child:   Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tapper sur ton choix',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),),
          Container(
            height: 400,
            width: 400,
             child: Directionality(
               textDirection: TextDirection.ltr,


               child: GridView(
               gridDelegate:
               SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
               children: <Widget>[
                 InkWell(
                   child: Card(
                     child: Column(
                       children: <Widget>[
                         Expanded(
                             child: Image.asset('images/categorie/login.jpg',
                                 fit: BoxFit.fill)),
                         Container(
                             child: Text(
                               'Connectez à votre compte',
                               style: TextStyle(fontSize: 15),
                             ))
                       ],
                     ),
                   ),
                   onTap: () {
                     Navigator.of(context).pushNamed('login');
                   },
                 ),

                 InkWell(
                   child: Card(
                     child: Column(
                       children: <Widget>[
                         Expanded(
                             child: Image.asset('images/categorie/lab.jpg',
                                 fit: BoxFit.fill)),
                         Container(
                             child: Text(
                               'LES LABORATOIRES',
                               style: TextStyle(fontSize: 15),
                             ))
                       ],
                     ),
                   ),
                   onTap: () {
                     Navigator.of(context).pushNamed('categories');
                   },
                 ),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/bebe.jfif',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'Articles bébé',
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/complements.jpg',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'Produits phyto et compléments alimentaires',
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/cosmetique.png',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'Soins cosmetique',
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Cosmeto()),
                       );
                     }),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/medicament.jpg',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'Médicaments',
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/orthopedie.jfif',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'Appareils et materiels orthopedique',
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/pedicure.jpg',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                                 'accessoires pour pédicure',
                                 textAlign: TextAlign.center,
                                 style: TextStyle(fontSize: 15),
                               ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 InkWell(
                     child: Card(
                       child: Column(
                         children: <Widget>[
                           Expanded(
                               child: Image.asset('images/categorie/alimentbebe.jfif',
                                   fit: BoxFit.fill)),
                           Container(
                               child: Text(
                             'produit dietetique et alimentation pour bébé',
                             style: TextStyle(fontSize: 15),
                           ))
                         ],
                       ),
                     ),
                     onTap: () {}),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/nore.jfif',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             'NOREVA',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {}),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/nux.jfif',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             'NUXE',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {}),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/pf.png',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             '',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {}),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/svr.png',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             'SVR',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {
                 //       Navigator.of(context).pushNamed('svr');
                 //     }),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/uri.jpg',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             'URIAGE',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {}),
                 // InkWell(
                 //     child: Card(
                 //       child: Column(
                 //         children: <Widget>[
                 //           Expanded(
                 //               child: Image.asset('images/labo/vichy.jpg',
                 //                   fit: BoxFit.fill)),
                 //           Container(
                 //               child: Text(
                 //             'VICHY',
                 //             style: TextStyle(fontSize: 20),
                 //           ))
                 //         ],
                 //       ),
                 //     ),
                 //     onTap: () {
                 //       Navigator.of(context).pushNamed('vichy');
                 //     }),
               ],
             ),),






            // ListView(
            //   // shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     Container(
            //       height: 120,
            //       width: 120,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/avene.png', fit: BoxFit.fill,
            //           height: 100,
            //           // width:30,
            //         ),
            //         subtitle: Text(
            //           'AVENE',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/acm.png',
            //           fit: BoxFit.fill,
            //           height: 100,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'ACM',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/bioderma.jfif',
            //           fit: BoxFit.fill,
            //           height: 100,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'BIODERMA',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/bo.jfif',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'BIO ORIENT',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/eye.png',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'EYE',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/filor.png',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'FILORGA',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/lrp.png',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'LA ROCHE POSAY',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/nature.jpg',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'NATURELAB',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/nore.jfif',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'NOREVA',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/nux.jfif',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'NUXE',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/pf.png',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'PIERRE FABRE',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/svr.png',
            //           fit: BoxFit.fill,
            //           height: 100,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'SVR',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ),
            //
            //     Container(
            //       height: 120,
            //       width: 100,
            //       child: ListTile(
            //         title: Image.asset(
            //           'images/labo/vichy.jpg',
            //           fit: BoxFit.fill,
            //           height: 80,
            //           width: 80,
            //         ),
            //         subtitle: Text(
            //           'VICHY',
            //           style: TextStyle(
            //               color: Colors.purpleAccent,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //           textAlign: TextAlign.center,
            //         ),
            //       ), //
            //     ), //
            //
            //     //
            //   ],
            // ),
          ),
              Divider(height: 10,color: Colors.blue,thickness: 1,),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'اخر المنتجات',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
          //start latest product
          Container(
            height: 300,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: <Widget>[
                InkWell(
                  child:
                    GridTile(
                      child: Image.asset(
                        'images/labo/avene/avclex.jfif',
                      ),
                      footer: Container(
                        height: 25,
                        color: Colors.tealAccent,
                        child: Text(
                          'AVENE TRIACNYL ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  onTap: (){},
                ),
                InkWell(child:
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avcima.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE CICALFATE ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                  onTap: (){},),
                InkWell(child:
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avclge.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE CLEANANCE GEL',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                  onTap: (){},
                ),
                InkWell(child:
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/aveath150.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE EAU THERMALE ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                  onTap: (){},
                ),
                InkWell(child:
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avecmi.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE mineral cr SPF50 ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                  onTap: (){},
                )
              ],
            ),//
          ),

          //end latest product
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
        future:getsearchdata(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length, itemBuilder: (context, i) {
              return ArticleList(

              );
            });
          }
          return Center(child: CircularProgressIndicator(),);
         });  }

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
            onTap: (){
              query=searchlist[i];
              showResults(context);
            },
          );
        });
  }
}
