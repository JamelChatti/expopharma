import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailArticl extends StatefulWidget {
  Item article;
  DetailArticl(this.article);
  String _selectedLocation = 'Please choose a location';


  @override
  _DetailArticlState createState() => _DetailArticlState();
}

class _DetailArticlState extends State<DetailArticl> {



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
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 350,
              child: GridTile(

                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon%2F'+widget.article.id+'.jpg?alt=media',
                  fit: BoxFit.fill,
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
              child: Text(
                'Caratéristiques' + 'الخصائص',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
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

