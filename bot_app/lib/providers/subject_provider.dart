import 'package:flutter/cupertino.dart';
import 'package:flutter_new/services/subject_service.dart';

class SubjectProvider extends ChangeNotifier {
  List subjectList = [];
  List get getSubjectList => subjectList;
  getSubjects(department, semester) async {
    subjectList = [];
    var response = await SubjectService().getSubjects(department, semester);
    subjectList = response['result'];
    notifyListeners();
  }
}
