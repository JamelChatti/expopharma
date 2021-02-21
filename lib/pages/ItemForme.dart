import 'package:cloud_firestore/cloud_firestore.dart';

class ItemForme {
  int id;
  String name;
  String image;



  ItemForme.id();
  ItemForme(this.id, this.name, this.image);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image':image,
      'id': id  // this worked well

    };}

  factory ItemForme.formDocumrnt(DocumentSnapshot documentSnapshot) {
    return ItemForme(
      documentSnapshot["id"],
      documentSnapshot["name"],
      documentSnapshot["image"],
    );
  }

}
