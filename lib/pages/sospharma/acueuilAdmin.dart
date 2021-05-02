import 'package:expopharma/pages/sospharma/admin.dart';
import 'package:expopharma/pages/sospharma/inventaireList.dart';
import 'package:expopharma/pages/sospharma/produitDemande.dart';
import 'package:expopharma/pages/sospharma/sosPharma.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccueilAdmin extends StatefulWidget {
  @override
  _AccueilAdminState createState() => _AccueilAdminState();
}

class _AccueilAdminState extends State<AccueilAdmin> {
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
                          'VENTE',
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
                          Text('INVENTAIRE', style: TextStyle(fontSize: 20)),
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
                            width: 20,
                          ),
                          Text('ADMIN', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 180,
                          ),
                          Icon(Icons.assignment)
                        ],
                      )),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => AdminPage()),
                  );
                }),

          ],
        ),
      ),
    );
  }
}
