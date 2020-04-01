import 'package:SAK/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SAK/ContactUs.dart';
import 'package:SAK/Help.dart';
import 'package:SAK/Setting.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<Null> openUrl(link, name) async {
  if (await url_launcher.canLaunch(link)) {
    await url_launcher.launch(link);
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FetchMethods fetchObj = FetchMethods();
  QuerySnapshot schools;
  void jump(String value) {
    switch (value) {
      case 'contactUs':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactUs()),
        );
        break;
      case 'help':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Help()),
        );
        break;
      case 'setting':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchObj.getData().then((results) {
      setState(() {
        schools = results;
        print("DoneRitesh");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sukhlal Adesh Kumar",
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        Text('  Settings'),
                      ],
                    ),
                    value: 'setting',
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.contacts,
                          color: Colors.black,
                        ),
                        Text('  Contact Us'),
                      ],
                    ),
                    value: 'contactUs',
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                        Text('  Help'),
                      ],
                    ),
                    value: 'help',
                  ),
                ];
              },
              onSelected: jump,
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Schools We Surve - ",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Divider(
                  height: 15.0,
                  thickness: 3.0,
                  color: Colors.blue,
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Text(
                        'Spring Dales Public School, Mawana (MEERUT)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              openUrl(
                                  'https://drive.google.com/open?id=1tAh577FUFmYiL07GURRxoeuvVgixSHyM',
                                  "SDPS");
                            },
                            child: Text(
                              "Book List",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Text(
                        'Uttam Public School, Rahawati (MEERUT)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              openUrl(
                                  'https://drive.google.com/open?id=18-ZroSY6tYypYeBb2sdQ9FSQIhYggE_N',
                                  "UTTAM");
                            },
                            child: Text(
                              "Book List",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Text(
                        'Indira Public School, Mawana (MEERUT)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              openUrl(
                                  'https://drive.google.com/open?id=1z298CHh_iiKikPfdEZ8I8TzQDtyXGsSq',
                                  "Indira");
                            },
                            child: Text(
                              "Book List",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
