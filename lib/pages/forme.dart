import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detaiart.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:expopharma/pages/displayvene.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Forme extends StatefulWidget {
  final int idf ;
  final String  type ;
  Forme(this.idf, this.type);

  @override
  _FormeState createState() => _FormeState();
}

class _FormeState extends State<Forme> {
  List<Item> allArticle = [];
  List<Item> articles = [];
  bool addNewVente = false;
  List<Vente> listCommande = new List();
  int shopCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.type == "FORME"){
      getListByForme();
    }
    if(widget.type == "FAMILLE"){
      getListByFamille();
    }

  }

  @override
  Widget build(BuildContext context) {
 print(widget.idf.toString());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          brightness: Brightness.light,
          title: SizedBox(
              height: 37,
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                height: 37.0,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: TextField(
                    //expands: true,
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black26)),
                    onChanged: (value) {
                      if (value.length > 0) {
                        articles.clear();
                        getListArticles(value);
                      } else {
                        articles.clear();
                        setState(() {
                          articles.addAll(allArticle);
                        });
                      }
                    },
                  ),
                ),
              )),
          actions: [
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Builder(builder: (BuildContext context) {
                return Badge(
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  badgeContent: shopCount == 0
                      ? Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  )
                      : Text(
                    shopCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.blueAccent,
                      size: 35,
                    ),
                    onPressed: () async {
                      if (shopCount != 0) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DisplayVente(listCommande,shopCount)),
                        ).then((value) {
                          if(value == "SAVED"){
                            setState(() {
                              listCommande.clear();
                              shopCount = 0;
                            });
                          }
                        });
                      } else {
                        final snackBar = SnackBar(
                            content: Text(
                              ' Vente vide, veillez ajouter au moins un article',
                              textAlign: TextAlign.center,
                            ));
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                );
              }),
            ),
          ],
          backgroundColor: Colors.white,
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
        body: ListView.builder(

          itemCount: articles.length,
          itemBuilder: (context, index) {
            int nstock = int.tryParse(articles[index].stock) ?? 0;
            return Container(color: Colors.brown[200],
                child: InkWell(
                  child: Card(color: Colors.grey[300],
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                         color: Colors.grey[200],
                          width: 150,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon%2F'+articles[index].id+'.jpg?alt=media',
                            fit: BoxFit.fill,
                            height: 150,

                          ),
                        ),
                        Expanded(child:Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 15,),

                                Container(width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    color: Colors.blueGrey,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(fontSize: 15 ,color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: articles[index].name,
                                                style:TextStyle(color: Colors.white))
                                          ]
                                      ),
                                    )
                                ),
                                SizedBox(height: 10,),
                                Text('Prix:   '+
                                    articles[index].prixVente,
                                  style: TextStyle(color: Colors.blue, fontSize: 15),
                                ),
                                SizedBox(height: 5,),
                                Text(nstock <= 0 ? 'Non disponible' : 'Disponible',


                                  style: nstock <= 0 ? TextStyle(
                                     color: Colors.red, fontSize: 15) : TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                SizedBox(height: 15,),
                                Row(children: <Widget>[


                                  Expanded(child:Container(child: Text('Appuyer sur l\'image pour plus de detail'),) ),
                                  SizedBox(width: 20,),
                                  Container(
                                    height: 60,
                                    width: 70,

                                    child:RaisedButton(
                                      elevation: 10,
                                      color:
                                      Colors.redAccent[200],
                                        clipBehavior: Clip.none ,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 2),
                                      onPressed:(){
                                        _showMyDialog(context,articles.elementAt(index));
                                        //listCommande.add(new Vente(articles[index], 1));

                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Ajouter au panier',
                                            style: TextStyle(
                                                color: Colors.white, fontSize:10),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 20,
                                            margin: EdgeInsets.only(top: 0),
                                            padding: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    ),

                                ]),

                                SizedBox(height: 15,),
                              ]),
                        ),
                        ),

                      ])),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailArticl(articles[index])),

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
                      item.name,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                Row(children: [
                  Text('Valider '),
                  Text('1', style: TextStyle(color: Colors.red),),
                  Text(' ou choisir la quantité '),
                ],),
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: 90,
                            child:Column(children: <Widget>[
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

                            ],) ),
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
              child: Column(children: <Widget>[
                Text('VALIDER'),
              //  Text('Puis appuyer sur le panier pour enregister la commande')
              ],),
              onPressed: () {
                int value;
                numberController.text.isEmpty
                    ? value = 1
                    : value = int.parse(numberController.text);
                if (value != 0) {



                  listCommande.add(new Vente(item, value));
                  shopCount = shopCount + value;
                  shopCount == 0 ? addNewVente = false : addNewVente = true;
                  setState(() {
                    shopCount;
                    addNewVente;
                  });
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
      if(element.name.toLowerCase().startsWith(value.toLowerCase())){
        articles.add(element);
      }
    });
    setState(() {
    });
  }

  void getListByForme() {
    dataList.forEach((element) {
      if(element.forme == widget.idf.toString() && element.stock != 0){
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {
    });
  }

  void getListByFamille() {
    dataList.forEach((element) {
      if(element.forme == widget.idf.toString() && element.stock != 0){
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {
    });
  }
}


