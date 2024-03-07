import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Courses {
  String name = "";
  String category = "";
  String subCategory = "";
  String price = "";
  String rating = "";
  String tutor = "";
  setCourseData(String name, String category, String subCategory, String price,
      String rating, String tutor) {
    this.name = name;
    this.category = category;
    this.subCategory = subCategory;
    this.price = price;
    this.rating = rating;
    this.tutor = tutor;
  }

  Widget getCourseViewBox() {
    Container courseContainer = Container(
      width: 250,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
          ),
          Container(
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Science"),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.save),
                      ),
                    ],
                  ),
                  const Text("Computer Science"),
                  const Row(
                    children: [
                      const Text("850/-  |"),
                      const Text("4.2  |"),
                      const Text("7830 Std"),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
    return courseContainer;
  }
}

