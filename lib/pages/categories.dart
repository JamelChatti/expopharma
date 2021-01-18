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
          body: Container(
            child: Text('Bonjour'),
          ),
        ));
  }
}
