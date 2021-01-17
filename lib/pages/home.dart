import 'package:expopharma/compount/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عرض لجميع مواد الصيدلية'),
          centerTitle: true,
          elevation: 5,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.deepPurple,
          titleSpacing: 1,
        ),
        drawer: MyDrawer(),
        body: ListView(

            children: <Widget>[
          Container(
            height: 180.0,
            width: double.infinity,
            child: Carousel(
              boxFit: BoxFit.fill,
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 3.0,
              dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.grey.withOpacity(0.4),
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 5.0,
              images: [
                // NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                // NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                // ExactAssetImage("assets/images/LaunchImage.jpg"),
                AssetImage(
                  'images/bv.jpg',
                ),
                AssetImage(
                  'images/cadu.jpg',
                ),
                AssetImage(
                  'images/ph.jpg',
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'المخابر',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            height: 150,
            width: 400,
            child: ListView(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  height: 120,
                  width: 120,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/avene.png', fit: BoxFit.fill,
                      height: 100,
                      // width:30,
                    ),
                    subtitle: Text(
                      'AVENE',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/acm.png',
                      fit: BoxFit.fill,
                      height: 100,
                      width: 80,
                    ),
                    subtitle: Text(
                      'ACM',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/bioderma.jfif',
                      fit: BoxFit.fill,
                      height: 100,
                      width: 80,
                    ),
                    subtitle: Text(
                      'BIODERMA',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/bo.jfif',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'BIO ORIENT',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/eye.png',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'EYE',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/filor.png',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'FILORGA',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/lrp.png',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'LA ROCHE POSAY',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/nature.jpg',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'NATURELAB',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/nore.jfif',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'NOREVA',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/nux.jfif',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'NUXE',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/pf.png',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'PIERRE FABRE',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/svr.png',
                      fit: BoxFit.fill,
                      height: 100,
                      width: 80,
                    ),
                    subtitle: Text(
                      'SVR',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                Container(
                  height: 120,
                  width: 100,
                  child: ListTile(
                    title: Image.asset(
                      'images/labo/vichy.jpg',
                      fit: BoxFit.fill,
                      height: 80,
                      width: 80,
                    ),
                    subtitle: Text(
                      'VICHY',
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ), //
                ), //

                //
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'اخر المنتجات',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              )),
          //start latest product
          Container(
            height: 200,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: <Widget>[
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avclex.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE TRIACNYL ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avcima.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE CICALFATE ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avclge.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE CLEANANCE GEL',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/aveath150.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE EAU THERMALE ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GridTile(
                  child: Image.asset(
                    'images/labo/avene/avecmi.jfif',
                  ),
                  footer: Container(
                    height: 25,
                    color: Colors.tealAccent,
                    child: Text(
                      'AVENE mineral cr SPF50 ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),//
          ),

          //end latest product
        ]),
      ),
    );
  }
}


