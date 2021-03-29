import 'package:cloud_firestore/cloud_firestore.dart';

class ItemVente {
   var  timestamp;
   String nameclient;
  var vente;
  ItemVente.id();
  ItemVente(this.nameclient,this.vente, this.timestamp);

  Map<String, dynamic> toMap() {
    return {
     'timestamp': timestamp,
      'nameclient':nameclient,
    'vente': vente, // this worked well
    };}

  factory ItemVente.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemVente(
     documentSnapshot["timestamp"],
     documentSnapshot["nameclient"],
      documentSnapshot["vente"],
    );
  }

}
