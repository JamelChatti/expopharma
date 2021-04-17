import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/sospharma/ventesos.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/sospharma/inventaireHistory.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Inventaire extends StatefulWidget {
  String documentID;
  String inventaireName;
  Inventaire(this.documentID, this.inventaireName);
  @override
  _InventaireState createState() => _InventaireState();
}

class _InventaireState extends State<Inventaire> {
  TextEditingController myTextFieldController;
  List<Item> displayedList = new List();
  List<VenteSos> listVentes = new List();
 // int shopCount = 0;
  bool showPrixAchat = false;
  //bool addNewVente = false;

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
        title: Text('Inventaire : ' + widget.inventaireName),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InventaireHistory(widget.documentID, widget.inventaireName)),
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: myTextFieldController,
                onChanged: (text) {
                  if (text.length > 1 ||
                      (text.length == 1 && text.substring(0, 1) != "*")) {
                    searchItems(text);
                  } else {
                    setState(() {
                      displayedList.clear();
                    });
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  labelText: 'Article',
                  suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: RaisedButton.icon(
                          color: Colors.grey[200],
                          onPressed: () async {
                            await scanBarcodeNormal();
                            bool isModify = false;
                            String documenID;
                            String oldUserName;
                            String oldStock;
                            String expdate;


                            await FirebaseFirestore.instance
                                .collection('inventaire')
                                .where("barCode", isEqualTo: displayedList[0].barCode)
                                .where("parentId", isEqualTo: widget.documentID)
                                .get()
                                .then((value) => {
                              if (value.docs.length == 1)
                                {
                                  value.docs.forEach((doc) {
                                    print(doc.id);
                                    documenID = doc.id;
                                    oldUserName = doc["userName"];
                                    oldStock = doc["newStock"];
                                    expdate = doc["expdate"];
                                    isModify = true;
                                  })
                                }
                            });

                            _showMyDialog(context, displayedList[0],
                                myTextFieldController, isModify, documenID, oldUserName, oldStock,expdate);
                          },
                          icon: Icon(FontAwesomeIcons.barcode),
                          label: Text("Appuyer"))),
                ),
              )),
          Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: showPrixAchat ? 11 : 13,
                      child: Text(
                        "DESIGNATION",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Stock",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )),
                  Expanded(
                      flex: 4,
                      child: Text(
                        "Prix v",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )),
                ],
              )),
          Expanded(
              child: ListView.builder(
            itemCount: displayedList.length,
            itemBuilder: (context, index) {
              Color color = index.isOdd
                  ? Colors.grey[100]
                  : Colors.blue[50]; //choose color
              return Padding(
                  padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: GestureDetector(
                        onTap: () async{

                          bool isModify = false;
                          String documenID;
                          String oldUserName;
                          String oldStock;
                          String expdate;

                          FirebaseFirestore.instance
                              .collection('inventaire')
                              .where("barCode", isEqualTo: displayedList[index].barCode)
                              .where("parentId", isEqualTo: widget.documentID)
                              .get()
                              .then((value) => {
                            if (value.docs.length == 1)
                              {
                                value.docs.forEach((doc) {
                                  print(doc.id);
                                  documenID = doc.id;
                                  oldUserName = doc["userName"];
                                  oldStock = doc["newStock"];
                                  expdate = doc["expdate"];
                                  isModify = true;
                                })

                              }
                          })
                              .whenComplete(() {
                            _showMyDialog(context, displayedList[index],
                                myTextFieldController, isModify, documenID, oldUserName, oldStock,expdate);
                          });


                        },
                        child: Container(
                            height: 70,
                            color: color,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: showPrixAchat ? 11 : 13,
                                    child: Text(
                                      displayedList[index].name,
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      displayedList[index].stock,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green,fontWeight: FontWeight.bold),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      displayedList[index].prixVente,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ))),
                  ));
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.terrain),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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

  Future<void> _showMyDialog(BuildContext context, Item item,
      TextEditingController myTextFieldController, bool isModify, String documenID ,String oldUserName,String oldStock,expdate) async {
    TextEditingController numberController = new TextEditingController();
    TextEditingController expdateController = new TextEditingController();
    var expression = RegExp('([-]?)([0-9]+)');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext dialogContex) {
        return AlertDialog(
          title: isModify ? Text('Modifier l\'insertion') : Text('Ajouter à l\'inventaire'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
                isModify ?
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      Text(
                        oldUserName + " a inséré : ",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        oldStock,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],)) : Container(),


                Row(children: [
                  Text('Valider '),
                  Text(item.stock, style: TextStyle(color: Colors.red),),
                  Text(' ou choisir la quantité '),
                ],),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 90,
                        child: TextFormField(
                          autofocus: true,
                          controller: numberController,
                          //initialValue: "1",
                          decoration: InputDecoration(
                            hintText: item.stock,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            //WhitelistingTextInputFormatter.digitsOnly
                            FilteringTextInputFormatter.allow(expression)
                          ], // Only numbers can be entered
                        ),),
                    SizedBox(
                      width: 90,
                      child: TextFormField(
                        autofocus: true,
                        controller: expdateController,

                        decoration: InputDecoration(
                          hintText: 'mois/année',
                        ),

                      ),),
                    Text(''),
                  ],
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
              onPressed: () async{
                String newStock;
                numberController.text.isEmpty
                    ? newStock = item.stock
                    : newStock = numberController.text;
                      expdate = expdateController.text;
                if(isModify){
                  FirebaseFirestore.instance
                      .collection('inventaire')
                      .doc(documenID)
                      .update({"newStock": newStock,'expdate':expdate, 'userName' : currentUser.email}).then(
                          (value) => {
                        print("UPDATED")
                      }).whenComplete(() {
                    Navigator.of(dialogContex).pop();
                    setState(() {
                      displayedList.clear();
                      myTextFieldController.clear();
                    });
                  });
                } else {
                  fireStoreInstance.collection("inventaire").add({
                    //'ventes': myList.toMap(),
                    'barCode': item.barCode,
                    'name': item.name,
                    'stock': item.stock,
                    'newStock': newStock,
                    'expdate' : expdate,
                    'prixAchat': item.prixAchat,
                    'userName': currentUser.email,
                    'parentName': widget.inventaireName,
                    'parentId': widget.documentID,
                    'timestamp':
                    DateTime.now().millisecondsSinceEpoch,
                  }).then((value) {

                  }).whenComplete(() {
                    Navigator.of(dialogContex).pop();
                    setState(() {
                      displayedList.clear();
                      myTextFieldController.clear();
                    });
                  });
                }

//                Firestore.instance
//                    .collection('inventaire')
//                    .where("barCode", isEqualTo: item.barCode)
//                    .getDocuments()
//                    .then((value) => {
//                          if (value.documents.length == 1)
//                            {
//                              value.documents.forEach((doc) {
//                                print(doc.documentID);
//                                Firestore.instance
//                                    .collection('inventaire')
//                                    .document(doc.documentID)
//                                    .updateData({"newStock": newStock, 'userName' : currentUser.email}).then(
//                                        (value) => {
//                                          print("UPDATED")
//                                        });
//                              })
//                            }
//                          else
//                            {
//                              fireStoreInstance.collection("inventaire").add({
//                                //'ventes': myList.toMap(),
//                                'barCode': item.barCode,
//                                'name': item.name,
//                                'stock': item.stock,
//                                'newStock': newStock,
//                                'userName': currentUser.email,
//                                'timestamp':
//                                    DateTime.now().millisecondsSinceEpoch,
//                              }).then((value) {
//                                //print(value.documentID);
////                                Navigator.of(dialogContex).pop();
////                                setState(() {
////                                  displayedList.clear();
////                                  myTextFieldController.clear();
////                                });
//
////                                if (mounted){
////                                }
//                              })
//                            }
//                        })
//                    .whenComplete(() {
//                  Navigator.of(dialogContex).pop();
//                  setState(() {
//                    displayedList.clear();
//                    myTextFieldController.clear();
//                  });
//                });
              },
            ),
          ],
        );
      },
    );
  }
}
