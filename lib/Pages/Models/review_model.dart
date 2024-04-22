import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/style.dart';

class ReviewCourse {
  String student_name = "";
  String review_text = "";
  double rating = 0.0;

  ReviewCourse(
      {required this.student_name,
      required this.review_text,
      required this.rating});

  Future addReview(context) async {
    try {
      UnmodifiableMapView course_deatail =
          Provider.of<Course>(context, listen: false).selectedCourseDetail;
      Map<String, dynamic> course_data = await getCourseData(
          course_deatail['category'],
          course_deatail['subCategory'],
          course_deatail['name']);

      var course_rating = course_data['rating'];
      var category = course_deatail['category'];
      var sub_category = course_deatail['subCategory'];
      var course_name = course_deatail['name'];
      var rating_list = course_data['rating_list'];
      var rating_detail = {
        "student": this.student_name,
        "review": this.review_text,
        "rating": this.rating
      };

      DocumentReference documentReference = FirebaseFirestore.instance.doc(
        "/Courses_Categories/${category}/${sub_category}/${course_name}",
      );
      course_rating += this.rating;

      if (rating_list != null && rating_list.length > 0) {
        course_rating /= 2;
      }
      rating_list.add(rating_detail);
      documentReference.update({
        'rating': course_rating,
        "rating_list": rating_list,
      }).then(
        (value) {
          print("Document Snpashot successfully updated");
        },
        onError: (e) => print("Error updaing document $e"),
      );
    } catch (e) {
      print("This was some error while updating review : $e");
    }
  }
}
