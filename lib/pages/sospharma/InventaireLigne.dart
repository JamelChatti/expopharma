import 'package:cloud_firestore/cloud_firestore.dart';

class InventaireLigne {
  String name;
  String barCode;
  String stock;
  String newStock;
  String expdate = '';
  int timestamp;
  String documentID;
  String prixAchat;
  String userName;

  InventaireLigne.id();
  InventaireLigne(this.name, this.barCode, this.stock, this.newStock,this.expdate, this.timestamp, this.documentID, this.prixAchat, this.userName);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barCode':barCode,
      'stock': stock,
      'newStock': newStock,
      'expdate' : expdate,
      'timestamp': timestamp,
    };}

  factory InventaireLigne.formDocumrnt(DocumentSnapshot documentSnapshot) {
    return InventaireLigne(
      documentSnapshot["name"],
      documentSnapshot["barCode"],
      documentSnapshot["stock"],
      documentSnapshot["newStock"],
      documentSnapshot["expdate"],
      documentSnapshot["timestamp"],
      documentSnapshot["documentID"],
      documentSnapshot["prixAchat"],
      documentSnapshot["userName"],
    );
  }

}