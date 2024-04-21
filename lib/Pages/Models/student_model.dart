import 'dart:collection';
import 'dart:core';

import 'package:flutter/cupertino.dart';

class StudentModel extends ChangeNotifier {
  String _education = "";
  String _email = "";
  String _name = "";
  String _phone_number = "";
  String _uid = "";
  List _Courses = [];

  setData(String education, String email, String name, String phone_number,
      String uid, List Courses) {
    _education = education;
    _email = email;
    _name = name;
    _phone_number = phone_number;
    _uid = uid;
    _Courses = Courses;
    notifyListeners();
  }

  UnmodifiableListView get education_detail =>
      UnmodifiableListView([_education]);
  UnmodifiableListView get email_detail => UnmodifiableListView([_email]);
  UnmodifiableListView get name_detail => UnmodifiableListView([_name]);
  UnmodifiableListView get uid_detail => UnmodifiableListView([_uid]);
  UnmodifiableListView get course_detail => UnmodifiableListView(_Courses);
  UnmodifiableListView get phone_number =>
      UnmodifiableListView([_phone_number]);

  updateName(String name) {
    _name = name;
    notifyListeners();
  }

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  updatePhoneNumber(String phone_number) {
    _phone_number = phone_number;
    notifyListeners();
  }

  updateEducation(String education) {
    _education = education;
    notifyListeners();
  }

  updateCourses(Map course_data) {
    _Courses.add(course_data);
    notifyListeners();
  }
}
