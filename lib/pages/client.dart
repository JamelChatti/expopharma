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
  TextEditingController phoneController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = new TextEditingController();
    phoneController = new TextEditingController();
    // dataList est uine listé enregistrer dans le fichier data.dart
    // si le fichier contient deja les elément( chargé depuit internet), on l'affiche directement
    if (listClient.length == 0) {
      loadListclientsold();
    } else {
      loading = false;
    }
  }

  void loadListclientsold() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('credit2.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpscredit2.txt');
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
        String code = s.split('\t').elementAt(0);
        String name1 = s.split('\t').elementAt(1);
        String phone1 = s.split('\t').elementAt(2);
        String creditMax = s.split('\t').elementAt(3);
        String solde = s.split('\t').elementAt(4);
        String phone = phone1.replaceAll("-", "");
        String name = name1.replaceAll("-", "");

        print(name);

        if (name.length > 0 ) {
          listClient.add(new ItemClient(code, name, solde,phone,creditMax));
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
                          obscureText: true,
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
                          controller: phoneController,
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
                    if(codeController.text.isNotEmpty && phoneController.text.isNotEmpty){
                      getListclients(phoneController.text, codeController.text);
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
                          '\n' ,
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

  void getListclients(String phoneSaisie, String codeSaisie) {
    ItemClient myClient;
        listClient.forEach((element) {
          print(element.code);
          if(element.code == codeSaisie){
            myClient = element;
          }
        });

    if (myClient != null) {
      if (myClient.phone.replaceAll(new RegExp(r"\s+"), "") == phoneSaisie) {
        clients.add(myClient);
        setState(() {});
      }
    }

  }
}
