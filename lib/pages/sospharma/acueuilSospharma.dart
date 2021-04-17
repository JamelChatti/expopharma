import 'package:expopharma/pages/sospharma/inventaireList.dart';
import 'package:expopharma/pages/sospharma/produitDemande.dart';
import 'package:expopharma/pages/sospharma/sosPharma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccueilSos extends StatefulWidget {
  @override
  _AccueilSosState createState() => _AccueilSosState();
}

class _AccueilSosState extends State<AccueilSos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('SOS PHARMA'),
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
                          width: 70,
                        ),
                        Text(
                          'Vente',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Icon(Icons.add_shopping_cart_sharp)
                      ],
                    )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => SosPharma()),
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
                            width: 50,
                          ),
                          Text('Inventaire', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 95,
                          ),
                          Icon(Icons.account_tree_rounded)
                        ],
                      )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => InventaireList()),
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
                        width: 30,
                      ),
                        Text('PRODUIT DEMANDE', style: TextStyle(fontSize: 20)),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(Icons.wifi_protected_setup_sharp)
                      ],
                    )),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => ProduitDemande()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
