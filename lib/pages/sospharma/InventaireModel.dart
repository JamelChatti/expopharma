import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';

class InventaireModel {
  String name;
  int timestamp;
  String documentID;
  List<InventaireLigne> inventaireLigneList;

  InventaireModel.id();
  InventaireModel(this.name, this.timestamp, this.documentID, this.inventaireLigneList);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'timestamp':timestamp,
      'documentID': documentID,
      'inventaireLigneList': inventaireLigneList,
    };}

  factory InventaireModel.formDocument(DocumentSnapshot documentSnapshot) {
    return InventaireModel(
      documentSnapshot["name"],
      documentSnapshot["timestamp"],
      documentSnapshot["documentID"],
      documentSnapshot["inventaireLigneList"],
    );
  }

}