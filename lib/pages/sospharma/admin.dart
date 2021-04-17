import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/sospharma/usersos.dart';
import 'package:flutter/material.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/sospharma/listVentesos.dart';
import 'package:expopharma/pages/sospharma/usersos.dart';


import 'package:intl/intl.dart';
import 'package:expopharma/pages/data.dart';

class AdminPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<AdminPage> {
  final fireStoreInstance = FirebaseFirestore.instance;

  TextEditingController myTextFieldController;
  TextEditingController myPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
    myPasswordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Administration"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Text(
                        "Supprimer l'inventaire actuel..",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey[200],
                        child: new IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                      'Supprimer définitivement l\'inventaire'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Veiller introduire votre mot de passe'),
                                        Padding(
                                            padding: EdgeInsets.all(20),
                                            child: TextFormField(
                                              controller: myPasswordController,
                                              decoration: const InputDecoration(
                                                  labelText: 'Password'),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                            )),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('ANNULER'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('VALIDER'),
                                      onPressed: () {
                                        if (myPasswordController
                                                .text.isNotEmpty &&
                                            myPasswordController.text ==
                                                currentUser.password) {
                                          fireStoreInstance
                                              .collection('inventaire')
                                              .get()
                                              .then((snapshot) {
                                            for (DocumentSnapshot ds
                                                in snapshot.docs) {
                                              ds.reference.delete();
                                            }
                                            ;
                                          }).whenComplete(() {
                                            print("complete");
                                            Navigator.of(context).pop();
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete_forever),
                          color: Colors.red,
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Text(
                "Ajouter un utilisateur..",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: myTextFieldController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.grey[200],
                        child: new IconButton(
                          onPressed: () {
                            fireStoreInstance.collection("sosUsers").add({
                              //'ventes': myList.toMap(),
                              'email': myTextFieldController.text,
                              'isActive': true,
                              'isAdmin': false,
                              'password': '',
                              'timestamp':
                                  DateTime.now().millisecondsSinceEpoch,
                            }).then((value) {
                              print(value.id);
                              myTextFieldController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                          icon: Icon(Icons.add),
                          color: Colors.blue,
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: fireStoreInstance
                  .collection("sosUsers")
                  .orderBy('email')
                  .snapshots(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (dataSnapshot.hasData) {
                  List<UserSos> users = new List();
                  dataSnapshot.data.documents.forEach((result) {
                    //print(result.documentID);
                    String email = result["email"];
                    bool isActive = result["isActive"];
                    bool isAdmin = result["isAdmin"];
                    String password = result["password"];
                    int myTime = result["timestamp"];
                    UserSos user = UserSos(email, isActive, isAdmin, password, myTime,
                        result.documentID);
                    users.add(user);
                  });

                  if (users.length == 0) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ajouter des utilisateurs..',
                          style: TextStyle(
                              color: Color(0xFFE0E0E0),
                              //fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Icon(
                          Icons.supervised_user_circle,
                          color: Color(0xFFE0E0E0),
                          size: 126.0,
                        )
                      ],
                    ));
                  }
                  return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var date = DateTime.fromMillisecondsSinceEpoch(
                            users[index].timestamp);
                        var formattedDate =
                            DateFormat.yMMMMd('en_US').format(date);

                        Color color = index.isOdd
                            ? Colors.grey[100]
                            : Colors.blue[50]; //choose color
                        return Dismissible(
                            key: Key(users[index].email),
                            confirmDismiss: (DismissDirection direction) async {
                              return null;
                            },
                            background: Container(
                              padding: EdgeInsets.only(left: 5),
                              alignment: Alignment.centerLeft,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            secondaryBackground: Container(
                              padding: EdgeInsets.only(right: 5),
                              alignment: Alignment.centerRight,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            child: Container(
                              color: color,
                              child: GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 5,
                                          child: Text(
                                            users[index].email,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blue),
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: Switch(
                                          value: users[index].isActive,
                                          inactiveThumbColor: Colors.grey,
                                          inactiveTrackColor: Colors.grey,
                                          onChanged: (newVal) {
                                            setState(() {
                                              FirebaseFirestore.instance
                                                  .collection('sosUsers')
                                                  .doc(
                                                      users[index].documentID)
                                                  .update({
                                                "isActive":
                                                    !users[index].isActive
                                              }).then((value) =>
                                                      {print("UPDATED")});
                                            });
                                          },
                                        ),

//                                        Text(
//                                          users[index].isActive.toString(),
//                                          style: TextStyle(
//                                              fontSize: 15,
//                                              color: Colors.green),
//                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      });
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
