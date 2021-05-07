import 'package:cloud_firestore/cloud_firestore.dart';

class ItemClient {
  String id;
  String name;
  String solde;



  ItemClient.id();
  ItemClient(this.id, this.name,this.solde);

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'solde': solde,
      // this worked well

    };}

  factory ItemClient.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemClient(
      documentSnapshot["id"],
      documentSnapshot["name"],
      documentSnapshot["code"],
    );
  }

}

