import 'package:cloud_firestore/cloud_firestore.dart';

class ItemClient {
  String code;
  String name;
  String solde;
  String phone;
  String creditMax;



  ItemClient.code();
  ItemClient(this.code, this.name,this.solde,this.phone,this.creditMax);

  Map<String, dynamic> toMap() {
    return {
      'id' : code,
      'name': name,
      'solde': solde,
      'phone' : phone,
      'creditMax': creditMax,
      // this worked well

    };}

  factory ItemClient.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemClient(
      documentSnapshot["id"],
      documentSnapshot["name"],
      documentSnapshot["solde"],
      documentSnapshot["phone"],
      documentSnapshot["creditMax"],
    );
  }

}

