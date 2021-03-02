import 'dart:collection';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/home.dart';
import 'package:expopharma/pages/itemVente.dart';
import 'package:expopharma/pages/listeVente.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


class DisplayVente extends StatefulWidget {
  int shopCount ;
  List<Vente> listCommande;
  DisplayVente(this.listCommande,this.shopCount);

  @override
  _DisplayVenteState createState() => _DisplayVenteState();
}

class _DisplayVenteState extends State<DisplayVente> {
  final fireStoreInstance = FirebaseFirestore.instance;

  TextEditingController myTextFieldController;



  HashMap<String, String> stockMap = new HashMap();
  String nameclient;

  List<Item> displayedList = new List();

  bool loading = true;

  List<Vente> listVentes = new List();

  bool addNewVente = false;
  TextEditingController nameclientController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop("NOTSAVED");
                },
              ),

            ),
            body:
            Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        color: Colors.green[50],
                        child: Padding(
                            padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      "DESIGNATION",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "PRIX",
                                      style: TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    )),

                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "QTE",
                                      style: TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    )),

                              ],
                            ))),
                    Expanded(flex: 6,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.listCommande.length,
                          itemBuilder: (BuildContext context, int itemIndex) {

                            Vente vente = widget.listCommande.elementAt(itemIndex);


                            Color color =
                            itemIndex.isOdd ? Colors.grey[100] : Colors.blue[50];
                            return  Column(children: <Widget>[

                              SizedBox(height: 15,),


                              Padding(
                              padding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
                              child: GestureDetector(
                                  onLongPress: () {
                                    showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Suppression'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(
                                                      'Voulez vous supprimer ce médicament de la vente ? '),
                                                  Padding(
                                                      padding:
                                                      EdgeInsets.only(bottom: 10),
                                                      child: Text(
                                                       vente.item.name,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight: FontWeight.bold),
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
                                                  widget.shopCount = widget.shopCount -
                                                      vente.number;
                                                  widget.listCommande.removeAt(itemIndex);

                                                  widget.shopCount == 0 ? addNewVente = false : true ;
                                                  setState(() {
                                                    widget.shopCount;
                                                    addNewVente;
                                                  });

                                                  Navigator.of(context).pop();

                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                      height: 70,
                                      color: color,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 5,
                                              child: Text(
                                                vente.item.name,
                                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                               vente.item.prixVente,
                                                style: TextStyle(
                                                    fontSize: 14, color: Colors.green),
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                vente.number.toString(),
                                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                              )),
                                        ],
                                      ))),
                            ) ],) ;
                          },
                        )),
                   Expanded(flex: 1,
                       child:Container(
                       color: Colors.green[50],
                       child: Padding(
                           padding: EdgeInsets.only(left: 10, top: 20, bottom: 15),
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                   flex: 11,
                                   child: Text(
                                     "TOTAL",
                                     style: TextStyle(fontWeight: FontWeight.bold),
                                     textAlign: TextAlign.start,
                                   )),
                               Expanded(
                                   flex: 4,
                                   child: Text(
                                     getSomme(),
                                     style: TextStyle(
                                         fontSize: 18,
                                         color: Colors.red,
                                         fontWeight: FontWeight.bold),
                                     textAlign: TextAlign.start,
                                   )),
                               Expanded(
                                   flex: 3,
                                   child: Text(
                                     getQuantite(),
                                     style: TextStyle(
                                         fontSize: 18, fontWeight: FontWeight.bold),
                                     textAlign: TextAlign.start,
                                   )),
                             ],
                           ))) ),
                    Expanded(flex:1,
                    child: Container(child: TextFormField(

                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                      ],
                      autofocus: true,
                      controller: nameclientController,
                      //initialValue: "1",
                      decoration: InputDecoration(
                        hintText: 'Tappez votre nom',
                      ),
                    ),),
                    ),
                    Expanded(flex: 1,
                      child:
                   ButtonTheme(

                       minWidth: MediaQuery.of(context).size.width,
                       child: RaisedButton(
                     child: Text(
                         'Validez votre achat',style: TextStyle(fontSize: 20),
                     ),
                     onPressed: () {
                       // ListVente myList = new ListVente(listVentes, null, null);
                       String name;
                       nameclientController.text.isEmpty
                           ? name = 'Inconnu'
                           : name = nameclientController.text ;
                       fireStoreInstance.collection("ventes").add({
                         'vente': widget.listCommande.map((i) => i.toMap()).toList(),
                         'timestamp': DateTime.now().millisecondsSinceEpoch,
                         'nameclient': name,
                       }).then((value) {
                         showDialog<void>(
                             context: context,
                             barrierDismissible: false,
                             // user must tap button!
                             builder: (BuildContext context) {
                               return AlertDialog(
                                 title: Text('شكرا على ثقتكم الكريمة Merci pour votre confiance'),
                                 content: SingleChildScrollView(
                                   child: ListBody(
                                     children: <Widget>[
                                       Text(
                                           'يمكنكم تسلم طلبيتكم Demandez votre commande à la caisse '),
                                     ],
                                   ),
                                 ),
                                 actions: <Widget>[
                                   FlatButton(
                                     child: Text('OK'),
                                     onPressed: () {

                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (context) => Home()),

                                       );

                                     },
                                   ),
                                 ],
                               );
                             });

                       }
                       );

                      },
                   ),)
            )
                  ],
                )),
          );
        }

  Future<void> _showMyDialog(BuildContext context, ItemVente item) async {
    TextEditingController nameclientController = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter au panier'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: 90,
                            child:Column(children: <Widget>[
                              TextFormField(
                                inputFormatters: [
                                  new LengthLimitingTextInputFormatter(10),
                                ],
                                autofocus: true,
                                controller: nameclientController,
                                //initialValue: "1",
                                decoration: InputDecoration(
                                  hintText: 'Tappez votre nom',
                                ),
                                // keyboardType: TextInputType.number,
                                // inputFormatters: <TextInputFormatter>[
                                //   //WhitelistingTextInputFormatter.digitsOnly
                                //   FilteringTextInputFormatter.allow(expression)
                                // ], // Only numbers can be entered
                              )
                            ],) ),
                      ],
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
              child: Column(children: <Widget>[
                Text('VALIDER'),
                //  Text('Puis appuyer sur le panier pour enregister la commande')
              ],),
              onPressed: () {
                String value1;
                  nameclientController.text.isEmpty
                      ? value1 = 'Inconnu'
                      : value1 = nameclientController.text ;
        fireStoreInstance.collection("ventes").add({
        'vente': widget.listCommande.map((i) => i.toMap()).toList(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
         'nameclient':value1,
        }).then((value) {
                  Navigator.of(context).pop();
                });
              }
            ),
          ],
        );
      },
    );
  }


String getSomme() {
  int somme = 0;
  widget.listCommande.forEach((element) {
    somme = somme +
        (int.parse(
            element.item.prixVente.replaceAll(new RegExp(r"\s+"), "")) *
            element.number);
  });
  return somme.toString();
}

String getQuantite() {
  int quantite = 0;
  widget.listCommande.forEach((element) {
    quantite = quantite + element.number;
  });
  return quantite.toString();
}

@override
bool get wantKeepAlive => true;


}



