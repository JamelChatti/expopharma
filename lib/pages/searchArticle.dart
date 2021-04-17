import 'package:expopharma/pages/Item.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/detailArticle.dart';
import 'package:flutter/material.dart';

class SearchArticle extends StatefulWidget {
  @override
  _SearchArticleState createState() => _SearchArticleState();
}

class _SearchArticleState extends State<SearchArticle> {
  List<Item> articles = [];

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
                        setState(() {
                          articles.clear();
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
            Color color = index.isOdd
                ? Colors.grey[100]
                : Colors.blue[50];
            return
              GestureDetector(
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailArticl(articles.elementAt(index))),
              );
            },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  articles[index].name +
                      '\n' +
                      'Prix =' +
                      articles[index].prixVente,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            );
          },
        ));
  }

  void getListArticles(String value) {
    dataList.forEach((element) {
      if (element.name.toLowerCase().startsWith(value.toLowerCase())) {
        articles.add(element);
      }
    });
    setState(() {});
  }
}
