import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:late_init/late_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'itemClient.dart';

class SendsmsClient extends StatefulWidget {
  @override
  _SendsmsClientState createState() => _SendsmsClientState();
}

class _SendsmsClientState extends State<SendsmsClient> {
  TextEditingController _controllerPeople = TextEditingController();
  TextEditingController _controllerMessage = TextEditingController();
  TextEditingController soldsmsController = TextEditingController();
  String _message, body;
  String _canSendSMSMessage = 'Check is not run.';
  List<String> people = [];
  bool loading = true;
  bool soldsms = false;
  List<ItemClient> listClient = new List();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    if (listClient.length == 0) {
      loadListclientphone();
    } else {
      loading = false;
    }
  }

  void loadListclientphone() async {
    // D'abort on charge la liste des stock
    final ref2 = FirebaseStorage.instance.ref().child('credit2.txt');
    final String url2 = await ref2.getDownloadURL();
    final Directory systemTempDir2 = Directory.systemTemp;
    final File tempFile2 = File('${systemTempDir2.path}/tmpscredit2.txt');
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    if (tempFile2.existsSync()) {
      await tempFile2.delete();
    }
    await tempFile2.create();
    assert(await tempFile2.readAsString() == "");
    await ref2.writeToFile(tempFile2);
    Uint8List contents2 = await tempFile2.readAsBytes();
    LineSplitter().convert(new String.fromCharCodes(contents2)).map((s) {
      if (s.split('\t').length > 5) {
        String code = s.split('\t').elementAt(0);
        String name1 = s.split('\t').elementAt(1);
        String phone1 = s.split('\t').elementAt(2);
        String creditMax = s.split('\t').elementAt(3);
        String solde = s.split('\t').elementAt(4);
        String phone = phone1.replaceAll("-", "");
        String name = name1.replaceAll("-", "");

        int intsolde =
            int.tryParse(solde.replaceAll(new RegExp(r"\s+"), "")) ?? 0;
        // if (phone.length > 0 &&  intsolde>1000000
        // ) {
        //   people.add(phone);
        //   print('phone');
        //   print(people.length);
        // }
        if (name.length > 0 &&
            intsolde > 1000000 &&
            phone != "" &&
            phone != null) {
          listClient.add(new ItemClient(code, name, solde, phone, creditMax));
        }
        print(listClient.length);
        print('sms');
      }
    }).toList();
    setState(() {
      loading = false;
    });
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  Future<void> _sendSMS() async {
    listClient.forEach((client) async {
      try {
        String _result = await sendSMS(
            message: _controllerMessage.text +' '+ client.solde,
            recipients: [client.phone]);
        setState(() => _message = _result);
      } catch (error) {
        setState(() => _message = error.toString());
      }
    });
  }

  Future<bool> _canSendSMS() async {
    bool _result = await canSendSMS();
    setState(() => _canSendSMSMessage =
        _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
    return _result;
  }

  Widget _phoneTile(ItemClient client) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
            top: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => listClient.remove(client)),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    client.name,
                    textScaleFactor: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    client.phone,
                    textScaleFactor: 1,
                    style: const TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMS/MMS Example'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
                width: 90,
                child: TextFormField(
                  autofocus: true,
                  controller: soldsmsController,
                  decoration: InputDecoration(
                    hintText: '0',
                  ),
                  keyboardType: TextInputType.number,
                  // Only numbers can be entered
                )),
            if (listClient == null || listClient.isEmpty)
              const SizedBox(height: 0)
            else
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List<Widget>.generate(listClient.length, (int index) {
                      return _phoneTile(listClient.elementAt(index));
                    }),
                  ),
                ),
              ),
            /*ListTile(
              leading: const Icon(Icons.people),
              title: TextField(
                controller: _controllerPeople,
                decoration:
                const InputDecoration(labelText: 'Add Phone Number'),
                keyboardType: TextInputType.number,
                onChanged: (String value) => setState(() {

                }),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _controllerPeople.text.isEmpty
                    ? null
                    : () => setState(() {
                  people.add(_controllerPeople.text.toString());
                  _controllerPeople.clear();
                }),
              ),
            ),*/
            // const Divider(),
            ListTile(
              leading: const Icon(Icons.message),
              title: TextField(
                decoration: const InputDecoration(labelText: 'Add Message'),
                controller: _controllerMessage,
                onChanged: (String value) => setState(() {}),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Can send SMS'),
              subtitle: Text(_canSendSMSMessage),
              trailing: IconButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                icon: const Icon(Icons.check),
                onPressed: () {
                  _canSendSMS();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).accentColor),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => const EdgeInsets.symmetric(vertical: 16)),
                ),
                onPressed: () {
                  _send();
                },
                child: Text(
                  'SEND',
                  style: Theme.of(context).accentTextTheme.button,
                ),
              ),
            ),
            Visibility(
              visible: _message != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _message ?? 'No Data',
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send() {
    if (listClient.isEmpty) {
      setState(() => _message = 'At Least 1 Person or Message Required');
    } else {
      _sendSMS();
    }
  }
}
