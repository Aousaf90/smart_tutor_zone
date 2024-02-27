import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_tutor_zone/helperFunction.dart';

class Student {
  String? uid = "";
  String? _student_name = "";
  String? _student_email = "";
  String? _student_education = "";
  String? _student_phoneNumber = "";
  List _courses_Enrolled = [];

  User() {
    _student_name = "";
    _student_email = "";
    _student_education = "";
    _student_phoneNumber = "";
    _courses_Enrolled = [];
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

  Future<String?> getStudentName() async {
    print(helperFunction.getStudentName());
    return await helperFunction.getStudentName();
  }

  String? getStudentEmail() {
    return _student_email;
  }

  String? getStudentEducation() {
    return _student_education;
  }

  String? getStudentPhNumber() {
    return _student_phoneNumber;
  }

  // Future<String> _GetStudentName() async {
  //   studentRef.where('uid');
  //   return " ";
  // }
}
