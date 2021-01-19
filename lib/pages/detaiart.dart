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
                    TextSpan(text:'Avene ecran mineral 50+', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Forme: ', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    )),
                    TextSpan(text:'crème', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    ) )
                  ])),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'indication: ', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    )),
                    TextSpan(text:'ecran solaire', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    ) )
                  ])),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                 TextSpan(text: 'Mode d\'utilisation:', style: TextStyle(color: Colors.black,
                   decoration: TextDecoration.underline,
                   fontSize: 15,
                 )),
                    TextSpan(text:' renouveler frequemment l\'application.', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                  ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Propriétes: ', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    )),
                    TextSpan(text:'Très haute protection solaire de la peau intolérante du visage.Très résistant à l\'eau Très large protection UVB-UVA Photostable', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 17,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Laboratoire:', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' Avene', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Tableau:', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' non', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Contre indication', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' ', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Effets indesirables:', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' ', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Femme enceinte et allaittement:', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' ', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Remboursable par CNAM:', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' non', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Catégories:', style: TextStyle(color: Colors.black,
                      fontSize: 15,
                    )),
                    TextSpan(text:' AMC', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'DCI:', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' ', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Contenance:', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' 50ml', style: TextStyle(color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: RichText(text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Prix:', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    )),
                    TextSpan(text:' 48500 dt', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ) )
                  ])),
                ),
            ],)
              //fin colonne caratcteristique
              ,),
          ],
        ));
  }
}
