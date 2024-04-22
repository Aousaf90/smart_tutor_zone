import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/all_courses_provider.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';

import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lectures_catalog.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/style.dart';

class MyCoursesPage extends StatefulWidget {
  List course_widget = [];
  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(builder: (context, value, child) {
      return SingleChildScrollView(
        child: Container(
          height: 700,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: value.course_detail.length,
            itemBuilder: (context, index) {
              var course_detail = value.course_detail[index];

              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text("${course_detail['name']}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    subtitle: Text("${course_detail['subCategory']}"),
                    trailing: IconButton(
                      onPressed: () {
                        Provider.of<Course>(context, listen: false)
                            .selectedCourse(
                                course_detail['name'],
                                course_detail['category'],
                                course_detail['price'],
                                course_detail['rating'].toDouble(),
                                course_detail['tutor'],
                                course_detail['subCategory'],
                                course_detail['lectures'],
                                course_detail['students'],
                                course_detail['rating_list']);
                        WidgetStyle().NextScreen(context, LectureCatalogPage());
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

Map<String, dynamic> unmodifiableMapViewToMap(
    UnmodifiableMapView<dynamic, dynamic> unmodifiableMap) {
  Map<String, dynamic> result = {};
  unmodifiableMap.forEach((key, value) {
    result[key.toString()] = value;
  });
  return result;
}
