import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/vente.dart';

class ListVente {
  int timestamp;
  List<Vente> ventes;
  String documentID;

  ListVente.id();
  ListVente(this.ventes, this.timestamp, this.documentID);

  Map<String, dynamic>  toMap() {
    return {
      'vente': ventes.map((i) => i.toMap()).toList(),  // this
    };}

}


