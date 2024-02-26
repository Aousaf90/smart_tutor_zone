import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_tutor_zone/AuthenticationPage/Register.dart';

class Student {
  String uid = "";
  String _student_name = "";
  String _student_email = "";
  String _student_education = "";
  String _student_phoneNumber = "";
  List _courses_Enrolled = [];

  User() {
    this._student_name = "";
    this._student_email = "";
    this._student_education = "";
    this._student_phoneNumber = "";
    this._courses_Enrolled = [];
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
    studentRef.doc(this.uid).set(
      {
        "email": this._student_email,
        "name": this._student_name,
        "phoneNumber": this._student_phoneNumber,
        "Education": this._student_education,
        "Courses": this._courses_Enrolled
      },
    );
  }

  String getStudentName() {
    return this._student_name;
  }

  String getStudentEmail() {
    return this._student_email;
  }

  String getStudentEducation() {
    return this._student_education;
  }
  String getStudentPhNumber(){
    return this._student_phoneNumber;
  }

  // Future<String> _GetStudentName() async {
  //   studentRef.where('uid');
  //   return " ";
  // }
}
