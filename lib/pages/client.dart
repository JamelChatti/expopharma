import 'package:expopharma/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Client extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('مرحبا حريفنا الكريم',),
      actions: <Widget>[
        RaisedButton(
            child: Text('خروج quitter', style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed:()async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),);
            })
      ],
    ),
      body: Container(

      )
    );
  }
}
