import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCategorie {
  String id;
  String name;
  String image;



  ItemCategorie.id();
  ItemCategorie(this.id, this.name, this.image);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image':image,
      'id': id  // this worked well
    };}

  factory ItemCategorie.formDocument(DocumentSnapshot documentSnapshot) {
    return ItemCategorie(
      documentSnapshot["id"],
      documentSnapshot["name"],
      documentSnapshot["image"],
    );
  }

}
