import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<Null> openUrl(link, name) async {
  if (await url_launcher.canLaunch(link)) {
    await url_launcher.launch(link);
  }
}

final email = 'adeshkumar.apr@gmail.com';
final subject = 'Re:Customer v1.0.0';
final body = "";
Widget contactUs() {
  return SingleChildScrollView(
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Connect',
              style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            FlatButton(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.mail, color: Colors.red[200]),
                    Text(
                      '   Email Us',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
              },
            ),
            Divider(
              height: 3.0,
            ),
            FlatButton(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.phone, color: Colors.blue),
                    Text(
                      '   Call',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                openUrl('tel:9319731498', 'CallUS');
              },
            ),
            Divider(
              height: 3.0,
            ),
            FlatButton(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.feedback, color: Colors.grey),
                    Text(
                      '   Feedback',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                openUrl('mailto:$email?subject=$subject&body=$body', 'Email');
              },
            ),
            Divider(
              height: 3.0,
            ),
            FlatButton(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Colors.green),
                    Text(
                      '   Location',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                openUrl('https://goo.gl/maps/sHtqMxLDJfL2aHcw7',
                    'SukhlalAdeshKumar');
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 35.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'We are always here for you !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
