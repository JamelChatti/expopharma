

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/displayvente.dart';
import 'package:expopharma/pages/itemDetailArticle.dart';
import 'package:expopharma/pages/forme.dart';
import 'dart:io';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expopharma/pages/shoppingCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:expopharma/pages/ItemForme.dart';
import 'package:flutter/widgets.dart';

class DetailArticlmaj extends StatefulWidget {
  Item article;

  DetailArticlmaj(this.article);

  String _selectedLocation = 'Please choose a location';

  @override
  _DetailArticlmajState createState() => _DetailArticlmajState();
}

class _DetailArticlmajState extends State<DetailArticlmaj> {
  List<Vente> listCommande = new List();
  List<ItemForme> formes = [];
  List<Item> articles = [];
  bool empty = true;
  final _formKey = GlobalKey<FormState>();
  final fireStoreInstance = FirebaseFirestore.instance;
  List<ItemDetailArticle> listDetailArticle = new List();
  String description;
  String dci1;
  String dci2;
  String dci3;
  File _image;
  String imageName;
  String _uploadedFileURL;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dci1Controller= TextEditingController();
  TextEditingController dci2Controller = TextEditingController();
  TextEditingController dci3Controller = TextEditingController();
  String myId;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
  Future pickergallery() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(myfile.path);
    });
  }

  Future pickercamera() async {
    final myimage = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 100, maxHeight: 480, maxWidth: 480);
    setState(() {
      _image = File(myimage.path);
    });
  }
  void uploadFile() async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('articles')
        .child(imageName)
        .putFile(_image);

    setState(() {
      _image = null;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDescription();
    imageName=widget.article.id + '.png';
  }
  @override
  void dispose() {
    dci1Controller.dispose();
    super.dispose();
  }
  List<Widget> getDetailsAsWidgets() {
    List<Widget> widgets = [];
    if (dci1 != null && dci1 != "") {
      widgets.add(Text(dci1));
    }
    if (dci2 != null && dci2 != "") {
      widgets.add(Text(dci2));
    }
    if (dci3 != null && dci3 != "") {
      widgets.add(Text(dci3));
    }
    if (description != null && description != "") {
      widgets.add(Text(description,style: TextStyle(fontSize: 18),));
    }
    return widgets;
  }


  @override
  Widget build(BuildContext context) {


    //FirebaseFirestore.instance.collection('commandeClient').snapshots().isEmpty;
    var path;
    return Scaffold(
        appBar: AppBar(
          title: Text('Description' + 'التفاصيل'),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 20,
            ),
            MyShoppingCard("commandeClient"),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchArticle()),
                );
              },
            )
          ],
        ),
        body:
        Center(

          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Image selectionnée'),
                  _image != null
                      ? Image.asset(
                    _image.path,
                    height: 150,
                  )
                      : Container(),
                  _image == null
                      ? Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Prendre une image',style: TextStyle(fontSize: 12),),
                        onPressed: pickercamera,
                        color: Colors.cyan,
                      ),
                      SizedBox(width: 15,),
                      RaisedButton(
                        child: Text('Importer une image',style: TextStyle(fontSize: 12),),
                        onPressed: pickergallery,
                        color: Colors.cyan,
                      )
                    ],)

                      : Container(),
                  SizedBox(height: 20,),
                  _image != null
                      ? ElevatedButton(
                    child: Text('Enregistrer l\'image'),
                    onPressed: uploadFile,
                  )
                      : Container(),
                  SizedBox(height: 20,),
                  _image != null
                      ? ElevatedButton(
                    child: Text('Ignorer'),
                    onPressed: null,
                  )
                      : Container(),
                  SizedBox(height: 20,),
                  Text('Enregistrer l\'image'),
                  SizedBox(height: 20,),
                  _uploadedFileURL != null
                      ? Image.network(
                    _uploadedFileURL,
                    height: 150,
                  )
                      : Container(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                  child: Text(widget.article.name)),
              Container(height: 300,
                  width: 300,
                  child:
                  Form(
                    key: _formKey,
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                            width: 350,
                            padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                            child: TextFormField(
                              controller: descriptionController,
                              // inputFormatters: [
                              //   new LengthLimitingTextInputFormatter(42),
                              // ],
                              decoration: InputDecoration(hintText:'Description' ,
                                fillColor: Colors.red,
                                focusColor: Colors.grey,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines:5,


                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            )),

                        Container(
                            width: 350,
                            padding: const EdgeInsets.only( right: 16.0,left: 16.0),
                            child: TextFormField(
                              controller: dci1Controller,

                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(42),
                              ],
                              decoration: InputDecoration(hintText:'DCI 1' ,
                                fillColor: Colors.red,
                                focusColor: Colors.grey,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines:1,
                            )),
                        Container(
                            width: 350,
                            padding: const EdgeInsets.only(left: 16.0, right: 16,),
                            child: TextFormField(
                              controller: dci2Controller,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(42),
                              ],
                              decoration: InputDecoration(hintText: 'DCI 2',
                                  fillColor: Colors.red,
                                  focusColor: Colors.grey
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines:1,

                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            )),
                        Container(
                            width: 350,
                            padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                            child: TextFormField(
                              controller: dci3Controller,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(42),
                              ],
                              decoration: InputDecoration(hintText: 'DCI 3',
                                  fillColor: Colors.red,
                                  focusColor: Colors.grey
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines:1,

                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            )),
                        Container  (
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if(widget.article != null){
                                if(myId==null) {
                                  await FirebaseFirestore.instance
                                      .collection("detailArticle")
                                      .add({
                                    'name': widget.article.name,
                                    'description': descriptionController.text,
                                    'idArticle': widget.article.id,
                                    'dci1': dci1Controller.text,
                                    'dci2': dci2Controller.text,
                                    'dci3': dci3Controller.text,
                                  });
                                }else{FirebaseFirestore.instance
                                    .collection('detailArticle')
                                    .doc(myId)
                                    .update({
                                  'name': widget.article.name,
                                  'description': descriptionController.text,
                                  'idArticle': widget.article.id,
                                  'dci1': dci1Controller.text,
                                  'dci2': dci2Controller.text,
                                  'dci3': dci3Controller.text,
                                }).then((result){
                                  print("new USer true");
                                }).catchError((onError){
                                  print("onError");
                                });

                                }
                                Navigator.of(context).pop();

                              }


                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
    );
  }

  // Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Cancel", true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;
  //   searchMedicamentByBarCode(barcodeScanRes);
  // }

  // void searchMedicamentByBarCode(String barcodeScanRes) {
  //   displayedList.clear();
  //   for (final value in dataList) {
  //     if (value.barCode == barcodeScanRes) {
  //       //displayedList.add(value);
  //       imageName = value.id+'.png';
  //       articleNameChoisi = value.name;
  //       articleIdChoisi = value.id;
  //       break;
  //     }
  //   }
  //   setState(() {
  //     articleNameChoisi;
  //     articleIdChoisi;
  //   });
  // }


  // searchItems(String text) {
  //   displayedList.clear();
  //   if (text.substring(0, 1) == "*") {
  //     displayedList = dataList
  //         .where((i) => i.name
  //         .toUpperCase()
  //         .contains(text.substring(1, text.length).toUpperCase()))
  //         .toList();
  //   } else {
  //     displayedList = dataList
  //         .where((i) => i.name.toUpperCase().startsWith(text.toUpperCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     displayedList;
  //   });
  // }

  Future<void> _showMyDialog(BuildContext context, Item item,
      ) async {


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Article choisi'),
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

                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

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

                Navigator.of(context).pop();
                setState(() {
                 // displayedList.clear();

                });

              },
            ),
          ],
        );
      },
    );
  }

  // List<Item> getListArticles(String value) {
  //   articles.clear();
  //   dataList.forEach((element) {
  //     if (element.name.toLowerCase().startsWith(value.toLowerCase())) {
  //       articles.add(element);
  //     }
  //   });
  //   print(articles.length);
  //   return articles;
  // }

  void getDescription()  {



    FirebaseFirestore.instance
        .collection('detailArticle')
        .where('idArticle', isEqualTo: widget.article.id)
        .snapshots()
        .listen((data)
    async {

      print('grower ${data.docs[0]['description']}');
      print("myId : " + data.docs[0].id);

      setState(() {
        myId = data.docs[0].id;
        descriptionController.text=data.docs[0]['description'];
        dci1Controller.text=data.docs[0]['dci1'];
        dci2Controller.text=data.docs[0]['dci2'];
        dci3Controller.text=data.docs[0]['dci3'];

      });
    });}
}