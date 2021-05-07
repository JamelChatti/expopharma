//import 'dart:html';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;



class MajStockprix extends StatefulWidget {
  @override
  _MajStockprixState createState() => _MajStockprixState();
}

class _MajStockprixState extends State<MajStockprix> {

//  File _image;
  String fileName= '';
  File file;
  String msgConfirmation='';
  String imageName;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      file = File(result.files.single.path);
     setState(() {
       fileName=file.toString().split('/').last;
       msgConfirmation='';
     });
    } else {
      // User canceled the picker
    }
  }

 void uploadFile() async {
   FirebaseStorage _storage = FirebaseStorage.instance;
   Reference reference =
   _storage.ref().child("/" + path.basename(file.path));
   UploadTask uploadTask = reference.putFile(file,SettableMetadata(contentType: 'text/plain'));

   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {

     setState(() {
       msgConfirmation='Mise à jour effectuée avec succés...';
     });
   });

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mise à jour stock et prix'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.all(50),
            child: ElevatedButton(

              child: Text('Importer le fichier stock'),
              onPressed:pickFile ,
            ),
          ),
          SizedBox(height: 50,
          child: Text(fileName),),
          Container(margin: EdgeInsets.all(50),
height: 50,
            child: ElevatedButton(

              child: Text('Mise à jour du : '+fileName),
              onPressed:uploadFile ,
            ),

          ),
          SizedBox(height: 50,
            child: Text(msgConfirmation),),

        ],),
      ),
    );
  }
}
