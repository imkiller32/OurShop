import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<Null> openUrl(link, name) async {
  if (await url_launcher.canLaunch(link)) {
    await url_launcher.launch(link);
  }
}

Widget aboutUs() {
  return SingleChildScrollView(
      child: Container(
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sukhlal Adesh Kumar, Book Seller',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hastinapur Road, Mawana - 250401',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.blue,
                    size: 50.0,
                  ),
                  onPressed: () {
                    openUrl('tel: 9319731498', 'CallUS');
                  }),
            ],
          ),
          Padding(padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Developed By- Ritesh Aggarwal',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,),
              ),
            ],
          ),
        ],
      ),
    ),
  ));
}
