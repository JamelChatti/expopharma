import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  bool isActive;
  bool isAdmin;
  String password;
  int timestamp;
  String documentID;

  User.id();
  User(this.email, this.isActive, this.isAdmin, this.password, this.timestamp, this.documentID);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isActive':isActive,
      'isAdmin':isAdmin,
      'password':password,
      'timestamp': timestamp,
      'documentID': documentID,

    };}

  factory User.formDocumrnt(DocumentSnapshot documentSnapshot) {
    return User(
      documentSnapshot["email"],
      documentSnapshot["isActive"],
      documentSnapshot["isAdmin"],
      documentSnapshot["password"],
      documentSnapshot["timestamp"],
      documentSnapshot["documentID"],
    );
  }

}