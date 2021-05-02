import 'package:cloud_firestore/cloud_firestore.dart';

class UserSos {
  String email;
  bool isActive;
  bool isAdmin;
  String password;
  int timestamp;
  String documentID;

  UserSos.id();
  UserSos(this.email, this.isActive, this.isAdmin, this.password, this.timestamp, this.documentID);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'isActive':isActive,
      'isAdmin':isAdmin,
      'password':password,
      'timestamp': timestamp,
      'documentID': documentID,

    };}

  factory UserSos.formDocumrnt(DocumentSnapshot documentSnapshot) {
    return UserSos(
      documentSnapshot["email"],
      documentSnapshot["isActive"],
      documentSnapshot["isAdmin"],
      documentSnapshot["password"],
      documentSnapshot["timestamp"],
      documentSnapshot["documentID"],
    );
  }

}