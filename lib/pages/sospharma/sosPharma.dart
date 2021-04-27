import 'dart:collection';
import 'dart:convert';
import 'package:expopharma/pages/listeVente.dart';
import 'package:expopharma/pages/sospharma/datasos.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expopharma/pages/history.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';



class SosPharma extends StatefulWidget {
  SosPharma({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SosPharmaState createState() => _SosPharmaState();
}



class _SosPharmaState extends State<SosPharma> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
  }

  final fireStoreInstance = FirebaseFirestore.instance;

  TextEditingController myTextFieldController;

  int shopCount = 0;


  HashMap<String, String> stockMap = new HashMap();
  List<Item> displayedList = new List();
  bool loading = true;
  List<Vente> listVentes = new List();

  bool showPrixAchat = false;

  bool addNewVente = false;

    int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SOS Pharma'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Builder(builder: (BuildContext context) {
              return Badge(
                position: BadgePosition.bottomEnd(bottom: 0),
                badgeContent: shopCount == 0
                    ? Text(
                        '',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        shopCount.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    if (shopCount != 0) {
                      displayVente(context);
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
            }),
          ),
        ],
      ),
      body:  Column(
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
                                onPressed: () async{
                                  await scanBarcodeNormal();
                                  _showMyDialog(context, displayedList[0],
                                      myTextFieldController);
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
                              "VENTE",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            )),
                        showPrixAchat
                            ? Expanded(
                                flex: 2,
                                child: Text(
                                  "ACHAT",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ))
                            : Expanded(flex: 0, child: Text("")),
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
                              onTap: () {
                                _showMyDialog(context, displayedList[index],
                                    myTextFieldController);
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
                                            displayedList[index].prixVente,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green),
                                          )),
                                      showPrixAchat
                                          ? Expanded(
                                              flex: 2,
                                              child: Text(
                                                displayedList[index].prixAchat,
                                                style: TextStyle(fontSize: 10),
                                              ))
                                          : Expanded(flex: 0, child: Text("")),
                                    ],
                                  ))),
                        ));
                  },
                )),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(addNewVente) {
            return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Nouvelle vente'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Voulez vous commencer une nouvelle vente ?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('NON'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('OUI'),
                      onPressed: () {
                        setState(() {
                          listVentes.clear();
                          shopCount = 0;
                          addNewVente = false;
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add_circle_outline),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void displayVente(BuildContext context) {
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
                  Icons.save,
                  color: Colors.blue,
                  size: 32,
                ),
                onPressed: () {
                  ListVente myList = new ListVente(listVentes, null, null,null);

                  fireStoreInstance.collection("ventesos").add({
                    //'ventes': myList.toMap(),
                    'vente': listVentes.map((i) => i.toMap()).toList(),
                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                  }).then((value) {
                    print(value.id);
                  });

                  setState(() {
                    displayedList.clear();
                    listVentes.clear();
                    shopCount = 0;
                    addNewVente = false;
                  });

                  Navigator.of(context).pop();
                  //myTextFieldController.clear();
                },
              ),
            ],
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
                              flex: 11,
                              child: Text(
                                "DESIGNATION",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                          Expanded(
                              flex: 4,
                              child: Text(
                                "VENTE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "QTE",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                        ],
                      ))),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: listVentes.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  Color color =
                      itemIndex.isOdd ? Colors.grey[100] : Colors.blue[50];
                  return Padding(
                    padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
                    child: GestureDetector(
                        onLongPress: () {
                          showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Suppression'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Voulez vous supprimer ce médicament de la vente ? '),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              listVentes[itemIndex].item.name,
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
                                        shopCount = shopCount -
                                            listVentes[itemIndex].number;
                                        listVentes.removeAt(itemIndex);
                                        shopCount == 0 ? addNewVente = false : true ;
                                        setState(() {
                                          shopCount;
                                          addNewVente;
                                        });
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        displayVente(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                            height: 70,
                            color: color,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                    flex: 11,
                                    child: Text(
                                      listVentes[itemIndex].item.name,
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      listVentes[itemIndex].item.prixVente,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.green),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      listVentes[itemIndex].number.toString(),
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ],
                            ))),
                  );
                },
              )),
              Container(
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
                                getSomme(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                getQuantite(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                        ],
                      ))),
            ],
          )),
        );
      },
    );
  }

  searchItems(String text) {
    displayedList.clear();
    if (text.substring(0, 1) == "*") {
      displayedList = dataListsos
          .where((i) => i.name
              .toUpperCase()
              .contains(text.substring(1, text.length).toUpperCase()))
          .toList();
    } else {
      displayedList = dataListsos
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
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    searchMedicamentByBarCode(barcodeScanRes);
  }

  void searchMedicamentByBarCode(String barcodeScanRes) {
    displayedList.clear();
    for (final value in dataListsos) {
      if (value.barCode == barcodeScanRes) {
        displayedList.add(value);
        break;
      }
    }
    setState(() {
      displayedList;
    });
//    if(displayedList.length>0){
//      _showMyDialog(context, displayedList[0],
//          myTextFieldController);
//    }
  }

  Future<void> _showMyDialog(BuildContext context, Item item,
      TextEditingController myTextFieldController) async {
    TextEditingController numberController = new TextEditingController();
    var expression = RegExp('([-]?)([0-9]+)');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter à la vente'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                Row(children: [
                  Text('Valider '),
                  Text('1', style: TextStyle(color: Colors.red),),
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
                            hintText: '1',
                            helperText: 'différent de 0',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            //WhitelistingTextInputFormatter.digitsOnly
                            FilteringTextInputFormatter.allow(expression)
                          ], // Only numbers can be entered
                        )),
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
              onPressed: () {
                int value;
                numberController.text.isEmpty
                    ? value = 1
                    : value = int.parse(numberController.text);
                if (value != 0) {
                  listVentes.add(new Vente(item, value));
                  shopCount = shopCount + value;
                  shopCount == 0 ? addNewVente = false : addNewVente = true;
                  setState(() {
                    shopCount;
                    addNewVente;
                  });
                  Navigator.of(context).pop();
                  setState(() {
                    displayedList.clear();
                    myTextFieldController.clear();
                  });
                } else {}
              },
            ),
          ],
        );
      },
    );
  }

  String getSomme() {
    int somme = 0;
    listVentes.forEach((element) {
      somme = somme +
          (int.parse(
                  element.item.prixVente.replaceAll(new RegExp(r"\s+"), "")) *
              element.number);
    });
    return somme.toString();
  }

  String getQuantite() {
    int quantite = 0;
    listVentes.forEach((element) {
      quantite = quantite + element.number;
    });
    return quantite.toString();
  }

  @override
  bool get wantKeepAlive => true;
}
