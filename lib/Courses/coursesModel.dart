import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Pages/course_overview.dart';

class Course extends ChangeNotifier {
  String _name = "";
  String _price = "";
  int _rating = 0;
  String _tutor = "";
  List _total_number_of_student = [];
  String _category = "";
  String _subCategory = "";
  String _lecture_link = "";
  Map<String, dynamic> _selected_course = {};
  UnmodifiableMapView get selectedCourseDetail {
    return UnmodifiableMapView(_selected_course);
  }

  void selectedCourse(
      String name,
      String category,
      String price,
      int rating,
      String tutor,
      String subCategory,
      String lecture_link,
      List total_number_of_student) {
    _selected_course = {
      'name': name,
      'price': price,
      'rating': rating,
      'tutor': tutor,
      'students': total_number_of_student,
      'category': category,
      'subCategory': subCategory,
      'lectures': lecture_link,
    };
    notifyListeners();
  }

  void setValues(
      String name,
      String category,
      String price,
      int rating,
      String tutor,
      String subCategory,
      String lecture_link,
      List total_number_of_student) {
    _name = name;
    _price = price;
    _rating = rating;
    _tutor = tutor;
    _total_number_of_student = total_number_of_student;
    _category = category;
    _subCategory = subCategory;
    _lecture_link = lecture_link;
    print("Value for ${name} Course has been set");
    notifyListeners();
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
                    Text("$_total_number_of_student Std"),
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
