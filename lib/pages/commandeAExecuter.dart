import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/listeVente.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommandeAExecuter extends StatefulWidget {
  @override
  _CommandeAExecuterState createState() => _CommandeAExecuterState();
}

class _CommandeAExecuterState extends State<CommandeAExecuter> {
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Commande à executer "),

      ),
      body: Container(
          color: Colors.grey[300],
          child: StreamBuilder(
            stream: fireStoreInstance
                .collection("ventes")
                .orderBy('timestamp', descending: false)
                .snapshots(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (dataSnapshot.hasData) {

                List<ListVente> listListVente = new List();
                dataSnapshot.data.docs.forEach((result) {
                  var myTime = result["timestamp"];
                  String nameclient = result["nameclient"];
                  List<Vente> list = List<Vente>.from(result["vente"].map((item) {
                    Item items = new Item("", item["name"], item["barCode"],
                       ""  ,item["prixVente"], " ", "");
                    return new Vente(items, item["number"]);
                  }));
                  ListVente vente = ListVente(list, nameclient,myTime, result.id);
                  listListVente.add(vente);
                });
                return ListView.builder(
                    itemCount: listListVente.length,
                    itemBuilder: (context, index) {
                      int total = 0;
                      listListVente[index].ventes.forEach((element) {
                        total = total + element.number;
                      });

                      int somme = 0;
                      listListVente[index].ventes.forEach((element) {
                        somme = somme +
                            (int.parse(element.item.prixVente
                                .replaceAll(new RegExp(r"\s+"), "")) *
                                element.number);
                      });

                      var date = DateTime.fromMillisecondsSinceEpoch(
                          listListVente[index].timestamp);
                      var formattedDate =
                      DateFormat.yMMMMd('en_US').format(date);

                      String name = listListVente[index].nameclient;

                      Color color = index.isOdd
                          ? Colors.grey[100]
                          : Colors.blue[50]; //choose color
                      return Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                          key: Key(listListVente[index].documentID),
                          // Provide a function that tells the app
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Suppression'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Voulez vous supprimer définitivement cette vente ? '),
                                        Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Date : ' + formattedDate,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                            padding:
                                            EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Somme : ' + somme.toString(),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Padding(
                                             padding:
                                             EdgeInsets.only(bottom: 10),
                                             child: Text(
                                               listListVente[index].nameclient,
                                               style: TextStyle(
                                                   color: Colors.red,
                                                   fontWeight: FontWeight.bold),
                                             )),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('ANNULER'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('VALIDER'),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('ventes')
                                            .doc(
                                            listListVente[index].documentID)
                                            .delete()
                                            .whenComplete(() {
                                          print("complete");

                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // Show a red background as the item is swiped away.
                          background: Container(
                            padding: EdgeInsets.only(left: 5),
                            alignment: Alignment.centerLeft,
                            color: Colors.grey[300],
                            child: Icon(Icons.delete, color: Colors.red,),
                          ),
                          secondaryBackground: Container(
                            padding: EdgeInsets.only(right: 5),
                            alignment: Alignment.centerRight,
                            color: Colors.grey[300],
                            child: Icon(Icons.delete, color: Colors.red,),
                          ),
                          child: Container(
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  // should dialog be dismissed when tapped outside
                                  builder: (context) {
                                    // your widget implementation
                                    return Scaffold(
                                      appBar: AppBar(
                                        elevation: 0,
                                        backgroundColor: Colors.white,
                                        leading: IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        actions: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    int somme = 0;
                                                    listListVente[index]
                                                        .ventes
                                                        .forEach((element) {
                                                      somme = somme +
                                                          (int.parse(element
                                                              .item
                                                              .prixVente
                                                              .replaceAll(
                                                              new RegExp(
                                                                  r"\s+"),
                                                              "")) *
                                                              element.number);
                                                    });

                                                    var date = DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                        listListVente[index]
                                                            .timestamp);
                                                    var formattedDate =
                                                    DateFormat.yMMMMd(
                                                        'en_US')
                                                        .format(date);

                                                    return AlertDialog(
                                                      title:
                                                      Text('Suppression'),
                                                      content:
                                                      SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text(
                                                                'Voulez vous supprimer définitivement cette vente ? '),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                    10),
                                                                child: Text(
                                                                  'Date : ' +
                                                                      formattedDate,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                )),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                    10),
                                                                child: Text(
                                                                  'Somme : ' +
                                                                      somme
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          child:
                                                          Text('ANNULER'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child:
                                                          Text('VALIDER'),
                                                          onPressed: () {
                                                            FirebaseFirestore.instance
                                                                .collection(
                                                                'ventes')
                                                                .doc(listListVente[
                                                            index]
                                                                .documentID)
                                                                .delete()
                                                                .whenComplete(
                                                                    () {
                                                                  print("complete");
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                  setState(() {});
//                                            final snackBar = SnackBar(
//                                                content: Text(
//                                                    ' Document  supprimé',
//                                                  textAlign: TextAlign.center,
//                                                ));
//                                            Scaffold.of(context).showSnackBar(snackBar);
                                                                });
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                      body: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                  color: Colors.green[50],
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          top: 20,
                                                          bottom: 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                              flex: 11,
                                                              child: Text(
                                                                "DESIGNATION",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                          Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                "VENTE",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                "Qte",
                                                                style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                        ],
                                                      ))),
                                              Expanded(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: listListVente[index]
                                                        .ventes
                                                        .length,
                                                    itemBuilder: (BuildContext context,
                                                        int itemIndex) {
                                                      Color color = itemIndex.isOdd
                                                          ? Colors.grey[100]
                                                          : Colors.blue[50];
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 10,
                                                            top: 20,
                                                            bottom: 50),
                                                        child: Container(
                                                            height: 40,
                                                            color: color,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                Expanded(
                                                                    flex: 11,
                                                                    child: Text(
                                                                      listListVente[
                                                                      index]
                                                                          .ventes[
                                                                      itemIndex]
                                                                          .item
                                                                          .name,
                                                                      style: TextStyle(
                                                                          fontSize: 15),
                                                                    )),
                                                                Expanded(
                                                                    flex: 4,
                                                                    child: Text(
                                                                      listListVente[
                                                                      index]
                                                                          .ventes[
                                                                      itemIndex]
                                                                          .item
                                                                          .prixVente,
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          color: Colors
                                                                              .green),
                                                                    )),
                                                                Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                      listListVente[
                                                                      index]
                                                                          .ventes[
                                                                      itemIndex]
                                                                          .number
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: 18),
                                                                    )),
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                  )),
                                              Container(
                                                  color: Colors.green[50],
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          top: 20,
                                                          bottom: 15),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                              flex: 11,
                                                              child: Text(
                                                                "TOTAL",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.red,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                          Expanded(
                                                              flex: 4,
                                                              child: Text(
                                                                somme.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                total.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                textAlign:
                                                                TextAlign.start,
                                                              )),
                                                          Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                  listListVente[index].nameclient,style:TextStyle(color: Colors.redAccent)
                                                              )),
                                                        ],
                                                      ))),
                                            ],
                                          )),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          formattedDate,
                                          style: TextStyle(fontSize: 15),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                          somme.toString(),
                                          style: TextStyle(fontSize: 15),
                                        )),
                                    Expanded(
                                        flex: 1, child: Text(total.toString())),
                                    Expanded(
                                        flex: 3, child: Text(name,style:TextStyle(color: Colors.redAccent))),
                                   ],
                                ),
                              ),
                            ),
                          ));

                      // Container(child: Text(ventes[index].item.name),);
                    });
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
