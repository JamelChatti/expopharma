import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:expopharma/pages/itemClient.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'data.dart';
import 'data.dart';
import 'data.dart';
import 'data.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  List<ItemClient> clients = [];
  bool loading = true;
  HashMap<String, String> idMap = new HashMap();
  List<String> cli = [];

  TextEditingController codeController;
  TextEditingController nameController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = new TextEditingController();
    nameController = new TextEditingController();
    // dataList est uine listé enregistrer dans le fichier data.dart
    // si le fichier contient deja les elément( chargé depuit internet), on l'affiche directement
    if (listClient.length == 0) {
      // on va chargé la liste des sock et la liste des médicaments et creer des objets Item

      loadListclientcode();
    } else {
      loading = false;
    }
  }

  void loadListclientcode() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('lst_cli.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpslst_cli.txt');
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
      String id = s.split('\t').elementAt(0);
      String name = s.split('\t').elementAt(1);
      if (name.length > 0 && id.length > 0) {
        cli.add(name);
        idMap.putIfAbsent(name, () => id);
        //print(name);
      }
    }).toList();
    loadListclientsold();
  }

  void loadListclientsold() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('client.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpsclient.txt');
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
      if (s.split('\t').length > 2) {
        String name = s.split('\t').elementAt(0);
        String solde = s.split('\t').elementAt(2);

        print(name);

        if (name.length > 0 && idMap[name] != null) {
          listClient.add(new ItemClient(idMap[name], name, solde));
          print(listClient.length);
        }
      }
    }).toList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          brightness: Brightness.light,
          title: SizedBox(
              height: 37,
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                height: 37.0,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: TextField(
                    //expands: true,
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black26)),

                  ),
                ),
              )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 120,
              width: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          //expands: true,
                          maxLines: 1,
                          autofocus: false,
                          controller: codeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Code',
                              hintStyle: TextStyle(color: Colors.black26)),

                        ),
                      ),
                      Expanded(
                        child: TextField(
                          //expands: true,
                          maxLines: 1,
                          autofocus: false,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nom',
                              hintStyle: TextStyle(color: Colors.black26)),

                        ),
                      ),
                    ],
                  ),
                  TextButton(onPressed: (){
                    if(codeController.text.isNotEmpty && nameController.text.isNotEmpty){
                      getListclients(nameController.text, codeController.text);
                    }
                  }, child: Text("Valider")),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              itemCount: clients.length,
              itemBuilder: (context, index) {
                Color color = index.isOdd ? Colors.grey[100] : Colors.blue[50];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      clients[index].name +
                          '\n' +
                          'Solde =' +
                          clients[index].solde +
                          '\n' +
                          'Code =' +
                          clients[index].id,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }

  void getListclients(String name, String code) {
    ItemClient myClient;
        listClient.forEach((element) {
          print(element.id);
          if(element.id == code){
            myClient = element;
          }
        });

    if (myClient != null) {
      if (myClient.name.replaceAll(new RegExp(r"\s+"), "") == name) {
        clients.add(myClient);
        setState(() {});
      }
    }
    // listClient.forEach((element) {
    //   String name = element.name.replaceAll(new RegExp(r"\s+"), "") + element.id;
    //   if (name == value ) {
    //
    //   }
    // });
    // if(clients.length > 0){
    //   setState(() {});
    // }
  }
}
