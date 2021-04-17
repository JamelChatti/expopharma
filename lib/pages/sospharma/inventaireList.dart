import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:expopharma/pages/sospharma/InventaireModel.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/Vente.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/sospharma/inventaire.dart';
import 'package:expopharma/pages/sospharma/inventaireHistory.dart';

import 'package:intl/intl.dart';

class InventaireList extends StatefulWidget {
  @override
  _InventaireListState createState() => _InventaireListState();
}

class _InventaireListState extends State<InventaireList> {
  TextEditingController myTextFieldController;
  List<Item> displayedList = new List();
  List<Vente> listVentes = new List();
  bool showPrixAchat = false;

  List<InventaireLigne> list = List();
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    myTextFieldController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Liste des inventaires'),
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Nom de l'inventaire",
                        style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 2,
                      child:
                      Text(
                        "Date création",
                        style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                      )),

                ],
              ),
            ),

            Expanded(
                child: StreamBuilder(
                  stream: fireStoreInstance
                      .collection("inventaires")
                      .orderBy('name')
                      .snapshots(),
                  builder: (context, dataSnapshot) {
                    if (dataSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (dataSnapshot.hasData) {
                      List<InventaireModel> inventaires = new List();
                        dataSnapshot.data.docs.forEach((result) {
                        int myTime = result["timestamp"];
                        String name = result["name"];
                        InventaireModel inventaire = new InventaireModel(name, myTime, result.documentID,null);
                        inventaires.add(inventaire);
                      });

                      if (inventaires.length == 0) {
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Be the first to comment',
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
                      }
                      return ListView.builder(
                          itemCount: inventaires.length,
                          itemBuilder: (context, index) {
                            var date = DateTime.fromMillisecondsSinceEpoch(
                                inventaires[index].timestamp);
                            var formattedDate =
                            DateFormat.yMd('en_US').format(date);

                            Color color = index.isOdd
                                ? Colors.grey[100]
                                : Colors.blue[50]; //choose color

                            return Dismissible(
                              // Each Dismissible must contain a Key. Keys allow Flutter to
                              // uniquely identify widgets.
                                key: Key(inventaires[index].documentID),
                                // Provide a function that tells the app


                                confirmDismiss: (DismissDirection direction) async {
                                },

                                background: Container(

                                  // Show a red background as the item is swiped away.
                                  padding: EdgeInsets.only(left: 5),
                                  alignment: Alignment.centerLeft,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.update,
                                    color: Colors.green,
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
                                  color: color,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Inventaire(inventaires[index].documentID, inventaires[index].name)),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        children: <Widget>[
//                                      Expanded(
//                                          flex: 0,
//                                          child: Text(
//                                            formattedDate,
//                                            style: TextStyle(fontSize: 15),
//                                          )),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                inventaires[index].name,
                                                style: TextStyle(fontSize: 15, color: Colors.blue),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child:
                                              Text(formattedDate, style: TextStyle(fontSize: 15, color: Colors.green),)),

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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addInventaire(myTextFieldController);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }






  Future<void> addInventaire(TextEditingController myTextFieldController) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nouveau inventaire'),
          content: TextFormField(
            onChanged: (text){
              print(text);
              //myTextFieldController.text = text;
            },
            controller: myTextFieldController,
            decoration: const InputDecoration(labelText: 'Nom'),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('NON'),
              onPressed: () {
                myTextFieldController.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OUI'),
              onPressed: () {
                //modifierMarquage(medicaments[index].id, type);
                saveProduit(myTextFieldController.text);
                myTextFieldController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }





  Future<void> saveProduit(String name) async {
    fireStoreInstance.collection("inventaires").add({
      //'ventes': myList.toMap(),
      'name': name,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }).then((value) {
      print(value.id);
      FocusScope.of(context).requestFocus(FocusNode());
      setState(() {

      });
//      setState(() {
//        myController.clear();
//        addNewMed = false;
//        FocusScope.of(context).requestFocus(FocusNode());
//      });
    });
  }

























































  searchItems(String text) {
    displayedList.clear();
    if (text.substring(0, 1) == "*") {
      displayedList = dataList
          .where((i) => i.name
              .toUpperCase()
              .contains(text.substring(1, text.length).toUpperCase()))
          .toList();
    } else {
      displayedList = dataList
          .where((i) => i.name.toUpperCase().startsWith(text.toUpperCase()))
          .toList();
    }
    setState(() {
      displayedList;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    searchMedicamentByBarCode(barcodeScanRes);
  }

  void searchMedicamentByBarCode(String barcodeScanRes) {
    displayedList.clear();
    for (final value in dataList) {
      if (value.barCode == barcodeScanRes) {
        displayedList.add(value);
        break;
      }
    }
    setState(() {
      displayedList;
    });
  }

}
