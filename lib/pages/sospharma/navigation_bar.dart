import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/sospharma/sosPharma.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:excel/excel.dart';
import 'package:expopharma/pages//Item.dart';
import 'package:expopharma/pages/sospharma/listVentesos.dart';
import 'package:expopharma/pages/Vente.dart';
import 'package:expopharma/pages/sospharma/admin.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/sospharma/history.dart';
import 'package:expopharma/pages/sospharma/inventaire.dart';
import 'package:expopharma/pages/sospharma/inventaireList.dart';
import 'package:expopharma/pages/sospharma/produitDemande.dart';
import 'package:expopharma/pages/sospharma/sos.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart'
    show ByteData, PlatformException, rootBundle;

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:fluttericon/font_awesome5_icons.dart';
//import 'package:fluttericon/font_awesome_icons.dart';
import 'package:badges/badges.dart';
//import 'package:wifi_info_plugin/wifi_info_plugin.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    SosPharma(),
    InventaireList(),
    ProduitDemande(),
    AdminPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            title: Text('SOS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Inventaire'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Produit Demande'),
          ),
          if(currentUser.isAdmin)
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Admin'),
            ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}