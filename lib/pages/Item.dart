import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String id;
  String name;
  String barCode;
  String prixAchat;
  String prixVente;
  String forme;
  String stock;



  Item.id();
  Item(this.id, this.name, this.barCode,  this.prixAchat, this.prixVente,this.forme, this.stock);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barCode':barCode,
      'prixVente': prixVente,
      // this worked well

    };}

  factory Item.formDocument(DocumentSnapshot documentSnapshot) {
    return Item(
      documentSnapshot["id"],
      documentSnapshot["name"],
      documentSnapshot["barCode"],
      documentSnapshot["prixAchat"],
      documentSnapshot["prixVente"],
      documentSnapshot["forme"],
      documentSnapshot["stock"],
    );
  }

}

