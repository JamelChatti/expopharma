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
TextEditingController descriptionController = TextEditingController();
  TextEditingController dci1Controller = TextEditingController();
  TextEditingController dci2Controller = TextEditingController();
  TextEditingController dci3Controller = TextEditingController();
  File _image;
  String _uploadedFileURL;
  List<Item> articles = [];
  List<Item> displayedList = new List();
  File  _file;
  String imageName;
  String articleNameChoisi = '';
  Item articleSelected;
  String articleChoisibyScan ;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enregistrer une image d\'unarticle'),
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
                    child: Text('Prendre une image'),
                    onPressed: pickercamera,
                    color: Colors.cyan,
                  ),
                  SizedBox(width: 15,),
                  RaisedButton(
                    child: Text('Importer une image'),
                    onPressed: pickergallery,
                    color: Colors.cyan,
                  )
                ],)

                    : Container(),
                SizedBox(height: 20,),
                _image != null
                    ? RaisedButton(
                        child: Text('Enregistrer l\'image'),
                        onPressed: uploadFile,
                        color: Colors.cyan,
                      )
                    : Container(),
                SizedBox(height: 20,),
                _image != null
                    ? RaisedButton(
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
                                    setState(() {});
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
                 // _showMyDialog(context, displayedList.first );
                  //articleChoisibyScan= displayedList.first.name as String;
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
                       inputFormatters: [
                         new LengthLimitingTextInputFormatter(42),
                       ],
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

                              await FirebaseFirestore.instance
                                  .collection("detailArticle")
                                  .add({
                                'name': articleSelected.name,
                                'description': descriptionController.text,
                                'idArticle':articleSelected.id,
                                'dci1' : dci1Controller.text,
                                'dci2' : dci2Controller.text,
                                'dci3' : dci3Controller.text,
                              });
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
        break;
      }
    }
    setState(() {
      articleNameChoisi;
    });
  }


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
}
