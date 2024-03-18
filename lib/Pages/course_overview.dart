import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CourseDetailPage extends StatefulWidget {
  String course_name;
  String instructure_name;
  int rating;
  String price;
  String subCategory;
  CourseDetailPage(
      {required this.course_name,
      required this.instructure_name,
      required this.price,
      required this.rating,
      required this.subCategory});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    floatingActionButton:
    TextButton(
      onPressed: () {},
      child: CircleAvatar(
        backgroundColor: Color(
          0xff088071,
        ),
        child: Icon(Icons.play_circle_rounded),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xfff5f9ff),
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                width: double.infinity,
                height: 400,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                width: 350,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Main Heading with Orange Color
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.subCategory,
                          style: TextStyle(
                            color: Color(0xffff870e),
                          ),
                        ),
                        Text(
                          "${widget.rating} Rating",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.course_name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Detail of Course e.g total lecture , total length and price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "21 Classes",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "42 Hrs",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Aboiut Section
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  height: 40,
                                  color: Color(0xfff5f9ff),
                                  child: Center(
                                    child: Text("About",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  height: 40,
                                  color: Color(0xffe7f1ff),
                                  child: Center(
                                    child: Text(
                                      "Curriculcum",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Container(
                          width: double.infinity,
                          child: Text("About Section"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Instructor",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.instructure_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text("Software Developer")
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.message_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What You'll Get",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                    const ListTile(
                      leading: Icon(Icons.play_lesson),
                      title: Text(" 25 Lessons"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(" Access Mobile, Desktop & TV"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.pie_chart),
                      title: Text(" Beginner Level"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.cloud),
                      title: Text(" Audio Book"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.handyman_outlined),
                      title: Text("100 Quizes"),
                    ),
                    const ListTile(
                      leading: Icon(Icons.document_scanner_sharp),
                      title: Text(" Certicate of Completion"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff005965),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Enroll Course . 499/-",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 30),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
