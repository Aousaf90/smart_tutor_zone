import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lectures_catalog.dart';
import 'package:smart_tutor_zone/style.dart';

String student_email = "";
String course_name = "";
String course_category = "";
String course_subCategory = "";

void setEnrollmentData(
    String email, String course, String category, String sub_category) {
  student_email = email;
  course_name = course;
  course_category = category;
  course_subCategory = sub_category;
}

enrollStudent(context) async {
  try {
    var data = {};
    var student_data = {};
    var course_database = FirebaseFirestore.instance.doc(
        "/Courses_Categories/$course_category/$course_subCategory/$course_name");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Students")
        .where('email', isEqualTo: student_email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var student_database = querySnapshot.docs.first.reference;
      var student_doc_ref =
          await student_database.get().then((DocumentSnapshot doc) {
        student_data = doc.data() as Map<String, dynamic>;
      });
      List student_courses = student_data['Courses'];
      if (!student_courses.contains(course_name)) {
        print("Student Name = ${student_data['name']}");
        student_courses.add(course_name); // Add course_name to the list
        await student_database.update({"Courses": student_courses}).then(
            (value) => print("Student DocumentSnapshot successfully updated"),
            onError: (e) => print("Error updating document $e"));
        print("Course Enrolled successfully to Student");
        print("Data for Course $student_email = ${student_database}");
      }
    }

    var docRef = await course_database.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
    );

    List enrolled_students = data['students'];
    if (enrolled_students.contains(student_email) == false) {
      enrolled_students.add(student_email);
      data['students'] = enrolled_students;
      await course_database.update({'students': enrolled_students}).then(
          (value) => print("DocumentSnapshot successfully updated"),
          onError: (e) => print("Error updating document $e"));
      print("Student Enrolled successfully to Courses");
    }
    WidgetStyle().NextScreen(context, LectureCatalogPage());
  } on FirebaseException {
    print("There is some error");
  }
}