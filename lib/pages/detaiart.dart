// import 'package:expopharma/pages/Item.dart';
// import 'package:expopharma/pages/data.dart';
// import 'package:expopharma/pages/listeVente.dart';
// import 'package:expopharma/pages/vente.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:collection';
// import 'package:badges/badges.dart';
// import 'dart:collection';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:io';
// import 'package:uuid/uuid.dart';
//
//
// class DetailArt extends StatefulWidget {
//   DetailArt({Key key, this.title,this.article}) : super(key: key);
//   final String title;
//   Item article;
//
//
//   @override
//   _DetailArtState createState() => _DetailArtState();
// }
//
//
//
// class _DetailArtState extends State<DetailArt> with AutomaticKeepAliveClientMixin {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     // // dataList est uine listé enregistrer dans le fichier data.dart
//     // // si le fichier contient deja les elément( chargé depuit internet), on l'affiche directement
//     // if(dataList.length == 0){
//     //   // on va chargé la liste des sock et la liste des médicaments et creer des objets Item
//     //   loadListFromInternet();
//     // } else {
//     //   loading = false;
//     // }
//   }
//
//   final fireStoreInstance = FirebaseFirestore.instance;
//   //
//   // TextEditingController myTextFieldController;
//
//   int shopCount = 0;
//
//   HashMap<String, String> stockMap = new HashMap();
//   List<Item> displayedList = new List();
//   bool loading = true;
//   List<Vente> listVentes = new List();
//
//   bool showPrixAchat = currentUser.isAdmin;
//   bool addNewVente = false;
//
//
//
//
//   // void loadListFromInternet() async {
//   //
//   //   // D'abort on charge la liste des stock
//   //   final ref2 = FirebaseStorage.instance.ref().child('listemed/stock.txt');
//   //   final String url2 = await ref2.getDownloadURL();
//   //   final String uuid2 = Uuid().v1();
//   //   final Directory systemTempDir2 = Directory.systemTemp;
//   //   final File tempFile2 = File('${systemTempDir2.path}/tmplistemed.txt');
//   //   if (tempFile2.existsSync()) {
//   //     await tempFile2.delete();
//   //   }
//   //   if (tempFile2.existsSync()) {
//   //     await tempFile2.delete();
//   //   }
//   //   await tempFile2.create();
//   //   assert(await tempFile2.readAsString() == "");
//   //   final StorageFileDownloadTask task2 = ref2.writeToFile(tempFile2);
//   //   final int byteCount2 = (await task2.future).totalByteCount;
//   //   Uint8List contents2 = await tempFile2.readAsBytes();
//   //   LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
//   //     if (s.split('\t').length > 5) {
//   //       String id = s.split('\t').elementAt(0);
//   //       String stock = s.split('\t').elementAt(2);
//   //       if(id.length>0 || stock.length>0)
//   //         stockMap.putIfAbsent(id, () => stock);
//   //     }
//   //   }).toList();
//   //
//   //   print(stockMap.length);
//   //
//   //
//   //   // On a chargé la liste de stock dans une map
//   //   // Maintenant on creer nos objet Item a partir de la liste des médicament et la map de stock
//   //   loadListFromInternet2();
//   // }
//   //
//   //
//   // void loadListFromInternet2() async {
//   //
//   //   final ref2 = FirebaseStorage.instance.ref().child('listemed/listtxt.txt');
//   //   final String url2 = await ref2.getDownloadURL();
//   //   final String uuid2 = Uuid().v1();
//   //   final Directory systemTempDir2 = Directory.systemTemp;
//   //   final File tempFile2 = File('${systemTempDir2.path}/tmplistemed2.txt');
//   //   if (tempFile2.existsSync()) {
//   //     await tempFile2.delete();
//   //   }
//   //   if (tempFile2.existsSync()) {
//   //     await tempFile2.delete();
//   //   }
//   //   await tempFile2.create();
//   //   assert(await tempFile2.readAsString() == "");
//   //   final StorageFileDownloadTask task2 = ref2.writeToFile(tempFile2);
//   //   final int byteCount2 = (await task2.future).totalByteCount;
//   //   // Read the file.
//   //   Uint8List contents2 = await tempFile2.readAsBytes();
//   //   //String myListText = await rootBundle.loadString(url);
//   //   LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
//   //     if (s.split('\t').length > 7) {
//   //       String id = s.split('\t').elementAt(0);
//   //       String name = s.split('\t').elementAt(2);
//   //       String barCode = s.split('\t').elementAt(1);
//   //       String prixAchat = s.split('\t').elementAt(5);
//   //       String prixVente = s.split('\t').elementAt(6);
//   //       //print("name " + name + "\n");
//   //       if(name.length>0 || barCode.length>0)
//   //         dataList.add(new Item(id, name, barCode, prixAchat, prixVente, stockMap[id]));
//   //     }
//   //   }).toList();
//   //   setState(() {
//   //     loading = false;
//   //   });
//   //   print(dataList.length);
//   // }
//
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Home',
//     ),
//     Text(
//       'Index 1: Business',
//     ),
//     Text(
//       'Index 2: School',
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('SOS Pharma'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.history,
//               color: Colors.white,
//               size: 35,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HistoryPage()),
//               );
//             },
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 15),
//             child: Builder(builder: (BuildContext context) {
//               return Badge(
//                 position: BadgePosition.topStart(top: 0, ),
//                 badgeContent: shopCount == 0
//                     ? Text(
//                   '',
//                   style: TextStyle(color: Colors.white),
//                 )
//                     : Text(
//                   shopCount.toString(),
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.add_shopping_cart,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                   onPressed: () {
//                     if (shopCount != 0) {
//                       displayVente(context);
//                     } else {
//                       final snackBar = SnackBar(
//                           content: Text(
//                             ' Vente vide, veillez ajouter au moins un article',
//                             textAlign: TextAlign.center,
//                           ));
//                       Scaffold.of(context).showSnackBar(snackBar);
//                     }
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//       body:  ListView(
//         children: <Widget>[
//           Container(
//             height: 350,
//             child: GridTile(
//
//               child: Image.network(
//                 'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon%2F'+widget.article.id+'.jpg?alt=media',
//                 fit: BoxFit.fill,
//                 height: 160,
//               ),
//               footer: Container(
//                   height: 40,
//                   color: Colors.black.withOpacity(0.3),
//                   alignment: Alignment.center,
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           child: Text(
//                             widget.article.name,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         child: Row(
//                           children: <Widget>[
//                             Text(
//                               'Prix: ',
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               widget.article.prixVente,
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Text(
//                               ' dt',
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Text(
//               'Caratéristiques' + 'الخصائص',
//               style: TextStyle(
//                   decoration: TextDecoration.underline,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue),
//             ),
//           ),
//           //debut colonne caratcteristique
//
//           Container(
//             padding: EdgeInsets.all(10),
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:<Widget> [
//
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.all(10),
//                   color: Colors.blue,
//                   child: GestureDetector(
//                       onTap: () {
//                         _showMyDialog(context, widget.article);
//                       },
//                       child: Container(
//                           height: 70,
//                           color: color,
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                   flex: showPrixAchat ? 11 : 13,
//                                   child: Text(
//                                     displayedList[index].name,
//                                     style: TextStyle(fontSize: 15),
//                                   )),
//                               Expanded(
//                                   flex: 4,
//                                   child: Text(
//                                     displayedList[index].prixVente,
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.green),
//                                   )),
//                               showPrixAchat
//                                   ? Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     displayedList[index].prixAchat,
//                                     style: TextStyle(fontSize: 10),
//                                   ))
//                                   : Expanded(flex: 0, child: Text("")),
//                             ],
//                           ))),
//
//                   // RichText(text: TextSpan(children: <TextSpan>[
//                   //   TextSpan(text: 'Designation: ', style: TextStyle(
//                   //     decoration: TextDecoration.underline,
//                   //     fontSize: 17,
//                   //   )),
//                   //   TextSpan(text:widget.article.name, style: TextStyle(
//                   //     decoration: TextDecoration.underline,
//                   //     fontSize: 17,
//                   //   ) )
//                   // ])),
//
//                 ),
//
//                 // Container(
//                 //   width: MediaQuery.of(context).size.width,
//                 //   padding: EdgeInsets.all(10),
//                 //   color: Colors.blue,
//                 //   child:
//                 //   RichText(text: TextSpan(children: <TextSpan>[
//                 //     TextSpan(text: 'Prix:', style: TextStyle(
//                 //       decoration: TextDecoration.underline,
//                 //       fontSize: 15,
//                 //     )),
//                 //     TextSpan(text:' 48500 dt', style: TextStyle(
//                 //       decoration: TextDecoration.underline,
//                 //       fontSize: 15,
//                 //     ) )
//                 //   ])),
//                 // ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child:Column(
//                     children: <Widget>[
//                       //  mySpec(context, 'Indication:',widget.indication_d,Colors.white,Colors.blue),
//
//
//
//                     ],
//                   )
//                   ,),
//               ],)
//             //fin colonne caratcteristique
//             ,),
//         ],
//       ),
//
//       //
//       // loading
//       //     ? Center(child: Column(
//       //   mainAxisAlignment: MainAxisAlignment.center,
//       //   children: [
//       //     CircularProgressIndicator(),
//       //     Text("veuillez patienter quelques instants...", style: TextStyle(color: Colors.blue, fontSize: 16),),
//       //   ],))
//       //     : Column(
//       //   children: <Widget>[
//       //     Padding(
//       //         padding: EdgeInsets.only(left: 10, right: 10),
//       //         child: TextFormField(
//       //           controller: myTextFieldController,
//       //           onChanged: (text) {
//       //             if (text.length > 1 ||
//       //                 (text.length == 1 && text.substring(0, 1) != "*")) {
//       //               searchItems(text);
//       //             } else {
//       //               setState(() {
//       //                 displayedList.clear();
//       //               });
//       //             }
//       //           },
//       //           decoration: InputDecoration(
//       //             fillColor: Colors.grey[300],
//       //             filled: true,
//       //             labelText: 'Article',
//       //             suffixIcon: Padding(
//       //                 padding: EdgeInsets.only(right: 10),
//       //                 child: RaisedButton.icon(
//       //                     color: Colors.grey[200],
//       //                     onPressed: () async{
//       //                       await scanBarcodeNormal();
//       //                       _showMyDialog(context, displayedList[0],
//       //                           myTextFieldController);
//       //                     },
//       //                     icon: Icon(FontAwesome5.barcode),
//       //                     label: Text("Appuyer"))),
//       //           ),
//       //         )),
//       //     Padding(
//       //         padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
//       //         child: Row(
//       //           children: <Widget>[
//       //             Expanded(
//       //                 flex: showPrixAchat ? 11 : 13,
//       //                 child: Text(
//       //                   "DESIGNATION",
//       //                   style: TextStyle(fontWeight: FontWeight.bold),
//       //                   textAlign: TextAlign.start,
//       //                 )),
//       //             Expanded(
//       //                 flex: 4,
//       //                 child: Text(
//       //                   "VENTE",
//       //                   style: TextStyle(fontWeight: FontWeight.bold),
//       //                   textAlign: TextAlign.start,
//       //                 )),
//       //             showPrixAchat
//       //                 ? Expanded(
//       //                 flex: 2,
//       //                 child: Text(
//       //                   "ACHAT",
//       //                   style: TextStyle(
//       //                       fontSize: 10,
//       //                       fontWeight: FontWeight.bold),
//       //                   textAlign: TextAlign.start,
//       //                 ))
//       //                 : Expanded(flex: 0, child: Text("")),
//       //           ],
//       //         )),
//       //     Expanded(
//       //         child: ListView.builder(
//       //           itemCount: displayedList.length,
//       //           itemBuilder: (context, index) {
//       //             Color color = index.isOdd
//       //                 ? Colors.grey[100]
//       //                 : Colors.blue[50]; //choose color
//       //             return Padding(
//       //                 padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
//       //                 child: Padding(
//       //                   padding: EdgeInsets.only(top: 0.0),
//       //                   child: GestureDetector(
//       //                       onTap: () {
//       //                         _showMyDialog(context, displayedList[index],
//       //                             myTextFieldController);
//       //                       },
//       //                       child: Container(
//       //                           height: 70,
//       //                           color: color,
//       //                           child: Row(
//       //                             children: <Widget>[
//       //                               Expanded(
//       //                                   flex: showPrixAchat ? 11 : 13,
//       //                                   child: Text(
//       //                                     displayedList[index].name,
//       //                                     style: TextStyle(fontSize: 15),
//       //                                   )),
//       //                               Expanded(
//       //                                   flex: 4,
//       //                                   child: Text(
//       //                                     displayedList[index].prixVente,
//       //                                     style: TextStyle(
//       //                                         fontSize: 18,
//       //                                         color: Colors.green),
//       //                                   )),
//       //                               showPrixAchat
//       //                                   ? Expanded(
//       //                                   flex: 2,
//       //                                   child: Text(
//       //                                     displayedList[index].prixAchat,
//       //                                     style: TextStyle(fontSize: 10),
//       //                                   ))
//       //                                   : Expanded(flex: 0, child: Text("")),
//       //                             ],
//       //                           ))),
//       //                 ));
//       //           },
//       //         )),
//       //   ],
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if(addNewVente) {
//             return showDialog<void>(
//               context: context,
//               barrierDismissible: false, // user must tap button!
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('Nouvelle vente'),
//                   content: SingleChildScrollView(
//                     child: ListBody(
//                       children: <Widget>[
//                         Text('Voulez vous commencer une nouvelle vente ?'),
//                       ],
//                     ),
//                   ),
//                   actions: <Widget>[
//                     FlatButton(
//                       child: Text('NON'),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     FlatButton(
//                       child: Text('OUI'),
//                       onPressed: () {
//                         setState(() {
//                           listVentes.clear();
//                           shopCount = 0;
//                           addNewVente = false;
//                         });
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add_circle_outline),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void displayVente(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       // should dialog be dismissed when tapped outside
//       builder: (context) {
//         // your widget implementation
//         return Scaffold(
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             leading: IconButton(
//               icon: Icon(
//                 Icons.clear,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.save,
//                   color: Colors.blue,
//                   size: 32,
//                 ),
//                 onPressed: () {
//                   ListVente myList = new ListVente(listVentes, null, null);
//
//                   fireStoreInstance.collection("ventes").add({
//                     //'ventes': myList.toMap(),
//                     'vente': listVentes.map((i) => i.toMap()).toList(),
//                     'timestamp': DateTime.now().millisecondsSinceEpoch,
//                   }).then((value) {
//                    // print(value.documentID);
//                   });
//
//                   setState(() {
//                     displayedList.clear();
//                     listVentes.clear();
//                     shopCount = 0;
//                     addNewVente = false;
//                   });
//
//                   Navigator.of(context).pop();
//                   //myTextFieldController.clear();
//                 },
//               ),
//             ],
//           ),
//           body: Container(
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                       color: Colors.green[50],
//                       child: Padding(
//                           padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                   flex: 11,
//                                   child: Text(
//                                     "DESIGNATION",
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                               Expanded(
//                                   flex: 4,
//                                   child: Text(
//                                     "VENTE",
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     "QTE",
//                                     style: TextStyle(
//                                         fontSize: 12, fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                             ],
//                           ))),
//                   Expanded(
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: listVentes.length,
//                         itemBuilder: (BuildContext context, int itemIndex) {
//                           Color color =
//                           itemIndex.isOdd ? Colors.grey[100] : Colors.blue[50];
//                           return Padding(
//                             padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
//                             child: GestureDetector(
//                                 onLongPress: () {
//                                   showDialog<void>(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       // user must tap button!
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text('Suppression'),
//                                           content: SingleChildScrollView(
//                                             child: ListBody(
//                                               children: <Widget>[
//                                                 Text(
//                                                     'Voulez vous supprimer ce médicament de la vente ? '),
//                                                 Padding(
//                                                     padding:
//                                                     EdgeInsets.only(bottom: 10),
//                                                     child: Text(
//                                                       listVentes[itemIndex].item.name,
//                                                       style: TextStyle(
//                                                           color: Colors.red,
//                                                           fontWeight: FontWeight.bold),
//                                                     )),
//                                               ],
//                                             ),
//                                           ),
//                                           actions: <Widget>[
//                                             FlatButton(
//                                               child: Text('ANNULER'),
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                             ),
//                                             FlatButton(
//                                               child: Text('VALIDER'),
//                                               onPressed: () {
//                                                 shopCount = shopCount -
//                                                     listVentes[itemIndex].number;
//                                                 listVentes.removeAt(itemIndex);
//                                                 shopCount == 0 ? addNewVente = false : true ;
//                                                 setState(() {
//                                                   shopCount;
//                                                   addNewVente;
//                                                 });
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).pop();
//                                                 displayVente(context);
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       });
//                                 },
//                                 child: Container(
//                                     height: 70,
//                                     color: color,
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: <Widget>[
//                                         Expanded(
//                                             flex: 11,
//                                             child: Text(
//                                               listVentes[itemIndex].item.name,
//                                               style: TextStyle(fontSize: 15),
//                                             )),
//                                         Expanded(
//                                             flex: 4,
//                                             child: Text(
//                                               listVentes[itemIndex].item.prixVente,
//                                               style: TextStyle(
//                                                   fontSize: 18, color: Colors.green),
//                                             )),
//                                         Expanded(
//                                             flex: 3,
//                                             child: Text(
//                                               listVentes[itemIndex].number.toString(),
//                                               style: TextStyle(fontSize: 18),
//                                             )),
//                                       ],
//                                     ))),
//                           );
//                         },
//                       )),
//                   Container(
//                       color: Colors.green[50],
//                       child: Padding(
//                           padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                   flex: 11,
//                                   child: Text(
//                                     "TOTAL",
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                               Expanded(
//                                   flex: 4,
//                                   child: Text(
//                                     getSomme(),
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                               Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     getQuantite(),
//                                     style: TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                     textAlign: TextAlign.start,
//                                   )),
//                             ],
//                           ))),
//                 ],
//               )),
//         );
//       },
//     );
//   }
//
//   searchItems(String text) {
//     displayedList.clear();
//     if (text.substring(0, 1) == "*") {
//       displayedList = dataList
//           .where((i) => i.name
//           .toUpperCase()
//           .contains(text.substring(1, text.length).toUpperCase()))
//           .toList();
//     } else {
//       displayedList = dataList
//           .where((i) => i.name.toUpperCase().startsWith(text.toUpperCase()))
//           .toList();
//     }
//     setState(() {
//       displayedList;
//     });
//   }
//
//   // Future<void> scanBarcodeNormal() async {
//   //   String barcodeScanRes;
//   //   try {
//   //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//   //         "#ff6666", "Cancel", true, ScanMode.BARCODE);
//   //     print(barcodeScanRes);
//   //   } on PlatformException {
//   //     barcodeScanRes = 'Failed to get platform version.';
//   //   }
//   //   if (!mounted) return;
//   //   searchMedicamentByBarCode(barcodeScanRes);
//   // }
//
//   // void searchMedicamentByBarCode(String barcodeScanRes) {
//   //   displayedList.clear();
//   //   for (final value in dataList) {
//   //     if (value.barCode == barcodeScanRes) {
//   //       displayedList.add(value);
//   //       break;
//   //     }
//   //   }
//   //   setState(() {
//   //     displayedList;
//   //   });
// //    if(displayedList.length>0){
// //      _showMyDialog(context, displayedList[0],
// //          myTextFieldController);
// //    }
//   }
//
//   Future<void> _showMyDialog(BuildContext context, Item item,
//       ) async {
//     var expression = RegExp('([-]?)([0-9]+)');
//
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Ajouter à la vente'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Padding(
//                     padding: EdgeInsets.only(bottom: 10),
//                     child: Text(
//                       item.name,
//                       style: TextStyle(
//                           color: Colors.red, fontWeight: FontWeight.bold),
//                     )),
//                 Row(children: [
//                   Text('Valider '),
//                   Text('1', style: TextStyle(color: Colors.red),),
//                   Text(' ou choisir la quantité '),
//                 ],),
//                 Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         SizedBox(
//                             width: 90,
//                             child: TextFormField(
//                               autofocus: true,
//                               controller: numberController,
//                               //initialValue: "1",
//                               decoration: InputDecoration(
//                                 hintText: '1',
//                                 helperText: 'différent de 0',
//                               ),
//                               keyboardType: TextInputType.number,
//                               inputFormatters: <TextInputFormatter>[
//                                 //WhitelistingTextInputFormatter.digitsOnly
//                                 FilteringTextInputFormatter.allow(expression)
//                               ], // Only numbers can be entered
//                             )),
//                         Text(''),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('ANNULER'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             FlatButton(
//               child: Text('VALIDER'),
//               onPressed: () {
//                 int value;
//                 numberController.text.isEmpty
//                     ? value = 1
//                     : value = int.parse(numberController.text);
//                 if (value != 0) {
//                   listVentes.add(new Vente(item, value));
//                   shopCount = shopCount + value;
//                   shopCount == 0 ? addNewVente = false : addNewVente = true;
//                   setState(() {
//                     shopCount;
//                     addNewVente;
//                   });
//                   Navigator.of(context).pop();
//                   setState(() {
//                     displayedList.clear();
//                     myTextFieldController.clear();
//                   });
//                 } else {}
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   String getSomme() {
//     int somme = 0;
//     listVentes.forEach((element) {
//       somme = somme +
//           (int.parse(
//               element.item.prixVente.replaceAll(new RegExp(r"\s+"), "")) *
//               element.number);
//     });
//     return somme.toString();
//   }
//
//   String getQuantite() {
//     int quantite = 0;
//     listVentes.forEach((element) {
//       quantite = quantite + element.number;
//     });
//     return quantite.toString();
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
