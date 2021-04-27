import 'package:expopharma/pages/ajoutsupprimeArtVitrine.dart';
import 'package:expopharma/pages/ajoutArtVitrine.dart';
import 'package:flutter/material.dart';


class Vitrine extends StatefulWidget {
  @override
  _VitrineState createState() => _VitrineState();
}

class _VitrineState extends State<Vitrine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('VITRINE'),
        centerTitle: true,
        actions: <Widget>[
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: SizedBox(
                height: 70,
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Ajouter un article à la vitrine',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                                              ],
                    )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => AjoutArticlevitrine()),
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
                child: SizedBox(
                  height: 70,
                  child: Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 1,
                          ),
                          Text('Supprimer un article de la vitrine', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 1,
                          ),

                        ],
                      )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => AjousupArtvitrine()),
                  );
                }),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              child: SizedBox(
                height: 70,
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: Row(
                      children: [ SizedBox(
                        width: 100,
                      ),
                        Text('Quitter', style: TextStyle(fontSize: 20)),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(Icons.wifi_protected_setup_sharp)
                      ],
                    )),
              ),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        ),
      ),
    );
  }
}
