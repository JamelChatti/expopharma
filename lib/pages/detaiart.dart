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
              child:Column(children:<Widget> [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(children:<Widget> [
                Text('Designation:', style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Colors.blue),),
                  Text('Avene ecran mineral 50+', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      ),)

              ],),),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Row(children:<Widget> [
                    Text('Forme:', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        ),),
                    Text('creme', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),)

                  ],),),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(children:<Widget> [
                    Text('indication:', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Colors.blue),),
                    Text('ecran solaire', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),)

                  ],),),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                    Text('Mode d\'utilisation:', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        ),),
                      Text('renouveler frequem.', style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          ),),


                  ],),),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(children:<Widget> [
                    Text('Propriétes', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Colors.blue),),
                    Text('ecran solaire', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),)

                  ],),),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Row(children:<Widget> [
                    Text('Contenance', style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        ),),
                    Text('50ml', style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                    ),)

                  ],),),

            ],)
              //fin colonne caratcteristique
              ,),
          ],
        ));
  }
}
