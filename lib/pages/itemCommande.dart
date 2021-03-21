import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCommande {
   String name;
  int number;
   String prixVente;
   var timestamp;
   String documentID;


  ItemCommande(this.name,this.prixVente,this.number,this.timestamp,this.documentID);



  Map<String, dynamic> toMap() {
    return {

      'number': number,
      'prixVente':prixVente,
      'name': name,
      'timestamp':timestamp,
    // this worked well
    };}

  factory ItemCommande.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemCommande(
     documentSnapshot["name"],
     documentSnapshot["number"],
      documentSnapshot["prixVente"],
      documentSnapshot["timestamp"],
      documentSnapshot["documentID"]
    );
  }

}
