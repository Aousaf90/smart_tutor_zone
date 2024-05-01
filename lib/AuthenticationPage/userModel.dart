import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/style.dart';

class Student {
  String uid = "";

  Map<String, dynamic> data = {};
  void createStudentEntity({
    String uid = "",
    String student_email = "",
    String student_name = "",
    String student_PhoneNumber = "",
    String student_Education = "",
  }) async {
    try {
      FirebaseFirestore.instance.collection("Students");
      final studentRef = FirebaseFirestore.instance.collection("Students");
      data = {
        "email": student_email,
        "name": student_name,
        "phoneNumber": student_PhoneNumber,
        "Education": student_Education,
        "Courses": [],
        "uid": uid,
      };
      await studentRef.doc(uid).set(data);
    } on FirebaseException {
      print("There is some error");
    }
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

  logout(context) {
    final auth = FirebaseAuth.instance;
    auth.signOut();
    helperFunction.deleteStudentData();
    WidgetStyle().NextScreen(context, const LoginPage());
  }
}
