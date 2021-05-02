import 'dart:io';

import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/sospharma/datasos.dart';
import 'package:expopharma/pages/sospharma/inventaireList.dart';
import 'package:expopharma/pages/sospharma/produitDemande.dart';
import 'package:expopharma/pages/sospharma/sosPharma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AccueilSos extends StatefulWidget {
  @override
  _AccueilSosState createState() => _AccueilSosState();
}

class _AccueilSosState extends State<AccueilSos> {

  HashMap<String, String> stockMap = new HashMap();
  List<Item> displayedList = new List();
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if(dataListsos.length == 0){
      loadListFromInternet();
    } else {
      loading = false;
    }
  }

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

    loadListFromInternet2();

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
        if ((name.length > 0 || barCode.length > 0) )
          // if ((name.length > 0 || barCode.length > 0) && stockMap[id] != null)
          dataListsos.add(new Item(
              id, name, barCode, prixAchat, prixVente, forme, stockMap[id],null));
      }
    }).toList();
    setState(() {
      loading = false;
    });

    print(dataListsos.length);


  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('SOS PHARMA'),
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: SizedBox(
                height: 70,
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          'VENTE',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Icon(Icons.add_shopping_cart_sharp)
                      ],
                    )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => SosPharma()),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
                child: SizedBox(
                  height: 70,
                  child: Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text('INVENTAIRE', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 95,
                          ),
                          Icon(Icons.account_tree_rounded)
                        ],
                      )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => InventaireList()),
                  );
                }),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: SizedBox(
                height: 70,
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: Row(
                      children: [ SizedBox(
                        width: 30,
                      ),
                        Text('PRODUIT DEMANDE', style: TextStyle(fontSize: 20)),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(Icons.wifi_protected_setup_sharp)
                      ],
                    )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => ProduitDemande()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
