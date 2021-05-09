import 'package:expopharma/pages/ajoutsupprimeArtVitrine.dart';
import 'package:expopharma/pages/commandeAExecuter.dart';
import 'package:expopharma/pages/login.dart';
import 'package:expopharma/pages/maj%20article/majStockprix.dart';
import 'package:expopharma/pages/sospharma/login_page.dart';

import 'package:expopharma/pages/sospharma/sosPharma.dart';

//import 'file:///D:/jamel/expopharma/lib/pages/sospharma/login_page.dart';
import 'package:flutter/material.dart';

import '../pages/client.dart';




class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Column(
              children: <Widget>[
                Text(
                  'صيدلية جمال الشطي ',
                  style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/drawer.jpg',
                    ),
                    fit: BoxFit.fill)),
          ),
          ListTile(
            title: Text(
              'الصفحة الرئيسية',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic),
            ),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.hot_tub),
            subtitle: Text('لصفحة الرئيسية'),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'الاقسام',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.category,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('categories');
            },
          ),
          ListTile(
            title: Text(
              'طلبية Commande',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.add_shopping_cart_sharp,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommandeAExecuter()),

              );

            },
          ),
          Divider(
            color: Colors.lightBlueAccent,
            thickness: 2,
          ),
          ListTile(
            title: Text(
              'VITRINE',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AjousupArtvitrine()),
              );
            },
          ),
          // ListTile(
          //   title: Text(
          //     'ِCOMPTE CLIENT',
          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          //   ),
          //   leading: Icon(
          //     Icons.info_outline,
          //     color: Colors.blue,
          //     size: 20,
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Client()),
          //     );
          //   },
          // ),
          ListTile(
            title: Text(
              'الاعدادات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.local_florist,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {},
          ),

          ListTile(
            title: Text(
              'SOS PHARMA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.add_comment_sharp,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),

          ListTile(
            title: Text(
              'VENTE ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.add_comment_sharp,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SosPharma()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Mise à jour stock ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.add_comment_sharp,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MajStockprix()),
              );
            },
          ),
          ListTile(
            title: Text(
              'تسجيل صورة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('ajoutImage');
            },
          ),
          ListTile(
            title: Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
          ListTile(
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {},
          )
        ]));
  }}