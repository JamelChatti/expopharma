import 'dart:io';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AjoutImage extends StatefulWidget {
  @override
  _AjoutImageState createState() => _AjoutImageState();
}

class _AjoutImageState extends State<AjoutImage> {
  File _image;
  String _uploadedFileURL;
  List<Item> articles = [];
  List<Item> displayedList = new List();

  String imageName;
  String articleChoisi = '';
  String articleChoisibyScan ;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
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
        child: Column(
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
                    ? RaisedButton(
                        child: Text('Prendre une image'),
                        onPressed: pickercamera,
                        color: Colors.cyan,
                      )
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
                                    imageName = suggestion.id + '.png';
                                    articleChoisi = suggestion.name;
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
            Text(articleChoisi)
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
        articleChoisi = value.name;
        break;
      }
    }
    setState(() {
      articleChoisi;
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
