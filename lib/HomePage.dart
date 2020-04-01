import 'package:SAK/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SAK/ContactUs.dart';
import 'package:SAK/Help.dart';
import 'package:SAK/Setting.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              Icon(Icons.book),
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0)),
              Text(
                "Sukhlal Adesh Kumar",
                style: TextStyle(fontSize: 19.0),
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
        floatingActionButton: (schools != null)
            ? FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    schools = null;
                  });
                  fetchObj.getData().then((results) {
                    setState(() {
                      schools = results;
                      print("DoneRitesh");
                    });
                  });
                })
            : null,
        body: schoolList());
  }

  Widget schoolList() {
    if (schools != null) {
      return ListView.builder(
          itemCount: schools.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            return Container(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                        Text(
                          schools.documents[i].data['Name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          schools.documents[i].data['Location'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text("Book List"),
                                onPressed: () {
                                  openUrl(schools.documents[i].data['BookList'],
                                      schools.documents[i].data['Name']);
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                            ),
                            RaisedButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                child: Text("More Info"),
                                onPressed: () {
                                  openUrl(schools.documents[i].data['BookList'],
                                      schools.documents[i].data['Name']);
                                }),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      ],
                    ),
                  )),
            );
          });
    } else {
      return SpinKitThreeBounce(
        color: Colors.blue,
        size: 25,
      );
    }
  }
}
