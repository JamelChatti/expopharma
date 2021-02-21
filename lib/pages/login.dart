import 'package:expopharma/pages/client.dart';
import 'package:expopharma/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pharmexpo/Globals.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

showloading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              Text('loading...   '),
              CircularProgressIndicator(
                strokeWidth: 6,
              )
            ],
          ),
        );
      });
}


showloadingAll(context, String mytitle, String mycontent) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(mytitle),
          content: Text(mycontent),
          actions: <Widget>[
            FlatButton(
              child: Text('Terminé'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

class _LoginState extends State<Login> {
  // void initState() {
  //   super.initState();
  // }

  final _formkey = GlobalKey<FormState>();
  Pattern pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _codecontroller = TextEditingController();
  TextEditingController _datenaissancecontroller = TextEditingController();
  TextEditingController _telcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  String validglobal(String val) {
    if (val.isEmpty) {
      return 'le champ est vide';
    }
  }

  String validusername(String val) {
    if (val
        .trim()
        .isEmpty) {
      return 'le nom de l\'utilisateur ne peut pas être vide';
    }
    if (val
        .trim()
        .length < 4) {
      return 'le nombre de caractères ne peut pas être inferieur à 4';
    }
    if (val
        .trim()
        .length > 20) {
      return 'le nombre de caractères ne peut pas être supérieur à 20';
    }
  }

  String validpassword(String val) {
    if (val
        .trim()
        .isEmpty) {
      return 'le mot de passe ne peut pas être vide';
    }
    if (val
        .trim()
        .length < 4) {
      return 'le mot de passe ne peut pas être inferieur à 4';
    }
    if (val
        .trim()
        .length > 15) {
      return 'le nombre de caractères ne peut pas être supérieur à 20';
    }
  }

  String validconfirmpassword(String val) {
    if (val != _passwordcontroller.text) {
      return 'le mot de passe n\'est pas conforme ';
    }
  }

  String validemail(String val) {
    if (val
        .trim()
        .isEmpty) {
      return 'l\'email ne peut pas être vide';
    }
    if (val
        .trim()
        .length < 4) {
      return 'le nombre de caractères ne peut pas être inferieur à 4';
    }
    if (val
        .trim()
        .length > 20) {
      return 'le nombre de caractères ne peut pas être supérieur à 20';
    }
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(val)) {
      return 'email n\'est pas valid exemple:  foulen@gmail.com';
    }
  }

  signin() async {
    if (_formkey.currentState.validate()) {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passwordcontroller.text);

      if (result != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Client()),);
        print('مرحبا');
      } else {
        print("username not found");
        //showloadingAll(context, 'Erreur', 'l\'utilisateur n\'existe pas');
      }
    }
  }

  signup() async {
    if (_formkey.currentState.validate()) {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      if(result != null){
        print(result);
        final User user = result.user;
        var userinfo = await FirebaseFirestore.instance.collection('users').add({
       'email':user.email
        });
        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (context) => Login()),);
      }else{
        print('try later');
      }
    }

    // var formdata = formstatesignup.currentState;
    // if (formdata.validate()) {
    //   formdata.save();
    //   showloading(context);
    //   var data = {
    //     'email': email.text,
    //     'password': password.text,
    //     'username': username.text
    //   };
    //   var url = 'http://192.168.42.23/pharmexpo/signup.php';
    //   var response = await http.post(url, body: data);
    //   var responsebody = jsonDecode(response.body);
    //   if (responsebody['status'] == 'success') {
    //     print('yes success');
    //     Navigator.of(context).pushNamed('home');
    //   } else {
    //     print(responsebody['status']);
    //     Navigator.of(context).pop();
    //     showloadingAll(context, 'Erreur', 'l\'utilisateur existe déja');
    //   }
    // } else {
    //
    // }
  }

  TapGestureRecognizer _changesin;

  bool showsignin = true;

  @override
  void initState() {
    _changesin = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
          print(showsignin);
        });
      };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery
        .of(context)
        .size
        .width;
    var mdh = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
        appBar: AppBar(
          title:
          Text(showsignin
              ? 'Se connecter avec votre compte'
              : 'Creer un compte'),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            buildPositionedBottom(mdw, showsignin),
            buildPositionedTop(mdw, showsignin),
            Container(
              height: 1000,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: showsignin ? 50 : 10),
                        child: Text(
                          showsignin ? 'S\'identifier' : 'Creer un compte',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: showsignin ? 20 : 10),
                    ),
                    buildContainerAvatar(mdw),
                    showsignin
                        ? buildFormBoxSignIn(mdw, showsignin)
                        : buildFormBoxSignUp(mdw, showsignin),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(children: <Widget>[
                        SizedBox(height: showsignin ? 24 : 0),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            showsignin ? 'Mot de passe oublier' : '',
                            style: TextStyle(color: Colors.blue, fontSize: 17),
                          ),
                        ),
                        SizedBox(height: showsignin ? 24 : 0),
                        RaisedButton(
                          elevation: 10,
                          color:
                          showsignin ? Colors.blue : Colors.lightGreen[800],
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          onPressed: showsignin ? signin : signup,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                showsignin ? 'Entrer' : 'Creer un compte',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 390,
                          margin: EdgeInsets.only(
                              top: 20, bottom: 20),
                          padding: EdgeInsets.only(right: 3, left: 3),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black, fontSize: 17,),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: showsignin
                                          ? 'Si vous n\'avez pas de  compte '
                                          : 'Vous pouvez '),
                                  TextSpan(
                                      recognizer: _changesin,
                                      text: showsignin
                                          ? 'Taper ici'
                                          : 'Creer un compte ',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                        showsignin ?
                        Column(children: <Widget>[
                          Container(child: Text('Se connecter avec un compte:',
                            textAlign: TextAlign.center,),),
                          Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(7),),
                              Expanded(
                                child: (RaisedButton(
                                  elevation: 20,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.lightBlueAccent[100],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('images/rsocial/f.png',
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 150,),
                                      SizedBox(width: 10,),
                                    ],
                                  ),

                                  onPressed: () {},
                                )),
                              ),
                              Padding(padding: EdgeInsets.all(7),),
                              Expanded(
                                child: (RaisedButton(
                                  elevation: 20,
                                  padding: EdgeInsets.all(10),
                                  color: Colors.red[300],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('images/rsocial/g.png',
                                        fit: BoxFit.fill,
                                        height: 50,
                                        width: 150,),
                                      SizedBox(width: 10,),

                                    ],
                                  ),

                                  onPressed: () {},
                                )),
                              ),
                              Padding(padding: EdgeInsets.all(7),),
                            ],
                          ),
                        ],)
                            : Text('')

                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Positioned buildPositionedTop(double mdw, bool showsignin) {
    return Positioned(
        child: Transform.scale(
          scale: 1.3,
          child: Transform.translate(
            offset: Offset(0, -250),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 900),
              height: mdw,
              width: mdw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(mdw),
                  color: showsignin ? Colors.blueGrey : Colors.lime[600]),
            ),
          ),
        ));
  }

  Positioned buildPositionedBottom(double mdw, bool showsignin) {
    return Positioned(
      right: mdw / 1.5,
      top: 300,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        height: mdw,
        width: mdw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mdw),
            color: showsignin
                ? Colors.blue.withGreen(150).withOpacity(0.2)
                : Colors.brown.withOpacity(0.4)),
      ),
    );
  }

  AnimatedContainer buildContainerAvatar(double mdw) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 900),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: showsignin ? Colors.yellow : Colors.grey,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 6, spreadRadius: 3)
          ]),
      child: InkWell(
          onTap: () {
            setState(() {
              showsignin = !showsignin;
            });
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 15,
                right: 15,
                child: Icon(
                  Icons.person_outline,
                  size: 70,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 35,
                right: 5,
                child: Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }

  Center buildFormBoxSignIn(double mdw, bool showsignin) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInBack,
        margin: EdgeInsets.only(top: 30),
        height: 250,
        width: mdw / 1.2,
        decoration: BoxDecoration(
            color: showsignin ? Colors.white : Colors.blueGrey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  offset: Offset(3, 3))
            ]),
        child: Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(),

                    //debut nom utilisateur
                    Text(
                      'email de l\'utilisateur',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    buildTextFormFieldAll('entrer l\'email de l\'utilisateur',
                        false, _emailcontroller, validemail),

                    //fin nom utilisateur
                    SizedBox(
                      height: 15,
                    ),
                    //debut mdp
                    Text(
                      'Entrer le mot de passe',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    buildTextFormFieldAll(
                        'mot de passe', true, _passwordcontroller,
                        validpassword),
                    //fin mdp
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Center buildFormBoxSignUp(double mdw, bool showsignin) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        margin: EdgeInsets.only(top: 30),
        height: 410,
        width: mdw / 1.2,
        decoration: BoxDecoration(
            color: showsignin ? Colors.white : Colors.blueGrey[200],
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  offset: Offset(3, 3))
            ]),
        child: Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Center(
                           // child: MyStatefulWidget()
                        ),),
                      //debut nom utilisateur
                      Text(
                        'Nom de l\'utilisateur',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      // buildTextFormFieldAll('entrez le nom de l\'utilisateur',
                      //     false, username, validusername),

                      //fin nom utilisateur
                      SizedBox(
                        height: 10,
                      ),
                      //debut mdp
                      Text(
                        'Entrer le mot de passe',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      buildTextFormFieldAll(
                          'mot de passe', true, _passwordcontroller,
                          validpassword),

                      //fin mdp
                      SizedBox(
                        height: 10,
                      ),
                      //debut mdp
                      Text(
                        'Confirmer le mot de passe',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      buildTextFormFieldAll('confirmer le mot de passe', true,
                          _confirmpasswordcontroller, validconfirmpassword),

                      SizedBox(
                        height: 10,
                      ),
                      //debut mdp
                      Text(
                        'Entrer votre email',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      buildTextFormFieldAll(
                          'email', false, _emailcontroller, validemail)
                    ],
                  )),
            )),
      ),
    );
  }

  TextFormField buildTextFormFieldAll(String myhintText, bool pass,
      TextEditingController myController, myvalid) {
    return TextFormField(
      controller: myController,
      validator: myvalid,
      obscureText: pass,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          hintText: myhintText,
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[500], style: BorderStyle.solid, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 1))),
    );
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   MyStatefulWidget({Key key}) : super(key: key);
//
//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }
//
// /// This is the private State class that goes with MyStatefulWidget.
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   String dropdownValue = 'One';
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       height: 50,
//       decoration: BoxDecoration(
//         color: const Color(0xff7c94b6),
//
//         border: Border.all(
//           color: Colors.black,
//           width: 3,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: DropdownButton<String>(
//
//         value: dropdownValue,
//         icon: Icon(Icons.arrow_downward),
//         iconSize: 24,
//         elevation: 16,
//         style: TextStyle(color: Colors.deepPurple),
//         underline: Container(
//
//           height: 2,
//           decoration: BoxDecoration(border: Border(
//             top: BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
//             bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),)),
//           //color: Colors.deepPurpleAccent,
//         ),
//         onChanged: (String newValue) {
//           setState(() {
//             dropdownValue = newValue;
//           });
//         },
//         items: <String>['One', 'Two', 'Free', 'Four']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//
//
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
