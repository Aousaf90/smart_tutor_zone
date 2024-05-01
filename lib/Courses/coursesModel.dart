import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';

class Course extends ChangeNotifier {
  String _name = "";
  String _price = "";
  double _rating = 0.0;
  String _tutor = "";
  List _total_number_of_student = [];
  List _rating_list = [];
  String _category = "";
  String _subCategory = "";
  String _lecture_link = "";
  Map<String, dynamic> _selected_course = {};
  UnmodifiableMapView get selectedCourseDetail {
    return UnmodifiableMapView(_selected_course);
  }

// rating system
// youtube API integration
// couse catalog
// chat room 
// provider state managemetn


  void selectedCourse(
      String name,
      String category,
      String price,
      double rating,
      String tutor,
      String subCategory,
      String lecture_link,
      List total_number_of_student,
      List rating_list) {
    _selected_course = {
      'name': name,
      'price': price,
      'rating': rating,
      'tutor': tutor,
      'students': total_number_of_student,
      'category': category,
      'subCategory': subCategory,
      'lectures': lecture_link,
      'rating_list': rating_list
    };
    notifyListeners();
  }

  searchCourse() async {
    List courses = [];
    courses = await getAllCourses();
    return courses;
  }

  void setValues(
      String name,
      String category,
      String price,
      double rating,
      String tutor,
      String subCategory,
      String lecture_link,
      List total_number_of_student,
      List rating_list) {
    _name = name;
    _price = price;
    _rating = rating;
    _tutor = tutor;
    _total_number_of_student = total_number_of_student;
    _category = category;
    _subCategory = subCategory;
    _lecture_link = lecture_link;
    _rating_list = rating_list;
    print("Value Set Successfully");

    notifyListeners();
  }

  void updateReview(double rating, String review_text, String student) {
    try {
      List rating_list = selectedCourseDetail['rating_list'];
      Map<String, dynamic> new_entry = {
        "rating": rating,
        "review": review_text,
        "student": student,
      };
      rating_list.add(new_entry);
      _selected_course = {
        ..._selected_course, // Keep existing key-value pairs
        'rating': rating,
        'rating_list': rating_list,
      };
      notifyListeners();
    } catch (e) {
      print("Error $e in courseModel.dart");
    }
  }

  Widget viewBox(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 230, 232, 234).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  trailing: Icon(
                    Icons.save,
                    color: Color(0xff088072),
                  ),
                  title: Text(
                    _name,
                    style: TextStyle(
                      color: Color(0xfffa680e),
                    ),
                  ),
                ),
                Text(
                  _category,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _price,
                      style: TextStyle(
                        color: Color(0xff3284f7),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xfffacc42),
                    ),
                    Text("$_rating"),
                    Text("|"),
                    Text("${_total_number_of_student.length} Std"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    notifyListeners();
  }
}
