import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Curriculum.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lectures_catalog.dart';
import 'package:smart_tutor_zone/Pages/Payment/pay_for_course.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/style.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class CourseDetailPage extends StatefulWidget {
  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    TextButton(
      onPressed: () {},
      child: CircleAvatar(
        backgroundColor: Color(
          0xff088071,
        ),
        child: Icon(Icons.play_circle_rounded),
      ),
    );
    return Consumer<Course>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Color(0xfff5f9ff),
        body: FutureBuilder(
          future: LectureCatalogPage().getCourseMediaFiles(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("There is some error"),
                ),
              );
            } else {
              final playlist_data = snapshot.data as Map<String, dynamic>;
              final total_lecturs = playlist_data['videos'].length;
              final total_duration = playlist_data['duration'] ~/ 180;

              return Container(
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
                                WidgetStyle().NextScreen(context, homePage());
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        width: 350,
                        height: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Main Heading with Orange Color
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  value.selectedCourseDetail['subCategory'],
                                  style: TextStyle(
                                    color: Color(0xffff870e),
                                  ),
                                ),
                                Text(
                                  "${value.selectedCourseDetail['rating']} Rating",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              value.selectedCourseDetail['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Detail of Course e.g total lecture , total length and price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${total_duration}  Hrs",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  value.selectedCourseDetail['price'],
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
                                  child: Text(
                                    "About Section",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${WidgetStyle().genearlAboutSection(value.selectedCourseDetail['name'])}",
                                    softWrap: true,
                                  ),
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
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.selectedCourseDetail['tutor'],
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
                              ),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 25),
                            ),
                            ListTile(
                              leading: Icon(Icons.play_lesson),
                              title: Text(" $total_lecturs Lessons"),
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
                            onPressed: () async {
                              String student_name =
                                  await Student().getStudentName().toString();
                              ;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CoursePayment(),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Enroll Course . ${value.selectedCourseDetail['price']}/-",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
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
              );
            }
          },
        ),
      );
    });
  }
}
