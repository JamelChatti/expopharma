import 'package:cloud_firestore/cloud_firestore.dart';

class ItemVitrine {
   String id;
   String name;
  String image;



  ItemVitrine.id();
  ItemVitrine(this.id,this.name, this.image);

  Map<String, dynamic> toMap() {
    return {
     'name': name,
      'image':image,
    'id': id, // this worked well
    };}

  factory ItemVitrine.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemVitrine(
     documentSnapshot["id"],
     documentSnapshot["name"],
      documentSnapshot["image"],
    );
  }

}
