import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/sospharma/ventesos.dart';

class ListVenteSos {
  int timestamp;
  List<VenteSos> ventessos;
  String documentID;

  ListVenteSos.id();
  ListVenteSos(this.ventessos, this.timestamp, this.documentID);

  Map<String, dynamic>  toMap() {
    return {
      'vente': ventessos.map((i) => i.toMap()).toList(),  // this
    };}

}


