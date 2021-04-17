import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expopharma/pages/sospharma/InventaireLigne.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/sospharma/listVentesos.dart';
import 'package:expopharma/pages/sospharma/ShowTotal.dart';
import 'package:expopharma/pages/Vente.dart';

import 'package:intl/intl.dart';
import 'package:expopharma/pages/data.dart';

class InventaireHistory extends StatefulWidget {
  String parentId;
  String parentName;
  InventaireHistory(this.parentId, this.parentName);
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<InventaireHistory> {
  final fireStoreInstance = FirebaseFirestore.instance;
  TextEditingController myTextFieldController;
  TextEditingController myPasswordController;



  bool displayTotal = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
    myPasswordController = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {

    List<InventaireLigne> inventaires = new List();
    int totalNew = 0;
    int totalOld = 0;

    print(widget.parentId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Inventaire : " + widget.parentName),
        actions: [
          currentUser.isAdmin ?
          IconButton(
            icon: Icon(
              Icons.monetization_on,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              showTotal(context, totalNew, totalOld);
            },
          ) : Container(),
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: [
            displayTotal ? Padding(
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      Text("Total NEW : " + totalNew.toString()),
                      Text("Total stock: " + totalOld.toString())
                    ],))) : Container(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
//                                      Expanded(
//                                          flex: 0,
//                                          child: Text(
//                                            formattedDate,
//                                            style: TextStyle(fontSize: 15),
//                                          )),
                  Expanded(
                      flex: 9,
                      child: Text(
                        "DESIGNATION",
                        style: TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                  Expanded(flex: 2, child: Text("ASck",style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),)),
                  Expanded(flex: 2, child: Text("NSck ",style: TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),)),
                  Expanded(flex: 2, child: Text("Exp ",style: TextStyle(fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),)),
                  Expanded(flex: 1, child: Text("Pr",style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
            Expanded(
                child: StreamBuilder(
              stream: fireStoreInstance
                  .collection("inventaire")
                  .orderBy('name')
                  .where("parentId", isEqualTo: widget.parentId)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (dataSnapshot.hasData) {

                  dataSnapshot.data.documents.forEach((result) {
                    //print(result.documentID);
                    int myTime = result["timestamp"];
                    String name = result["name"];
                    String barCode = result["barCode"];
                    String stock = result["stock"];
                    String newStock = result["newStock"];
                    String expdate  =result ["expdate"];
                    String userName = result["userName"];
                    String prixAchat = result["prixAchat"];
                    InventaireLigne vente =
                        InventaireLigne(name, barCode, stock, newStock,expdate, myTime, result.documentID, prixAchat, userName);
                    inventaires.add(vente);
                    if(prixAchat != null){
                      totalNew = totalNew + (int.parse(prixAchat
                          .replaceAll(new RegExp(r"\s+"), "")) * int.parse(newStock.replaceAll(new RegExp(r"\s+"), "")));

                      totalOld = totalOld + (int.parse(prixAchat
                          .replaceAll(new RegExp(r"\s+"), "")) * int.parse(stock.replaceAll(new RegExp(r"\s+"), "")));
                    }

                  });

                  if (inventaires.length == 0) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Be the first to comment',
                          style: TextStyle(
                              color: Color(0xFFE0E0E0),
                              //fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        Icon(
                          Icons.comment,
                          color: Color(0xFFE0E0E0),
                          size: 126.0,
                        )
                      ],
                    ));
                  }
                  return ListView.builder(
                      itemCount: inventaires.length,
                      itemBuilder: (context, index) {
                        var date = DateTime.fromMillisecondsSinceEpoch(
                            inventaires[index].timestamp);
                        var formattedDate =
                            DateFormat.yMMMMd('en_US').format(date);

                        Color color = index.isOdd
                            ? Colors.grey[100]
                            : Colors.blue[50]; //choose color

                        return Dismissible(
                            // Each Dismissible must contain a Key. Keys allow Flutter to
                            // uniquely identify widgets.
                            key: Key(inventaires[index].barCode),
                            // Provide a function that tells the app


                            confirmDismiss: (DismissDirection direction) async {
                              if(direction==DismissDirection.startToEnd){
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController numberController = new TextEditingController();
                                    return AlertDialog(
                                      title: Text('Modification ligne Inventaire'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[


                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  'D.Régularisation : ' + formattedDate,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            Text('Veuillez introduire le nouveau stock '),
                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                   inventaires[index].name,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: TextFormField(
                                                  autofocus: true,
                                                  controller: numberController,
                                                  //initialValue: "1",
                                                  decoration: InputDecoration(
                                                    hintText: inventaires[index].newStock,
                                                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                                                  ),
                                                  keyboardType: TextInputType.number,
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
                                            String newStock;
                                            numberController.text.isEmpty
                                                ? newStock = inventaires[index].stock
                                                : newStock = numberController.text;
                                            FirebaseFirestore.instance
                                                .collection('inventaire')
                                                .doc(inventaires[index].documentID)
                                                .update({"newStock": newStock, 'userName' : currentUser.email}).then(
                                                    (value) => {
                                                  print("UPDATED")
                                                }).whenComplete(() {
                                              print("complete");
                                              Navigator.of(context).pop();
                                              setState(() {
                                              });
                                            });


                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                  else {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController numberController = new TextEditingController();
                                    return AlertDialog(
                                      title: Text('Voulez vous supprimer la régularisation suivante? '),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(' '),

                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  'D.Régularisation : ' + formattedDate,
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  ' ' + inventaires[index].name,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold),
                                                )),
                                            Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 10),
                                                child: TextFormField(
                                                  autofocus: true,
                                                  controller: numberController,
                                                  //initialValue: "1",
                                                  decoration: InputDecoration(
                                                    hintText: inventaires[index].newStock,
                                                    hintStyle: TextStyle(fontSize: 20.0, color: Colors.redAccent),

                                                  ),
                                                  keyboardType: TextInputType.number,
                                                )),
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
                                                    currentUser.password){
                                            fireStoreInstance

                                           // Firestore.instance
                                                .collection('inventaire')
                                                .doc(
                                                inventaires[index].documentID)
                                                .delete()
                                                .whenComplete(() {
                                              print("complete");
                                              Navigator.of(context).pop();
                                              setState(() {

                                              });
                                            });
                                            }
                                           },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },

                              background: Container(

                            // Show a red background as the item is swiped away.
                              padding: EdgeInsets.only(left: 5),
                              alignment: Alignment.centerLeft,
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.update,
                                color: Colors.green,
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
                                onTap: () {

                                },
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Row(
                                    children: <Widget>[
//                                      Expanded(
//                                          flex: 0,
//                                          child: Text(
//                                            formattedDate,
//                                            style: TextStyle(fontSize: 15),
//                                          )),
                                      Expanded(
                                          flex: 9,
                                          child: Text(
                                            inventaires[index].name,
                                            style: TextStyle(fontSize: 12, color: Colors.blue),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child:
                                              Text(inventaires[index].stock, style: TextStyle(fontSize: 12, color: Colors.green),)),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              inventaires[index].newStock, style: TextStyle(fontSize: 12, color: Colors.red),)),
                                      Expanded(
                                          flex: 2,
                                          child:
                                          inventaires[index].expdate != null ?Text(
                                            inventaires[index].expdate, style: TextStyle(fontSize: 12, color: Colors.blue),)
                                          : Text('')),
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            inventaires[index].userName != null ? inventaires[index].userName : '', style: TextStyle(fontSize: 8, color: Colors.red),)),
                                    ],
                                  ),
                                ),
                              ),
                            ));


                        // Container(child: Text(ventes[index].item.name),);
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

  String calculTotal() {
    return "";
  }
}
