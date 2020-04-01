import 'package:cloud_firestore/cloud_firestore.dart';

class FetchMethods {
  getData() async {
    return await Firestore.instance.collection('schools').getDocuments();
  }
}