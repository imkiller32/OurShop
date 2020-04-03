import 'package:flutter/material.dart';

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
                  'Coming Soon with more features !',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }