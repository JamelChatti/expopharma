import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/forme.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expopharma/pages/shoppingCard.dart';

import 'package:expopharma/pages/ItemForme.dart';

class DetailArticl extends StatefulWidget {
  Item article;

  DetailArticl(this.article);

  String _selectedLocation = 'Please choose a location';

  @override
  _DetailArticlState createState() => _DetailArticlState();
}

class _DetailArticlState extends State<DetailArticl> {
  List<Vente> listCommande = new List();
  List<ItemForme> formes = [];
  List<Item> articles = [];

  String result;
  bool hasData=false ;

  Future<bool> checkEmptyMethod() async {
    hasData = await FirebaseFirestore.instance
        .collection("commandeClient").snapshots().isEmpty;

    print(hasData);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkEmptyMethod();

    // getListByidf();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('commandeClient').snapshots().isEmpty;
    return Scaffold(
        appBar: AppBar(
          title: Text('Description' + 'التفاصيل'),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 20,
            ),
            MyShoppingCard("commandeClient"),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchArticle()),
                );
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 600,
              child: GridTile(
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/articles%2F' +
                      widget.article.id +
                      '.png?alt=media',
                  fit: BoxFit.contain,
                  height: 160,
                ),
                footer: Container(
                    height: 40,
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              widget.article.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Prix: ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.article.prixVente,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                ' dt',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Caratéristiques' + 'الخصائص',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    hasData
                        ? Container(
                      height: 60,
                      width: 70,
                      child: RaisedButton(
                        elevation: 10,
                        color: Colors.redAccent[200],
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.symmetric(
                            vertical: 1, horizontal: 2),
                        onPressed: () {
                          _showMyDialog(context, widget.article);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Ajouter au panier',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              margin: EdgeInsets.only(top: 0),
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                        : Column(
                      children: <Widget>[
                        Text('Le panier n\'est pas vide'),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 90,
                              child: RaisedButton(
                                elevation: 10,
                                color: Colors.green,
                                clipBehavior: Clip.none,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 2),
                                onPressed: () {
                                  _showMyDialog(context, widget.article);

                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Ajouter d\'autres articles',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(top: 0),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 60,
                              width: 70,
                              child: RaisedButton(
                                elevation: 10,
                                color: Colors.green,
                                clipBehavior: Clip.none,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 2),
                                onPressed: () {
                                  showMyDialogViderpanier(context, widget.article);
                                  setState(() {
                                    hasData=true;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Vider le panier ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(top: 0),
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),


                  ],
                )),
            //debut colonne caratcteristique

            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'Designation: ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                          )),
                      TextSpan(
                          text: widget.article.name,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                          ))
                    ])),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        //  mySpec(context, 'Indication:',widget.indication_d,Colors.white,Colors.blue),
                      ],
                    ),
                  ),
                ],
              )
              //fin colonne caratcteristique
              ,
            ),
          ],
        ));
  }


  Future<void> _showMyDialog(BuildContext context, Item item) async {
    TextEditingController numberController = new TextEditingController();

    var expression = RegExp('([-]?)([0-9]+)');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter au panier'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      item.name,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: <Widget>[
                    Text('Valider '),
                    Text(
                      '1',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(' ou choisir la quantité '),
                  ],
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 90,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              autofocus: true,
                              controller: numberController,
                              //initialValue: "1",
                              decoration: InputDecoration(
                                hintText: '1',
                                helperText: 'différent de 0',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                //WhitelistingTextInputFormatter.digitsOnly
                                FilteringTextInputFormatter.allow(expression)
                              ], // Only numbers can be entered
                            ),
                          ],
                        )),
                    Text(''),
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
              child: Column(
                children: <Widget>[
                  Text('VALIDER'),
                  //  Text('Puis appuyer sur le panier pour enregister la commande')
                ],
              ),
              onPressed: () async {
                int value;
                numberController.text.isEmpty
                    ? value = 1
                    : value = int.parse(numberController.text);
                if (value != 0) {
                  Vente vente = new Vente(item, value);
                  await FirebaseFirestore.instance
                      .collection('commandeClient')
                      .add({
                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                    // 'vente' : vente.toMap(),
                    'name': item.name,
                    'number': vente.number,
                    'prixVente': item.prixVente,
                  });
                  Navigator.of(context).pop();
                  setState(() {
                    hasData=false;
                  });
                } else {}
              },
            ),
          ],
        );
      },
    );
  }


Future<void> showMyDialogViderpanier(BuildContext context, Item item) async {
  TextEditingController numberController = new TextEditingController();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Vider le panier'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          width: 90,
                          child: Column(
                            children: <Widget>[

                            ],
                          )),
                      Text(''),
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
            child: Column(
              children: <Widget>[
                Text('VALIDER'),
                //  Text('Puis appuyer sur le panier pour enregister la commande')
              ],
            ),
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection("commandeClient")
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  FirebaseFirestore.instance
                      .collection("commandeClient")
                      .doc(element.id)
                      .delete()
                      .then((value) {
                    setState(() {
                      hasData=true;
                    });
                    print(hasData);
                    Navigator.of(context).pop();
                  });
                });
              });
            },
          ),
        ],
      );
    },
  );
}

  }





// mySpec(context,String feature,String detail, Color colorbackground, Color colortext){
//  return Container(
//       width: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.all(10),
//     color: colorbackground,
//     child: RichText(
//         text: TextSpan(
//             style: TextStyle(fontSize: 19 ,color: Colors.black),
//           children: <TextSpan>[
//             TextSpan(text: feature),
//             TextSpan(
//                 text: detail,
//                 style:TextStyle(color: colortext))
//            ]
//        ),
//       )
//    );
// }