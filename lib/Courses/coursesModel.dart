import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Pages/course_overview.dart';

class Course {
  String name;
  String price;
  int rating;
  String tutor;
  List total_number_of_student = [];
  String category = "";
  String subCategory = "";
  Course(
      {this.name = 'Computer Science',
      this.category = "Technology",
      this.price = "799/-",
      this.rating = 0,
      this.subCategory = "Basic",
      this.total_number_of_student = const [],
      this.tutor = "Sir Kamran"});

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
                    name,
                    style: TextStyle(
                      color: Color(0xfffa680e),
                    ),
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Color(0xff3284f7),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Color(0xfffacc42),
                    ),
                    Text("$rating"),
                    Text("|"),
                    Text("$total_number_of_student Std"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
