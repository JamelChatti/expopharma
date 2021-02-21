import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/cosmeto/deo.dart';
import 'package:expopharma/pages/ItemForme.dart';
import 'package:expopharma/pages/cosmetforme.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Cosmeto extends StatefulWidget {
  @override
  _CosmetoState createState() => _CosmetoState();
}

class _CosmetoState extends State<Cosmeto> {
  List<ItemForme> formes = [];
  final fireStoreInstance = FirebaseFirestore.instance.collection('forme');


  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   myTextFieldController = new TextEditingController();
  // }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Cosmétique'),
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[300],
          child: StreamBuilder(
              stream: fireStoreInstance
                  .orderBy('name')
                  .snapshots(),
              builder: (context, dataSnapshot) {
                if (dataSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (dataSnapshot.hasData) {
                  dataSnapshot.data.docs.forEach((result) {
                    int id = result["id"];
                    String name = result["name"];
                    String image = result["image"];
                    ItemForme itemForme = new ItemForme(id, name, image);
                    formes.add(itemForme);
                  });
                  dataFormes.addAll(formes);
                  return
                    GridView.builder(
                      itemCount: formes.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                         // crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (context, i) {
                        return new Card(
                          child: InkWell(child: new GridTile(
                            footer: new Text(formes.elementAt(i).name,style: TextStyle(fontSize: 15,color: Colors.blue, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                            child: Image.network(
                              // 'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon.jfif?alt=media',
                              'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/' + formes.elementAt(i).image + '?alt=media',
                              fit: BoxFit.cover,
                              height: 160,
                            ),
                            //just for testing, will fill with image later

                          ) ,
                          onTap: (){
                            Navigator.push(
                              context,
                             MaterialPageRoute(builder: (context) => CosmetForme( formes.elementAt(i).id)),

                            );
                          },
                          )

                        );
                      },

                    );

                  //   ListView.builder(
                  //   itemCount: formes.length,
                  //   itemBuilder: (context, i) {
                  //     return Container(
                  //         child: InkWell(
                  //           child: Card(
                  //               child: Row(children: <Widget>[
                  //                 Container(
                  //                   padding: EdgeInsets.all(10),
                  //                   width: 150,
                  //                   child: Image.network(
                  //                     // 'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/savon.jfif?alt=media',
                  //                     'https://firebasestorage.googleapis.com/v0/b/expopharma-20c26.appspot.com/o/' + formes.elementAt(i).image + '?alt=media',
                  //                     fit: BoxFit.cover,
                  //                     height: 160,
                  //                   ),
                  //                 ),
                  //                 Expanded(child: Container(
                  //                   child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment
                  //                           .start,
                  //                       children: <Widget>[
                  //                         SizedBox(height: 15,),
                  //
                  //                         SizedBox(height: 5,),
                  //                         Container(
                  //                             padding: EdgeInsets.all(10),
                  //                             color: Colors.blue,
                  //                             child: RichText(
                  //                               text: TextSpan(
                  //                                   style: TextStyle(
                  //                                       fontSize: 15,
                  //                                       color: Colors.black),
                  //                                   children: <TextSpan>[
                  //                                     TextSpan(
                  //                                         text: 'Desination: '),
                  //                                     TextSpan(
                  //                                         text: formes.elementAt(i).name,
                  //                                         style: TextStyle(
                  //                                             color: Colors
                  //                                                 .white))
                  //                                   ]
                  //                               ),
                  //                             )
                  //                         ),
                  //                         SizedBox(height: 10,),
                  //                         Text(formes.elementAt(i).id.toString(),
                  //                           style: TextStyle(
                  //                               color: Colors.blue,
                  //                               fontSize: 15),
                  //                         ),
                  //                       ]),
                  //                 )),
                  //
                  //               ])),
                  //           onTap: () {},
                  //         )
                  //       //Text(myItem.name)
                  //     );
                  //   },
                  // );
                }
              }
          )),

    );
  }

}
