import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/commandeClient.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/displayvene.dart';
import 'package:expopharma/pages/searchArticle.dart';
import 'package:expopharma/pages/vente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expopharma/pages/shoppingCard.dart';

class DetailArticl extends StatefulWidget {
  Item article;
  DetailArticl(this.article);
  String _selectedLocation = 'Please choose a location';


  @override
  _DetailArticlState createState() => _DetailArticlState();
}

class _DetailArticlState extends State<DetailArticl> {
  int shopCount = 0;
  List<Vente> listCommande = new List();
  bool addNewVente = false;
  List<Item> articles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  // getListByidf();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Description' + 'التفاصيل'),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 20,
            ),
        // Padding(
        //     padding: EdgeInsets.only(right: 5),
        //     child: StreamBuilder(
        //         stream: FirebaseFirestore.instance
        //             .collection('ventes')
        //             .snapshots(),
        //         builder: (context, snapshot) {
        //           QuerySnapshot values = snapshot.data;
        //           //print(values.size);
        //           return Badge(
        //             position: BadgePosition.topEnd(
        //               top: 10,
        //               end: 30,
        //             ),
        //             badgeContent: values !=null && values.size == 0
        //                 ? Text(
        //               '',
        //               style: TextStyle(color: Colors.white),
        //             )
        //                 : Text(
        //               values.size.toString(),
        //               style:
        //               TextStyle(color: Colors.white, fontSize: 7),
        //             ),
        //             child: IconButton(
        //               icon: Icon(
        //                 Icons.add_shopping_cart,
        //                 color: Colors.white,
        //                 size: 20,
        //               ),
        //               onPressed: () async {
        //                 if (values.size != 0) {
        //                   await Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => CommandeClient()),
        //                   ).then((value) {
        //                     //  if(value == "SAVED"){
        //                     setState(() {
        //                       //  listCommande.clear();
        //                       // shopCount = 0;
        //                     });
        //                     //}
        //                   });
        //                 } else {
        //                   final snackBar = SnackBar(
        //                       content: Text(
        //                         ' Vente vide, veillez ajouter au moins un article',
        //                         textAlign: TextAlign.center,
        //                       ));
        //                   Scaffold.of(context).showSnackBar(snackBar);
        //                 }
        //               },
        //             ),
        //           );
        //         })),
        //     Padding(
        //       padding: EdgeInsets.only(right: 15),
        //       child: Builder(builder: (BuildContext context) {
        //         return Badge(
        //           position: BadgePosition.topEnd(top: 0, end: 0),
        //           badgeContent: shopCount == 0
        //               ? Text(
        //             '',
        //             style: TextStyle(color: Colors.white),
        //           )
        //               : Text(
        //             shopCount.toString(),
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           child: IconButton(
        //             icon: Icon(
        //               Icons.add_shopping_cart,
        //               color: Colors.white,
        //               size: 35,
        //             ),
        //             onPressed: () async {
        //               if (shopCount != 0) {
        //                 await Navigator.push(
        //                   context,
        //                   MaterialPageRoute(builder: (context) => DisplayVente()),
        //                 ).then((value) {
        //                   if(value == "SAVED"){
        //                     setState(() {
        //                       listCommande.clear();
        //                       shopCount = 0;
        //                     });
        //                   }
        //                 });
        //               } else {
        //                 final snackBar = SnackBar(
        //                     content: Text(
        //                       ' Vente vide, veillez ajouter au moins un article',
        //                       textAlign: TextAlign.center,
        //                     ));
        //                 Scaffold.of(context).showSnackBar(snackBar);
        //               }
        //             },
        //           ),
        //         );
        //       }),
        //     ),
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
                  'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/articles%2F'+widget.article.id+'?alt=media',
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
              child: Row(children: <Widget>[
                Text(
                  'Caratéristiques' + 'الخصائص',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(width: 50,),
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
                      print('bonjour');
                      _showMyDialog(context,widget.article);
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
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),

                ),
              ],)

            ),
            //debut colonne caratcteristique

            Container(
              padding: EdgeInsets.all(10),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: RichText(text: TextSpan(children: <TextSpan>[
                      TextSpan(text: 'Designation: ', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 17,
                      )),
                      TextSpan(text:widget.article.name, style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 17,
                      ) )
                    ])),
                  ),

                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   padding: EdgeInsets.all(10),
                  //   color: Colors.blue,
                  //   child:
                  //   RichText(text: TextSpan(children: <TextSpan>[
                  //     TextSpan(text: 'Prix:', style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       fontSize: 15,
                  //     )),
                  //     TextSpan(text:' 48500 dt', style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       fontSize: 15,
                  //     ) )
                  //   ])),
                  // ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child:Column(
                      children: <Widget>[
                      //  mySpec(context, 'Indication:',widget.indication_d,Colors.white,Colors.blue),



                      ],
                    )
                    ,),
                ],)
              //fin colonne caratcteristique
              ,),
          ],
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
              onPressed: () async {
                int value;
                numberController.text.isEmpty
                    ? value = 1
                    : value = int.parse(numberController.text);
                if (value != 0)  {
                  Vente vente = new Vente(item, value);
                  await FirebaseFirestore.instance.collection('commandeClient').add({
                    'timestamp': DateTime.now().millisecondsSinceEpoch,
                    // 'vente' : vente.toMap(),
                    'name' : item.name,
                    'number' :vente.number,
                    'prixVente' : item.prixVente,
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


}
mySpec(context,String feature,String detail, Color colorbackground, Color colortext){
  return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      color: colorbackground,
      child: RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 19 ,color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: feature),
              TextSpan(
                  text: detail,
                  style:TextStyle(color: colortext))
            ]
        ),
      )
  );




}

