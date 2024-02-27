import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String uid = "";
  String _student_name = "";
  String _student_email = "";
  String _student_education = "";
  String _student_phoneNumber = "";
  List _courses_Enrolled = [];

  User() {
    _student_name = "";
    _student_email = "";
    _student_education = "";
    _student_phoneNumber = "";
    _courses_Enrolled = [];
  }

  setStudentData(
      {uid = "",
      student_name = "",
      student_email = "",
      student_education = "",
      student_phoneNumber = ""}) {
    this.uid = uid;
    this._student_name = student_name;
    this._student_education = student_education;
    this._student_email = student_email;
    this._student_phoneNumber = student_phoneNumber;
  }

  final studentRef = FirebaseFirestore.instance.collection("Students");
  Future<void> createStudentEntity() async {
    studentRef.doc(uid).set(
      {
        "email": _student_email,
        "name": _student_name,
        "phoneNumber": _student_phoneNumber,
        "Education": _student_education,
        "Courses": _courses_Enrolled
      },
    );
  }

  String getStudentName() {
    return this._student_name;
  }

  String getStudentEmail() {
    return _student_email;
  }

  String getStudentEducation() {
    return _student_education;
  }

  String getStudentPhNumber() {
    return _student_phoneNumber;
  }

  // Future<String> _GetStudentName() async {
  //   studentRef.where('uid');
  //   return " ";
  // }
}
