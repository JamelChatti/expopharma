import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:flutter/material.dart';

class SearchArticleByForme extends StatefulWidget {
  final String forme;
  SearchArticleByForme(this.forme);
  @override
  _SearchArticleByFormeState createState() => _SearchArticleByFormeState();
}

class _SearchArticleByFormeState extends State<SearchArticleByForme> {

  List<Item> allArticle = [];
  List<Item> articles = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListByForme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          brightness: Brightness.light,
          title: SizedBox(
              height: 37,
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                height: 37.0,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: TextField(
                    //expands: true,
                    maxLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black26)),
                    onChanged: (value) {
                      if (value.length > 0) {
                        articles.clear();
                        getListArticles(value);
                      } else {
                        articles.clear();
                        setState(() {
                          articles.addAll(allArticle);
                        });
                      }
                    },
                  ),
                ),
              )),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                articles[index].name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ));
  }

  void getListArticles(String value) {
    allArticle.forEach((element) {
      if(element.name.toLowerCase().startsWith(value.toLowerCase())){
        articles.add(element);
      }
    });
    setState(() {
    });
  }

  void getListByForme() {
    dataList.forEach((element) {
      if(element.forme.toLowerCase() == widget.forme.toLowerCase()){
        allArticle.add(element);
      }
    });
    articles.addAll(allArticle);
    setState(() {
    });
  }
}
