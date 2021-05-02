//import 'dart:html';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:file_picker/file_picker.dart';



class MajStockprix extends StatefulWidget {
  @override
  _MajStockprixState createState() => _MajStockprixState();
}

class _MajStockprixState extends State<MajStockprix> {

//  File _image;
  String _uploadedFileURL;
  File file;
  String imageName;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;



  // Future<void> uploadExample(String fileName) async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String filePath = '${appDocDir.absolute}/${fileName}';
  //   // ...
  //   // e.g. await uploadFile(filePath);
  // }
  Future<void> uploadFile() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    //
    // if(result != null) {
    //   File file = File(result.files.single.path);
    // } else {
    //   // User canceled the picker
    // }
    // File file = File(filePath);

    // try {
    //   await firebase_storage.FirebaseStorage.instance
    //       .ref()
    //       .putFile(file);
    // }  catch (e) {
    //   // e.g, e.code == 'canceled'
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mise à jour stock et prix'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          ElevatedButton(

            child: Text('Importer le fichier stock'),
            onPressed:uploadFile ,
          ),
          ElevatedButton(

            child: Text('Maj du stock'),
           // onPressed:uploadExample ,
          )
        ],),
      ),
    );
  }
}
