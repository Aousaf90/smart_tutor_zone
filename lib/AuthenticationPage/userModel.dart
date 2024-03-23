import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_tutor_zone/helperFunction.dart';

class Student {
  String? uid = "";
  String? _student_name = "";
  String? _student_email = "";
  String? _student_education = "";
  String? _student_phoneNumber = "";
  List _courses_Enrolled = [];

  final studentRef = FirebaseFirestore.instance.collection("Students");
  Future<void> createStudentEntity(
      {String student_email = "",
      String student_name = "",
      String student_PhoneNumber = "",
      String student_Education = ""}) async {
    _student_name = student_name;
    _student_education = student_Education;
    _student_email = student_email;
    _student_phoneNumber = student_PhoneNumber;
    studentRef.doc(uid).set(
      {
        "email": student_email,
        "name": student_name,
        "phoneNumber": student_PhoneNumber,
        "Education": student_Education,
        "Courses": _courses_Enrolled
      },
    );
  }

  Future<String?> getStudentName() async {
    return await helperFunction.getStudentName();
  }

  Future<String?> getStudentEmail() async {
    return await helperFunction.getStudentEmail();
  }

  Future<String?> getStudentEducation() async {
    return await helperFunction.getStudentEducation();
  }

  Future<String?> getStudentPhNumber() async {
    return await helperFunction.getPhoneNumber();
  }

  // enrollStudent(course_id) {
  //   print("Student to be Enrolled = ${_student_name}");
  //   return _student_email;
  // }
}
