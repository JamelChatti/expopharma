import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

class Test extends StatefulWidget {


  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Future getData() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: FutureBuilder(
         future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context ,i){
                return Container(
                  child: Text(snapshot.data[i]['title'],),
                  //  child: Text(snapshot.data[i]['nom'],),
                );
              });
            }
            return Center(child: Container(child:
            CircularProgressIndicator(
              backgroundColor: Colors.red,
              strokeWidth: (5),
            ),
              height: 150.0,
              width: 200.0,

            ));
          },
        ));
  }
}
