import 'dart:convert';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detaiart.dart';
import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
//import 'package:pharmexpo/pages/detailArticl.dart';

class ArticleList extends StatelessWidget {

  ArticleList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Articles et disponibilité'),
        ),

        body:
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return MyArticle(dataList.elementAt(index));
      },
    ),)
    );
  }
}


class MyArticle extends StatefulWidget {
  final Item item;

  MyArticle(this.item);

  @override
  _MyArticleState createState() => _MyArticleState();
}

class _MyArticleState extends State<MyArticle> {
  Item myItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myItem = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    int stockint = myItem.stock!= null?  int.parse(myItem.stock.replaceAll(new RegExp(r"\s+"), "")) : 0;
    return Container(
        child: InkWell(
            child: Card(
              child: Row(children: <Widget>[
                  Container(
                  padding: EdgeInsets.all(10),
                  width: 150,
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/flutter-with-firebase-99891.appspot.com/o/ESOCARE_7_gelules_20mg.jpg?alt=media',
                    fit: BoxFit.cover,
                    height: 160,
                  ),
                ),
            Expanded(child:Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),

                    SizedBox(height: 5,),
                    Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.blue,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 15 ,color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: 'Desination: '),
                                TextSpan(
                                    text: myItem.name,
                                    style:TextStyle(color: Colors.white))
                              ]
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Text('Prix:   '+
                        myItem.prixVente.toString(),
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      stockint <= 0 ? 'Non disponible' : 'disponible',
                      style: stockint <= 0 ? TextStyle(
                          color: Colors.red, fontSize: 15) : TextStyle(
                          color: Colors.green, fontSize: 15),
                    ),
                    SizedBox(height: 15,)
                  ]),
            ) ),

        ])),
    onTap: () {
    },
    )
    //Text(myItem.name)
    );
  }
}
