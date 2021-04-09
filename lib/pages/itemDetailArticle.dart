import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailArticle {
  String dci1;
  String dci2;
  String dci3;
  String description;
  String idArticle;
  String name;
  int dateExp;


  ItemDetailArticle(this.dci1,this.dci2,this.dci3,this.description,this.idArticle,this.name,this.dateExp);


  Map<String, dynamic> toMap() {
    return {

      'dci1': dci1,
      'dci2': dci2,
      'dci2': dci2,
      'description' : description,
      'idArticle' :idArticle,
      'name': name,
      'dateExp' : dateExp,

      // this worked well
    };}

  factory ItemDetailArticle.fromDocument(DocumentSnapshot documentSnapshot) {
    return ItemDetailArticle(
        documentSnapshot["dci1"],
        documentSnapshot["dci2"],
        documentSnapshot["dci3"],
        documentSnapshot["description"],
        documentSnapshot["idArticle"],
        documentSnapshot["name"],
        documentSnapshot["dateExp"]
    );
  }

}
