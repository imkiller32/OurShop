import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

class FetchMethods {
  getSchoolData() async {
    return await Firestore.instance.collection('schools').getDocuments();
  }

  getCoursesData() async {
    return await Firestore.instance.collection('courses').getDocuments();
  }

  Future<void> addData(courseData) async {
    Firestore.instance.collection('courses').add(courseData).catchError((e) {
      print(e);
    });
  }

  getHomeworkData(databaseReference) async {
    return await databaseReference.once();
  }

  getJsonData(String url) async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/csv"});
    print('hell' + response.toString());
    List<List<dynamic>> data =
        const CsvToListConverter().convert(response.body);
    return data;
  }
}
