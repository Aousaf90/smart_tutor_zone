import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_tutor_zone/helperFunction.dart';

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
      final studentRef = FirebaseFirestore.instance.collection("Students");
      print("Student Collection ref = ${studentRef}");
      print("Student Name in Student Model = ${student_name}");
      print("Student Email in Student Model = ${student_email}");
      print("Student Phone Number in Student Model = ${student_PhoneNumber}");
      print("Student Education in Student Model = ${student_Education}");
      data = {
        "email": student_email,
        "name": student_name,
        "phoneNumber": student_PhoneNumber,
        "Education": student_Education,
        "Courses": []
      };
      print(
          "Student Id = ${studentRef.where('email', isEqualTo: 'aousafsuleman@gmail.com')}");
      print("Data in Student Model = ${data}");
      await studentRef.doc(uid).set(data);
    } on FirebaseException {
      print("There is some error");
    }
  }

  addCourseToCart(String course) async {}

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
}
