import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lectures_catalog.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/bottom_navigator_page.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/style.dart';

String student_email = "";
String course_name = "";
String course_category = "";
String course_subCategory = "";
Map _courseDetail = {};

void setEnrollmentData(
  context,
  String email,
) {
  student_email = email;

  _courseDetail = unmodifiableMapViewToMap(
      Provider.of<Course>(context, listen: false).selectedCourseDetail);
}

Map<String, dynamic> unmodifiableMapViewToMap(
    UnmodifiableMapView<dynamic, dynamic> unmodifiableMap) {
  Map<String, dynamic> result = {};
  unmodifiableMap.forEach((key, value) {
    result[key.toString()] = value;
  });
  return result;
}

enrollStudent(context) async {
  try {
    var data = {};
    var student_data = {};
    String course_category = _courseDetail['category'];
    String course_subCategory = _courseDetail['subCategory'];
    String course_name = _courseDetail['name'];
    List student_courses = _courseDetail['students'];

    var course_database = FirebaseFirestore.instance.doc(
        "/Courses_Categories/$course_category/$course_subCategory/$course_name");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Students")
        .where('email', isEqualTo: student_email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var student_database = querySnapshot.docs.first.reference;
      var student_doc_ref = await student_database
          .get()
          .then((DocumentSnapshot doc) {
        student_data = doc.data() as Map<String, dynamic>;
      }).then((value) => print("Student_Enrollment in Process"),
              onError: (e) =>
                  print("There was some error in enrollment of student $e "));
      List student_courses = [];
      if (student_data['Courses'] != null) {
        student_courses = student_data['Courses'];
      }

      if (student_courses.contains(_courseDetail) != true) {
        student_courses.add(_courseDetail);
        Provider.of<StudentModel>(context, listen: false)
            .updateCourses(_courseDetail);

        await student_database.update({"Courses": student_courses}).then(
            (value) => print("Student DocumentSnapshot successfully updated"),
            onError: (e) =>
                print("Error updating document in enrollStudent.dart $e"));
      }
    }

    var docRef = await course_database.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
    );

    List enrolled_students = [];
    List rating_list = [];
    if (data['students'] != null) {
      enrolled_students = data['students'];
    }
    if (data['rating_list'] != null) {
      rating_list = data['rating_list'];
    }
    if (enrolled_students.contains(student_email) == false) {
      enrolled_students.add(student_email);
      data['students'] = enrolled_students;
      Provider.of<Course>(context, listen: false).selectedCourse(
          data['name'],
          course_category,
          data['price'],
          data['rating'].toDouble(),
          data['tutor'],
          course_subCategory,
          data['lectures'],
          data['students'],
          rating_list);
      await course_database.update({'students': enrolled_students}).then(
          (value) => print("DocumentSnapshot successfully updated"),
          onError: (e) => print("Error updating document $e"));
      print("Student Enrolled successfully to Courses");
    }
    showDialog(
      barrierColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Image(
              image: AssetImage("images/person_congrats.png"),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Congratulations",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.countryName),
                ),
                const Text(
                  "Your Payment Method is successful we are re-directing you to Course Catalog",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  softWrap: true,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      WidgetStyle().NextScreen(
        context,
        const PageNavigator(),
      );
    });
    WidgetStyle().NextScreen(context, LectureCatalogPage());
  } on FirebaseException {
    print("There is some error");
  }
}
