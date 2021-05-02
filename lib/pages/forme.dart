import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/commandeAExecuter.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detaiart.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:expopharma/pages/displayvente.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:expopharma/pages/shoppingCard.dart';

class Forme extends StatefulWidget {
  final String idf;
  Item article;
  final String type;
  final String name;

  Forme(this.idf, this.type, this.name);

  @override
  _FormeState createState() => _FormeState();
}

class _FormeState extends State<Forme> {
  List<Item> allArticle = [];
  List<Item> articles = [];

  // bool addNewVente = false;
  List<Vente> listCommande = new List();
  bool empty = false;
  bool checkBoxValue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == "FORME") {
      getListByForme();
    }
    if (widget.type == "FAMILLE") {
      getListByFamille();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idf.toString());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 15),
          ),
          elevation: 0.5,
          brightness: Brightness.light,
          toolbarHeight: 100,
          actions: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new Checkbox(
                      value: checkBoxValue,
                      activeColor: Colors.green,
                      onChanged: (bool newValue) {
                        setState(() {
                          checkBoxValue = newValue;
                        });
                        Text('Remember me');
                      }),
                ],
              ),
            ),
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
          // title: Text(
          //   'Chercher un article',
          //   style: TextStyle(color: Colors.white),
          // ),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2.0, crossAxisCount: 1),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            if (checkBoxValue == false) {
              articles.sort((a, b) => a.dateExp == null
                  ? 1
                  : b.dateExp == null
                      ? -1
                      : a.dateExp.compareTo(b.dateExp));
            } else {
              articles.sort((a, b) => a.name.compareTo(b.name));

            }
            int nstock = int.tryParse(articles[index].stock) ?? 0;
            return Container(
                color: Colors.grey[200],
                child: InkWell(
                  child: Card(
                      color: Colors.grey[300],
                      child: Container(
                          height: 2000,
                          child: Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[200],
                              width: 150,
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/articles%2F' +
                                    articles[index].id +
                                    '.png?alt=media',
                                fit: BoxFit.fill,
                                height: 150,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(10),
                                          color: Colors.blueGrey,
                                          child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          articles[index].name,
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                ]),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              'Prix: ' +
                                                  articles[index].prixVente,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Disponible',
                                              style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                        'commandeClient')
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  String result;
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    result = "";
                                                  } else if (snapshot
                                                      .hasError) {
                                                    result = "";
                                                  } else if (snapshot.hasData) {
                                                    QuerySnapshot values =
                                                        snapshot.data;
                                                    if (values != null) {
                                                      result = snapshot
                                                          .data.size
                                                          .toString();
                                                    } else {
                                                      result = "";
                                                    }

                                                    if (snapshot.data.size ==
                                                        0) {
                                                      empty = true;
                                                    } else {
                                                      empty = false;
                                                    }
                                                    print(empty);
                                                  }
                                                  return Row(
                                                    children: <Widget>[
                                                      empty
                                                          ? Row(
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  width: 50,
                                                                  child:
                                                                      RaisedButton(
                                                                    elevation:
                                                                        10,
                                                                    color: Colors
                                                                            .blueAccent[
                                                                        200],
                                                                    clipBehavior:
                                                                        Clip.none,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            1,
                                                                        horizontal:
                                                                            2),
                                                                    onPressed:
                                                                        () {
                                                                      _showMyDialog(
                                                                          context,
                                                                          widget
                                                                              .article);
                                                                      print(
                                                                          empty);
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          'Ajouter au panier',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 10),
                                                                        ),
                                                                        // Container(
                                                                        //   height:
                                                                        //       20,
                                                                        //   width:
                                                                        //       20,
                                                                        //   margin:
                                                                        //       EdgeInsets.only(top: 0),
                                                                        //   padding:
                                                                        //       EdgeInsets.only(left: 10),
                                                                          // child:
                                                                          //     Icon(
                                                                          //   Icons.arrow_forward,
                                                                          //   color:
                                                                          //       Colors.white,
                                                                          //   size:
                                                                          //       25,
                                                                          // ),
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                    'Le panier n\'est pas vide'),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      height:
                                                                          40,
                                                                      width: 50,
                                                                      child:
                                                                          RaisedButton(
                                                                        elevation:
                                                                            10,
                                                                        color: Colors
                                                                            .green,
                                                                        clipBehavior:
                                                                            Clip.none,
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1,
                                                                            horizontal:
                                                                                2),
                                                                        onPressed:
                                                                            () {
                                                                          _showMyDialog(
                                                                              context,
                                                                              widget.article);
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              'Ajouter au panier',
                                                                              style: TextStyle(color: Colors.white, fontSize: 10),
                                                                            ),
                                                                            // Container(
                                                                            //   height: 20,
                                                                            //   width: 20,
                                                                            //   margin: EdgeInsets.only(top: 0),
                                                                            //   padding: EdgeInsets.only(left: 10),
                                                                            //   child: Icon(
                                                                            //     Icons.arrow_forward,
                                                                            //     color: Colors.white,
                                                                            //     size: 25,
                                                                            //   ),
                                                                            //)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          45,
                                                                      width: 65,
                                                                      child:
                                                                          RaisedButton(
                                                                        elevation:
                                                                            10,
                                                                        color: Colors
                                                                            .green,
                                                                        clipBehavior:
                                                                            Clip.none,
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                1,
                                                                            horizontal:
                                                                                2),
                                                                        onPressed:
                                                                            () {
                                                                          showMyDialogViderpanier(
                                                                              context,
                                                                              widget.article);
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              'Confirmer ou annuler la commande ',
                                                                              style: TextStyle(color: Colors.white, fontSize: 10),
                                                                            ),
                                                                            // Container(
                                                                            //   height: 20,
                                                                            //   width: 20,
                                                                            //   margin: EdgeInsets.only(top: 0),
                                                                            //   padding: EdgeInsets.only(left: 10),
                                                                            //   child: Icon(
                                                                            //     Icons.arrow_forward,
                                                                            //     color: Colors.white,
                                                                            //     size: 25,
                                                                            //   ),
                                                                            // )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                    ],
                                                  );
//
                                                }))
                                      ]),
                                      Row(children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          child: Text(
                                            'Appuyer sur l\'image pour plus de detail',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        // Container(
                                        //   height: 60,
                                        //   width: 70,
                                        //   child: RaisedButton(
                                        //     elevation: 10,
                                        //     color: Colors.redAccent[200],
                                        //     clipBehavior: Clip.none,
                                        //     padding: EdgeInsets.symmetric(
                                        //         vertical: 1, horizontal: 2),
                                        //     onPressed: () {
                                        //       _showMyDialog(context,
                                        //           articles.elementAt(index));
                                        //       //listCommande.add(new Vente(articles[index], 1));
                                        //     },
                                        //     child: Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: <Widget>[
                                        //         Text(
                                        //           'Ajouter au panier',
                                        //           style: TextStyle(
                                        //               color: Colors.white,
                                        //               fontSize: 10),
                                        //         ),
                                        //         Container(
                                        //           height: 20,
                                        //           width: 20,
                                        //           margin:
                                        //               EdgeInsets.only(top: 0),
                                        //           padding:
                                        //               EdgeInsets.only(left: 10),
                                        //           child: Icon(
                                        //             Icons.add_shopping_cart,
                                        //             color: Colors.white,
                                        //             size: 25,
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ]),
                              ),
                            ),
                          ]))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailArticl(articles[index])),
                    );
                  },
                )
                //Text(myItem.name)
                );

            //   ListTile(
            //   title: Text(
            //     articles[index].name,
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // );
          },
        ));
  }

  Future<void> showMyDialogViderpanier(BuildContext context, Item item) async {
    TextEditingController numberController = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
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
                          children: <Widget>[],
                        )),
                    Text(''),
                  ],
                )),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 60,
                width: 250,
                child: RaisedButton(
                  child: Text('Confirmer la commande',
                      style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayVente()));
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: SizedBox(
                width: 250,
                height: 60,
                child: RaisedButton(
                  child: Text('Retour', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: SizedBox(
                height: 60,
                width: 250,
                child: RaisedButton(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Annuler la commande',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.end,
                      ),
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
                            empty = true;
                          });
                          print(empty);
                          Navigator.of(context).pop();
                        });
                      });
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context, Item item) async {
    TextEditingController numberController = new TextEditingController();
    TextEditingController nameclientController = new TextEditingController();

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
                      articles.last.name,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                Row(
                  children: [
                    //   Text('Valider '),
                    //Text('0', style: TextStyle(color: Colors.red),),
                    Text(' Saisir la quantité '),
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
                                hintText: '0',
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
                  //Vente vente = new Vente(item, value);
                  await FirebaseFirestore.instance
                      .collection('commandeClient')
                      .add({
                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                    // 'vente' : vente.toMap(),
                    'name': articles.last.name,
                    'number': int.parse(numberController.text),
                    'prixVente': articles.last.prixVente,
                  });

                  //  listCommande.add(new Vente(item, value));
                  // shopCount = shopCount + value;
                  // shopCount == 0 ? addNewVente = false : addNewVente = true;
                  // setState(() {
                  //   shopCount;
                  //   addNewVente;
                  // });
                  Navigator.of(context).pop();
                } else {}
              },
            ),
          ],
        );
      },
    );
  }

  void getListArticles(String value) {
    articles.clear();
    allArticle.forEach((element) {
      if (element.name.toLowerCase().startsWith(value.toLowerCase())) {
        articles.add(element);
      }
    });
    setState(() {});
  }

  void getListByForme() {
    dataList.forEach((element) {
      if (element.forme == widget.idf.toString() && element.stock != 0) {
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {});
  }

  void getListByFamille() {
    dataList.forEach((element) {
      if (element.forme == widget.idf.toString() && element.stock != 0) {
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {});
  }
}
