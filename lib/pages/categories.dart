import 'package:expopharma/compount/mydrawer.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ARTICLES'),
            centerTitle: true,
          ),
          drawer: MyDrawer(),
          body: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              InkWell(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Image.asset('images/labo/avene.png',
                              fit: BoxFit.fill)),
                      Container(
                          child: Text(
                        '',
                        style: TextStyle(fontSize: 20),
                      ))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('avene');
                },
              ),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/acm.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/bioderma.jfif',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/bo.jfif',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/eye.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/filor.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'FILORGA',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/lrp.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'LA ROCHE POSAY',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/nature.jpg',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'NATURE LAB',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/nore.jfif',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'NOREVA',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/nux.jfif',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'NUXE',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/pf.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          '',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/svr.png',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'SVR',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('svr');
                  }),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/uri.jpg',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'URIAGE',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Image.asset('images/labo/vichy.jpg',
                                fit: BoxFit.fill)),
                        Container(
                            child: Text(
                          'VICHY',
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('vichy');
                  }),
            ],
          ),
        ));
  }
}
