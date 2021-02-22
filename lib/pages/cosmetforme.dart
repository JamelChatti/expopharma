import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detaiart.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CosmetForme extends StatefulWidget {
  final int idf ;
  final String  type ;
  CosmetForme(this.idf, this.type);

  @override
  _CosmetFormeState createState() => _CosmetFormeState();
}

class _CosmetFormeState extends State<CosmetForme> {
  List<Item> allArticle = [];
  List<Item> articles = [];


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

            //String imageURL = dataFormes.firstWhere((element) => (element.id.toString() == articles.elementAt(index).forme)).image;
            int nstock = int.tryParse(articles[index].stock) ?? 0;
            return Container(
                child: InkWell(
                  child: Card(
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 150,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon%2F'+articles[index].id+'.jpg?alt=media',
                            fit: BoxFit.cover,
                            height: 160,
                          ),
                        ),
                        Expanded(child:Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 15,),

                                Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.blue,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(fontSize: 15 ,color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(text: 'Desination: '),
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
                                SizedBox(height: 15,)
                              ]),
                        ) ),

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
