import 'dart:collection';

import 'package:SAK/readData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:SAK/ContactUs.dart';
// import 'package:SAK/Help.dart';
// import 'package:SAK/Setting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:backdrop/backdrop.dart';
import 'package:SAK/widgets/contact_us.dart';
import 'package:SAK/widgets/about_us.dart';
import 'package:firebase_database/firebase_database.dart';

Future<Null> openUrl(link, name) async {
  if (await url_launcher.canLaunch(link)) {
    await url_launcher.launch(link);
  }
}

void showDes(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String validateName(String value) {
  if (value.isEmpty) return 'Name is required';
  final RegExp nameExp = RegExp(r'^[A-Za-z]+$');
  if (!nameExp.hasMatch(value)) return 'Enter Only Alphabetical characters';
  return null;
}

Future<void> _neverSatisfied(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Request Result'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Your Request Successfully Submitted'),
              Text('We will contact You soon.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Home'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuerySnapshot schools, courses;
  DataSnapshot homework;
  FetchMethods fetchObj = FetchMethods();

  String name;
  String mobile;
  String address;
  int _radVal = 0;
  String selectedClass;
  String selectedClass_for_homework = 'All';
  String selectSection = 'All';
  String selectedSubjects = 'All';
  String selectedLocation;
  String paymentMode;

  final databaseReference = FirebaseDatabase.instance.reference();

  static const classesList = <String>[
    'All',
    'Nur',
    'LKG',
    'UKG',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10th',
    '11th',
    '12th',
  ];

  static const locationList = <String>['Mawana', 'Other'];

  static const paymentList = <String>['Online', 'Other'];

  static const subjectList = <String>[
    'All',
    'SST',
    'Science',
    'Hindi',
    'English',
    'Maths',
    'E.V.S',
    'Life Skill',
    'G.K',
  ];

  static const sectionList = <String>['All', 'A', 'B'];

  final List<DropdownMenuItem<String>> _dropdownItems_class = classesList
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<DropdownMenuItem<String>> _dropdownItems_location = locationList
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<DropdownMenuItem<String>> _dropdownItems_payment = paymentList
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<DropdownMenuItem<String>> _dropdownItems_subjects = subjectList
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  final List<DropdownMenuItem<String>> _dropdownItems_sections = sectionList
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

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
    fetchObj.getHomeworkData(databaseReference).then((results) {
      setState(() {
        homework = results;
        print('DoneHomeWork');
      });
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      title: Text('Sukhlal Adesh Kumar'),
      iconPosition: BackdropIconPosition.leading,
      headerHeight: 200.0,
      actions: (_currentIndex == 0 || _currentIndex == 3)
          ? <Widget>[
              IconButton(
                  icon: (_currentIndex == 0)
                      ? Icon(
                          Icons.refresh,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                  onPressed: () {
                    setState(() {
                      (_currentIndex == 0) ? schools = null : homework = null;
                    });
                    (_currentIndex == 0)
                        ? fetchObj.getSchoolData().then((results) {
                            setState(() {
                              schools = results;
                              print("DoneSchools");
                            });
                          })
                        : setState(() {
                            _currentIndex = 5;
                          });
                  })
            ]
          : null,
      frontLayer: (_currentIndex == 0)
          ? schoolList()
          : (_currentIndex == 1)
              ? contactUs()
              : (_currentIndex == 2)
                  ? aboutUs()
                  : (_currentIndex == 3)
                      ? homeWork()
                      : (_currentIndex == 4) ? requestCourse() : filterWork(),
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
          // ListTile(
          //   title: Text(
          //     "Admin Pannel",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   leading: Icon(
          //     Icons.verified_user,
          //     color: Colors.white,
          //   ),
          // ),
          ListTile(
            title: Text(
              "Homework Section",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              "Request Course",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(
              Icons.file_upload,
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
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            OutlineButton(
                                child: Text("Book List"),
                                onPressed: () {
                                  openUrl(schools.documents[i].data['BookList'],
                                      schools.documents[i].data['Name']);
                                }),
                            OutlineButton(
                                child: Text("More Info"), onPressed: null),
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

//Homework Section

  Widget homeWork() {
    int len = 0;
    List<Map<String, String>> filteredData = [];
    if (homework != null) {
      for (var value in homework.value['homework']) {
        if (selectedSubjects != "All" && value['Subject'] != selectedSubjects) {
          continue;
        } else if (selectedClass_for_homework != "All" &&
            value['Class'] != selectedClass_for_homework) {
          continue;
        } else if (selectSection != "All" &&
            value['Section'] != selectSection) {
          continue;
        } else {
          len = len + 1;
          Map<String, String> temp = {
            'Class': value['Class'],
            'Subject': value['Subject'],
            'Section': value['Section'],
            'Name': value['Name'],
            'FatherName': value['FatherName'],
            'UploadYourHomework': value['UploadYourHomework'],
            'Timestamp': value['Timestamp']
          };
          filteredData.add(temp);
        }
      }
      showDes(len.toString() + " Entries Found");
    }

    if (homework != null && len == 0) {
      return Center(
        child: Text("No Enteries Found"),
      );
    } else if (homework == null) {
      return SpinKitThreeBounce(
        color: Colors.blue,
        size: 25,
      );
    } else {
      return ListView.builder(
          itemCount: len,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            return Container(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                          "Date - " + filteredData[i]['Timestamp'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          "Name - " + filteredData[i]['Name'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          "Class - " + filteredData[i]['Class'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Section - " + filteredData[i]['Section'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          "Father's Name - " +
                              filteredData[i]['FatherName'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          "Subject - " + filteredData[i]['Subject'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                        Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          height: 50 *
                              filteredData[i]['UploadYourHomework']
                                  .toString()
                                  .split(',')
                                  .length
                                  .toDouble(),
                          child: ListView.builder(
                            //shrinkWrap: true,
                            itemCount: filteredData[i]['UploadYourHomework']
                                .toString()
                                .split(',')
                                .length,
                            itemBuilder: (context, j) {
                              return RaisedButton(
                                onPressed: () {
                                  openUrl(
                                      filteredData[i]['UploadYourHomework']
                                          .toString()
                                          .split(', ')[j],
                                      filteredData[i]['Name'].toString());
                                },
                                color: Colors.white,
                                child: Text("Open Image " + (j + 1).toString()),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: Colors.blue)),
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0)),
                      ],
                    ),
                  )),
            );
          });
    }
  }

//End of Homework Section

//Admin Pannel

  Widget coursesList() {
    if (courses != null) {
      return ListView.builder(
          itemCount: courses.documents.length,
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context, i) {
            return Container(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                          (courses.documents[i].data['Address'] == "")
                              ? courses.documents[i].data['Address']
                              : "NONE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0)),
                        Text(
                          (courses.documents[i].data['PayOnline'] == "Online")
                              ? "Payonline - Yes"
                              : "Payonline - No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (courses.documents[i].data['PayOnline'] ==
                                      "Online")
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

// Filter Form

  Widget filterWork() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
            ),
            Text(
              'Filter',
              style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
            ),
            ListTile(
              title: Text("Select Class:"),
              trailing: DropdownButton(
                  value: this.selectedClass_for_homework,
                  hint: Text('Choose'),
                  items: this._dropdownItems_class,
                  onChanged: (String value) {
                    setState(() {
                      this.selectedClass_for_homework = value;
                    });
                  }),
            ),
            ListTile(
              title: Text("Select Section:"),
              trailing: DropdownButton(
                  value: this.selectSection,
                  hint: Text('Choose'),
                  items: this._dropdownItems_sections,
                  onChanged: (String value) {
                    setState(() {
                      this.selectSection = value;
                    });
                  }),
            ),
            ListTile(
              title: Text("Select Subject:"),
              trailing: DropdownButton(
                  value: this.selectedSubjects,
                  hint: Text('Choose'),
                  items: this._dropdownItems_subjects,
                  onChanged: (String value) {
                    setState(() {
                      this.selectedSubjects = value;
                    });
                  }),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    homework = null;
                    _currentIndex = 3;
                  });
                  fetchObj.getHomeworkData(databaseReference).then((results) {
                    setState(() {
                      homework = results;
                      print('DoneHomeWorkFilter');
                    });
                  });
                },
                color: Colors.white,
                child: Text("Apply"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.blue)),
              ),
            ),
          ]),
    );
  }

//End Form

//Form
  Widget requestCourse() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *'),
            onChanged: (String value) {
              setState(() {
                this.name = value;
              });
            },
            validator: validateName,
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.phone),
              hintText: ' Where can we reach you?',
              labelText: 'Phone *',
              prefixText: '+91',
            ),
            keyboardType: TextInputType.phone,
            onChanged: (String value) {
              setState(() {
                this.mobile = value;
              });
            },
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [0, 1, 2]
                .map((int index) => Radio<int>(
                    value: index,
                    groupValue: this._radVal,
                    onChanged: (int value) {
                      setState(() {
                        this._radVal = value;
                      });
                    }))
                .toList(),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("S.D.P.S"),
              Text("U.P.S"),
              Text("I.P.S"),
            ],
          ),
          SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: Text("Select Class:"),
            trailing: DropdownButton(
                value: this.selectedClass,
                hint: Text('Choose'),
                items: this._dropdownItems_class,
                onChanged: (String value) {
                  setState(() {
                    this.selectedClass = value;
                  });
                }),
          ),
          ListTile(
            title: Text("Select Location:"),
            trailing: DropdownButton(
                value: this.selectedLocation,
                hint: Text('Choose'),
                items: this._dropdownItems_location,
                onChanged: (String value) {
                  setState(() {
                    this.selectedLocation = value;
                  });
                }),
          ),
          ListTile(
            title: Text("Select Payment Mode:"),
            trailing: DropdownButton(
                value: this.paymentMode,
                hint: Text('Choose'),
                items: this._dropdownItems_payment,
                onChanged: (String value) {
                  setState(() {
                    this.paymentMode = value;
                  });
                }),
          ),
          SizedBox(
            height: 24.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Your Address',
                labelText: 'Enter Your Address'),
            maxLines: 2,
            onChanged: (String value) {
              setState(() {
                this.address = value;
              });
            },
          ),
          ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
            OutlineButton(
              onPressed: () {
                Map<String, dynamic> requestCourseData = {
                  'Date': DateTime.now().toString(),
                  'Name': this.name,
                  'Class': this.selectedClass,
                  'Mobile': this.mobile,
                  'Location': this.selectedLocation,
                  'Address': this.address,
                  'PayOnline': this.paymentMode
                };
                fetchObj.addData(requestCourseData).then((result) {
                  _neverSatisfied(context);
                }).catchError((e) {
                  showDes(e);
                });
                showDes("Successfully Submitted");
                setState(() {
                  _currentIndex = 0;
                });
              },
              child: Text("Submit"),
            ),
          ]),
        ],
      ),
    );
  }
//End Form
}
