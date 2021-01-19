import 'package:flutter/material.dart';

class DetailArt extends StatefulWidget {
  @override
  _DetailArtState createState() => _DetailArtState();
}

class _DetailArtState extends State<DetailArt> {
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
                child: Image.asset(
                  'images/labo/avene/avecmi.jfif',
                  fit: BoxFit.cover,
                ),
                footer: Container(
                    height: 80,
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Avene ecran mineral 50+',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            ' 48500 dt',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}
