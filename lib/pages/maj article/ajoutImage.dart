import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AjoutImage extends StatefulWidget {

  @override
  _AjoutImageState createState() => _AjoutImageState();
}

class _AjoutImageState extends State<AjoutImage> {
  final _formKey = GlobalKey<FormState>();
  String description;
  String dci1;
  String dci2;
  String dci3;
  final fireStoreInstance = FirebaseFirestore.instance;
TextEditingController descriptionController = TextEditingController();
 TextEditingController dci1Controller= TextEditingController();
  TextEditingController dci2Controller = TextEditingController();
  TextEditingController dci3Controller = TextEditingController();
  File _image;
  String _uploadedFileURL;
  List<Item> articles = [];
  List<Item> displayedList = new List();
  File  _file;
  String imageName;
  String articleNameChoisi = '';
  String articleIdChoisi = '';
  Item articleSelected;
  String articleChoisibyScan ;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Mise à jour d\'unarticle'),
      ),
      body: Center(

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
            RaisedButton(
                child: Text('Choisir un article'),
                onPressed: () {
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Chercher article'),
                          content: Center(
                            child: Column(
                              children: <Widget>[
                                TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          autofocus: true,
                                          style: TextStyle(fontSize: 15),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder())),
                                  suggestionsCallback: (pattern) async {
                                    return getListArticles(pattern);
                                  },
                                  itemBuilder: (context, Item suggestion) {
                                    return ListTile(
                                      //leading: Icon(Icons.shopping_cart),
                                      title: Text(suggestion.name),
                                      subtitle: Text(suggestion.barCode),
                                    );
                                  },
                                  onSuggestionSelected: (Item suggestion) {
                                    print(suggestion);
                                    articleSelected = suggestion;
                                    imageName = suggestion.id + '.png';
                                    articleNameChoisi = suggestion.name;
                                    articleIdChoisi= suggestion.id;
                                    setState(() {
                                      getDescription();
                                    });

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton.icon(
                color: Colors.grey[200],
                onPressed: () async{
                  await scanBarcodeNormal();
                },
                icon: Icon(Icons.qr_code_scanner_sharp),
                label: Text("Appuyer")),
            Text(articleNameChoisi),
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
                          if(articleSelected != null){
                            if(myId==null) {
                              await FirebaseFirestore.instance
                                  .collection("detailArticle")
                                  .add({
                                'name': articleSelected.name,
                                'description': descriptionController.text,
                                'idArticle': articleSelected.id,
                                'dci1': dci1Controller.text,
                                'dci2': dci2Controller.text,
                                'dci3': dci3Controller.text,
                              });
                            }else{FirebaseFirestore.instance
                                .collection('detailArticle')
                                .doc(myId)
                                .update({
                              'name': articleSelected.name,
                              'description': descriptionController.text,
                              'idArticle': articleSelected.id,
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
                      child: Text('Valider'),
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
        //displayedList.add(value);
        imageName = value.id+'.png';
        articleNameChoisi = value.name;
        articleIdChoisi = value.id;
        break;
      }
    }
    setState(() {
      articleNameChoisi;
      articleIdChoisi;
    });
  }

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
                    displayedList.clear();

                  });

              },
            ),
          ],
        );
      },
    );
  }

  List<Item> getListArticles(String value) {
    articles.clear();
    dataList.forEach((element) {
      if (element.name.toLowerCase().startsWith(value.toLowerCase())) {
        articles.add(element);
      }
    });
    print(articles.length);
    return articles;
  }

  void getDescription()  {



    FirebaseFirestore.instance
        .collection('detailArticle')
        .where('idArticle', isEqualTo: articleIdChoisi)
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