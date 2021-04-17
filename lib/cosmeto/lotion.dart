import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/material.dart';

class ParfumForme extends StatefulWidget {
  final String forme;
  ParfumForme(this.forme);
  @override
  _ParfumFormeState createState() => _ParfumFormeState();
}

class _ParfumFormeState extends State<ParfumForme> {

  List<Item> allArticle = [];
  List<Item> articles = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListByForme();
  }

  @override
  Widget build(BuildContext context) {

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
            return Container(
                child: InkWell(
                  child: Card(
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          width: 150,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/flutter-with-firebase-99891.appspot.com/o/deo.jfif?alt=media',
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
                                Text(
                                  articles[index].stock,
                                  style: TextStyle(color: Colors.blue, fontSize: 15),

                                  // stockint <= 0 ? 'Non disponible' : 'disponible',
                                  // style: stockint <= 0 ? TextStyle(
                                  //     color: Colors.red, fontSize: 15) : TextStyle(
                                  //     color: Colors.green, fontSize: 15),
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
      if(element.forme.toLowerCase() == widget.forme.toLowerCase()){
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {
    });
  }
}
