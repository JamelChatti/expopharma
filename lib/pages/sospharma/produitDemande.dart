import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:expopharma/pages/sospharma/Produit.dart';

class ProduitDemande extends StatefulWidget {
  ProduitDemande({Key key}) : super(key: key);

  @override
  _ProduitDemandeState createState() => _ProduitDemandeState();
}

class _ProduitDemandeState extends State<ProduitDemande> {
  List<Produit> medicaments = new List();

  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchProduit();
// setState(() {
// medicaments;
// });
  }

  Future<List<Produit>> fetchProduit() async {
    medicaments.clear();
    FirebaseFirestore.instance
        .collection('produits')
        .orderBy('name', descending: false)
        .snapshots().forEach((data) {
      data.docs.forEach((doc) {
        print(doc.id);
        medicaments.add(new Produit(doc.id, doc["name"].toUpperCase(),
            doc["nbreDemande"], doc["timestamp"]));
      });
      print("done");
      medicaments.length > 0 ? addNewMed = false : addNewMed = true;
      setState(() {
        myController.clear();
        //FocusScope.of(context).requestFocus(FocusNode());
        addNewMed;
        medicaments;
      });
    }).whenComplete(() {

    });



//        .listen((data) {
//      medicaments.clear();
//      data.documents.forEach((doc) {
//        print(doc.documentID);
//        medicaments.add(new Produit(doc.documentID, doc["name"].toUpperCase(),
//            doc["nbreDemande"], doc["timestamp"]));
//      });
//      print("done");
//      medicaments.length > 0 ? addNewMed = false : addNewMed = true;
//      setState(() {
//        myController.clear();
//        FocusScope.of(context).requestFocus(FocusNode());
//        addNewMed;
//        medicaments;
//      });
//    });
//    print("null");
    return null;
  }

  Future<List<Produit>> findProduit(String name) async {
    if (name.length == 0) {
      fetchProduit();
      return null;
    }

    var strSearch = name;
    var strlength = strSearch.length;
    var strFrontCode = strSearch.substring(0, strlength - 1);
    var strEndCode = strSearch.substring(strlength - 1, strSearch.length);

    var startcode = strSearch;
    var endcode =
        strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);

    medicaments.clear();
    FirebaseFirestore.instance
        .collection('produits')
    //.where('name', isGreaterThanOrEqualTo : name)
        .where('name', isGreaterThanOrEqualTo: startcode)
        .where('name', isLessThanOrEqualTo: endcode)
        .snapshots().forEach((data) {
      data.docs.forEach((doc) {
        print(doc.id);
        medicaments.add(new Produit(doc.id, doc["name"].toUpperCase(),
            doc["nbreDemande"], doc["timestamp"]));
      });
      print("done");
      medicaments.length > 0 ? addNewMed = false : addNewMed = true;
      setState(() {
        //myController.clear();
        //addNewMed = false;
        //FocusScope.of(context).requestFocus(FocusNode());

        addNewMed;
        medicaments;
      });
    }).whenComplete(() {

    });

    return null;
  }

  Future<List<Produit>> removeProduit(String id, String name) async {
    FirebaseFirestore.instance
        .collection('produits')
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
      medicaments.clear();
      fetchProduit();
    });
  }

  Future<List<Produit>> modifierMarquage(String id, String type) async {
    FirebaseFirestore.instance
        .collection('produits')
        .doc(id)
        .get()
        .then((DocumentSnapshot) {
      print(DocumentSnapshot.data()['name'].toString());

      if (type == "augmenter") {
        FirebaseFirestore.instance.collection('produits').doc(id).update(
            {"nbreDemande": DocumentSnapshot.data()['nbreDemande'] + 1}).then((value) => fetchProduit());
      } else {
        FirebaseFirestore.instance.collection('produits').doc(id).update(
            {"nbreDemande": DocumentSnapshot.data()['nbreDemande'] - 1}).then((value) => fetchProduit());
      }
    });
  }

  Future<Produit> saveProduit(String name) async {
    fireStoreInstance.collection("produits").add({
      //'ventes': myList.toMap(),
      'name': name,
      'nbreDemande': 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }).then((value) {
      print(value.id);
      FocusScope.of(context).requestFocus(FocusNode());
      fetchProduit();
//      setState(() {
//        myController.clear();
//        addNewMed = false;
//        FocusScope.of(context).requestFocus(FocusNode());
//      });
    });
  }

  bool titleRed = true;
  bool apbarIsBlue = true;
  bool addNewMed = false;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (addNewMed) {
            saveProduit(myController.text.toUpperCase());
//            setState(() {
//              myController.clear();
//              addNewMed = false;
//              FocusScope.of(context).requestFocus(FocusNode());
//            });
          }
          // Add your onPressed code here!
        },
        child: Icon(Icons.add_box),
        backgroundColor: addNewMed ? Colors.blue : Colors.grey,
      ),
      appBar: AppBar(
        backgroundColor: apbarIsBlue ? Colors.blue : Colors.yellow,
        title: titleRed
            ? Text('Marquage article',
            style: TextStyle(fontSize: 18, color: Colors.white))
            : Text('Marquage article',
            style: TextStyle(fontSize: 18, color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              print('coucou'); // do something
              setState(() {
                titleRed = !titleRed;
                apbarIsBlue = !apbarIsBlue;
              });
            },
          )
        ],
      ),
      body: displayBody1(),
    );
  }

  Future<void> suppressionDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression medicament'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous supprimer  : ' +
                    medicaments[index].name +
                    ' ?'),
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
                removeProduit(medicaments[index].id, medicaments[index].name);

//                setState(() {
//                  medicaments.removeAt(index);
//                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> validationDialog(int index, String type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                type == "augmenter"
                    ? Text('Voulez vous valider le marquage de : ' +
                    medicaments[index].name +
                    ' ?')
                    : Text('Voulez vous valider le Demarquage de : ' +
                    medicaments[index].name +
                    ' ?'),
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
                modifierMarquage(medicaments[index].id, type);

//                setState(() {
//                  type == "augmenter"
//                      ? medicaments[index].nbreDemande =
//                          medicaments[index].nbreDemande + 1
//                      : medicaments[index].nbreDemande =
//                          medicaments[index].nbreDemande - 1;
//                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget displayBody1() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Designation med',
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                  suffixIcon: Icon(Icons.add_comment),
                ),
                onChanged: (text) {
//                  setState(() {
//
//                  });
                  //medicaments.clear();
                  findProduit(text.toUpperCase());
                },
              ),
              Flexible(
                  child: ListView.builder(
                    itemCount: medicaments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: GestureDetector(
                                      onLongPress: () {
                                        suppressionDialog(index);
                                      },
                                      child: Text(
                                        medicaments[index].name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                      medicaments[index].nbreDemande.toString())),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    validationDialog(index, "augmenter");
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  tooltip: 'Increase volume by 10',
                                  onPressed: () {
                                    validationDialog(index, "dimimuer");
                                  },
                                ),
                              )
                            ],
                          ));
                    },
                  )),
            ],
          )),
    );
  }
}
