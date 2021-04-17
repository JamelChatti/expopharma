import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expopharma/pages/data.dart';
import 'package:expopharma/pages/sospharma/acueuilSospharma.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController myTextFieldController;
  TextEditingController myPasswordController;

  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myTextFieldController = new TextEditingController();
    myPasswordController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          child: SingleChildScrollView(
            child:Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                "La pharmacie, plus facile..",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/icon/icon.jpg'),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              SizedBox(height: 50),



              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: TextFormField(
                  controller: myTextFieldController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      helperText: 'Veillez introduire votre email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              showPassword
                  ? Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: TextFormField(
                        controller: myPasswordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.only(right: 40),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Builder(
                    builder: (context) => RaisedButton(
                    textColor: Colors.white,
                    color: Color(0xFF6200EE),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('sosUsers')
                          .where('email', isEqualTo: myTextFieldController.text)
                          .snapshots()
                          .forEach((data) {
                        data.docs.forEach((doc) {
                          print(doc.id);
                          currentUser.email = doc["email"];
                          currentUser.isAdmin = doc["isAdmin"];
                          currentUser.isActive = doc["isActive"];
                          currentUser.password = doc["password"];
                        });
              if (currentUser.email != null && currentUser.email.isNotEmpty) {
                          if (currentUser.isAdmin) {
                            if(showPassword==true){
                              if(myPasswordController.text == currentUser.password){

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AccueilSos()),
                                );

                              } else {
                                final snackBar = SnackBar(
                                    content: Text(
                                      ' Mot de passe icorrecte..',
                                    ));
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            } else {
                              setState(() {
                                showPassword = true;
                              });
                            }
                          } else {
                            if(currentUser.isActive){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AccueilSos()),
                              );
                            } else {
                              final snackBar = SnackBar(
                                  content: Text(
                                    ' Votre compte n\'est pas activé. Veillez contacter l\'administrateur' ,
                                  ));
                              Scaffold.of(context).showSnackBar(snackBar);
                            }

                          }
                        } else {
                          final snackBar = SnackBar(
                              content: Text(
                                ' Email incorrecte, veillez vérifier votre saisie..',
                              ));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }).whenComplete(() {
                        print("whenComplete");
                      });
                    },
                    child: Text('Login'),
                  )),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
