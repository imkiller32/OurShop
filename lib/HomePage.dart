import 'package:SAK/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:SAK/ContactUs.dart';
// import 'package:SAK/Help.dart';
// import 'package:SAK/Setting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:backdrop/backdrop.dart';
import 'package:SAK/widgets/contact_us.dart';
import 'package:SAK/widgets/about_us.dart';

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
  QuerySnapshot schools, courses;
  FetchMethods fetchObj = FetchMethods();

  @override
  void initState() {
    super.initState();
    fetchObj.getSchoolData().then((results) {
      setState(() {
        schools = results;
        print("DoneSchools");
      });
    });
    fetchObj.getCoursesData().then((results) {
      setState(() {
        courses = results;
        print("DoneCourses");
      });
    });
  }

  int _currentIndex = 0;
  //List<Widget> _frontLayers = [hello(), ContactUs(), Help()];

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text('Sukhlal Adesh Kumar'),
      iconPosition: BackdropIconPosition.leading,
      headerHeight: 400.0,
      actions: (_currentIndex == 0 || _currentIndex == 3)
          ? <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      (_currentIndex == 0) ? schools = null : courses = null;
                    });
                    (_currentIndex == 0)
                        ? fetchObj.getSchoolData().then((results) {
                            setState(() {
                              schools = results;
                              print("DoneSchools");
                            });
                          })
                        : fetchObj.getCoursesData().then((results) {
                            setState(() {
                              courses = results;
                              print("DoneCourses2");
                            });
                          });
                  })
            ]
          : null,
      frontLayer: (_currentIndex == 0)
          ? schoolList()
          : (_currentIndex == 1)
              ? contactUs()
              : (_currentIndex == 2) ? aboutUs() : coursesList(),
      backLayer: BackdropNavigationBackLayer(
        items: [
          ListTile(
            title: Text(
              "View Schools",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.school,
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              "Contact Us",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.contacts,
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              "Help",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.help,
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              "Admin Pannel",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.verified_user,
              color: Colors.white,
            ),
          ),
        ],
        onTap: (int position) {
          setState(() {
            _currentIndex = position;
          });
        },
      ),
    );
  }

//School Widget
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

//End School Widget

//Admin Pannel

  Widget coursesList() {
    if (courses != null) {
      return ListView.builder(
          itemCount: courses.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            if (i == 5) {
              print(courses.documents[i]);
            }
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
                          courses.documents[i].data['Date'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          courses.documents[i].data['Name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          courses.documents[i].data['Class'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          courses.documents[i].data['Address'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          (courses.documents[i].data['PayOnline'])
                              ? "Payonline - Yes"
                              : "Payonline - No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (courses.documents[i].data['PayOnline'])
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                        IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () {
                              openUrl(
                                  'tel:' + courses.documents[i].data['Mobile'],
                                  'CallUS');
                            }),
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

//End Admin Pannel

}
