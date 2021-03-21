import 'dart:collection';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/home.dart';
import 'package:expopharma/pages/itemVente.dart';
import 'package:expopharma/pages/listeVente.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:expopharma/pages/itemCommande.dart';
import 'package:intl/intl.dart';

class DisplayVente extends StatefulWidget {

  DisplayVente();

  @override
  _DisplayVenteState createState() => _DisplayVenteState();
}

class _DisplayVenteState extends State<DisplayVente> {
  final fireStoreInstance = FirebaseFirestore.instance;

  TextEditingController myTextFieldController;
  int total = 0;
  int somme = 0;

  HashMap<String, String> stockMap = new HashMap();
  String nameclient;

  List<Item> displayedList = new List();

  bool loading = true;

  List<Vente> listVentes = new List();

  bool addNewVente = false;
  TextEditingController nameclientController = new TextEditingController();
  List<ItemCommande> listItemCommande = new List();
  @override
  Widget build(BuildContext context) {
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
            Navigator.of(context).pop("NOTSAVED");
          },
        ),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
              color: Colors.green[50],
              child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Text(
                            "DESIGNATION",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                            "PRIX",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "QTE",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          )),
                    ],
                  ))),
          Expanded(
              flex: 6,
              child: StreamBuilder(
                stream: fireStoreInstance
                    .collection("commandeClient")
                    // .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (dataSnapshot.hasData) {
                    listItemCommande.clear();
                    dataSnapshot.data.docs.forEach((result) {

                      String name = result["name"];
                      int number = result["number"];
                      String prixVente = result["prixVente"];
                     // var timestamp = result["timestamp"];
                      ItemCommande itemCommande = new ItemCommande(
                          name, prixVente, number,null, result.id);
                      listItemCommande.add(itemCommande);
                      print(listItemCommande.length);
                    });

                    if (listItemCommande.length == 0) {
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Le panier est vide',
                            style: TextStyle(
                                color: Color(0xFFE0E0E0),
                                //fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          Icon(
                            Icons.comment,
                            color: Color(0xFFE0E0E0),
                            size: 126.0,
                          )
                        ],
                      ));
                    } else {
                      return ListView.builder(
                          itemCount: listItemCommande.length,
                          itemBuilder: (context, index) {
                            // int total = 0;
                            String namearticle = '';
                            String prix = '';
                            total=0;
                            somme=0;

                            listItemCommande.forEach((element) {
                              total = total + element.number;
                         //   });

                           // listItemCommande.forEach((element) {
                              somme = somme +
                                  (int.parse(element.prixVente
                                          .replaceAll(new RegExp(r"\s+"), "")) *
                                      element.number);
                            });

                            // var date = DateTime.fromMillisecondsSinceEpoch(
                            //     listItemCommande[index].timestamp);
                            // var formattedDate =
                            //     DateFormat.yMMMMd('en_US').format(date);

                            Color color = index.isOdd
                                ? Colors.grey[100]
                                : Colors.blue[50]; //choose color
                            return Dismissible(
                                // Each Dismissible must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.
                                key: Key(listItemCommande[index].documentID),
                                // Provide a function that tells the app
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Suppression'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                  'Voulez vous supprimer définitivement cette article ? '),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    namearticle,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    'Prix =' + prix,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    '',
                                                    // listItemCommande[index].nameclient,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                  .collection('commandeClient')
                                                  .doc(listItemCommande[index]
                                                      .documentID)
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
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  alignment: Alignment.centerRight,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 11,
                                                  child: Text(
                                                    listItemCommande[index]
                                                        .name,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Expanded(
                                                  flex: 5,
                                                  child: Text(
                                                    listItemCommande[index]
                                                        .prixVente,
                                                    //somme.toString(),
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green),
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  listItemCommande[index]
                                                      .number
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              // Expanded(
                                              //     flex: 1, child: Text('',style:TextStyle(color: Colors.redAccent))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )));

                            // Container(child: Text(ventes[index].item.name),);
                          });
                    }
                  }
                },
              )),
          Expanded(
              flex: 1,
              child: Container(
                  color: Colors.green[50],
                  child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 11,
                              child: Text(
                                "TOTAL",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                          Expanded(
                              flex: 4,
                              child: Text(
                                somme.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                total.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                        ],

                      )))),
          Expanded(
            flex: 1,
            child: Container(
              child: TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(10),
                ],
                autofocus: true,
                controller: nameclientController,
                //initialValue: "1",
                decoration: InputDecoration(
                  hintText: 'Tappez votre nom',
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  child: Text(
                    'Validez votre achat',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    ListVente vente = ListVente(null, nameclient,null, null);
                    String value;
                    nameclientController.text.isEmpty
                        ? value = 'Inconnu'
                        : value = nameclientController.text;
                    fireStoreInstance.collection("ventes").add({
                       'vente':listItemCommande.map((e) => e.toMap()).toList(),
                       //widget.listCommande.map((i) => i.toMap()).toList(),
                      'timestamp': DateTime.now().millisecondsSinceEpoch,
                      'nameclient': value,
                    }).then((value) {

                      CollectionReference ref = fireStoreInstance.collection('commandeClient');

                      ref.snapshots().forEach((element) {
                        for (QueryDocumentSnapshot snapshot in element.docs) {
                          snapshot.reference.delete();
                        }
                      });

                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  'شكرا على ثقتكم الكريمة Merci pour votre confiance'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'يمكنكم تسلم طلبيتكم Demandez votre commande à la caisse '),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  },
                                ),
                              ],
                            );
                          });
                    });
                  },
                ),
              ))
        ],
      )),
    );
  }

}
