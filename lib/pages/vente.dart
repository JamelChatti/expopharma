import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';


class Vente {
  Item item;
  int number;

  Vente.id();
  Vente(this.item, this.number);

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': item.name,
      'barCode': item.barCode,
      'prixVente': item.prixVente,// this worked well
    };}


  factory Vente.formDocumrnt(DocumentSnapshot documentSnapshot) {
    int timeStamp = documentSnapshot["timestamp"];

    documentSnapshot["vente"].data.forEach((key, value) {
      print(documentSnapshot["number"]);
    });


    // documentSnapshot.data.forEach((key, value) {
    //   print(value);
    //   //LigneVente item = LigneVente.formDocumrnt(value["vente"]);
    //   //Vente vente = new Vente(item, documentSnapshot.data["number"]);
    // }
    // );

    //Item item =  new Item(documentSnapshot["name"], documentSnapshot.data["barCode"], documentSnapshot.data["prixVente"], documentSnapshot.data["prixVente"]);

    return null;
  }

}


