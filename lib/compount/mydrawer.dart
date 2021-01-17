import 'package:flutter/material.dart';


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
            onTap: () {},
          ),
          Divider(
            color: Colors.lightBlueAccent,
            thickness: 2,
          ),
          ListTile(
            title: Text(
              'حول التطبيق',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            leading: Icon(
              Icons.info_outline,
              color: Colors.blue,
              size: 20,
            ),
            onTap: () {},
          ),
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