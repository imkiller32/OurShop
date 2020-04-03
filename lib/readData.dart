import 'package:cloud_firestore/cloud_firestore.dart';

class FetchMethods {
  getSchoolData() async {
    return await Firestore.instance.collection('schools').getDocuments();
  }

  getCoursesData() async {
    return await Firestore.instance.collection('courses').getDocuments();
  }
}
