import 'package:cloud_firestore/cloud_firestore.dart';

class ItemVitrine {

   String idVitrine;
   String name;
  String image;



  ItemVitrine.id();
  ItemVitrine(this.idVitrine,this.name, this.image);

  Map<String, dynamic> toMap() {
    return {

      'idVitrine': idVitrine,
     'name': name,
      'image':image,
     // this worked well
    };}

  factory ItemVitrine.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemVitrine(
     documentSnapshot["idVitrine"],
     documentSnapshot["name"],
      documentSnapshot["image"],
    );
  }

}
