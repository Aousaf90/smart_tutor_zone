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
    Course course = Course();

    return Consumer<AllCoursesProvider>(builder: (context, value, child) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: FutureBuilder(
            future: getCourseDetail(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Container(
                    child: const Text(
                        "There is some error with your code check it "));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }

  Future<List> getCourseDetail(context) async {
    List course_data_widget = [];
    try {
      List selected_course_data = [];
      List course_detail = Provider.of<StudentModel>(context, listen: false)
          .course_detail
          .toList();
      // Course course = Course();
      List courses = await getAllCourses();
      for (var cr in courses) {
        for (var selected_course in course_detail) {
          if (cr.contains(selected_course)) {
            selected_course_data.add(cr);
            Course courseClass = Course();
            Map course_data = await getCourseData(cr[0], cr[1], cr[2]);
            var name = course_data['name'];
            var price = course_data['price'];
            var rating = course_data['rating'].toDouble();
            var category = cr[0];
            var tutor = course_data['tutor'];
            var subCategory = cr[1];
            var lecture_link = course_data['lectures'];
            var total_number_of_student = course_data['students'];
            var rating_list = course_data['rating_list'];
            if (rating_list == null) {
              rating_list = [];
            }
            courseClass.setValues(
                name,
                category,
                price,
                rating,
                tutor,
                subCategory,
                lecture_link,
                total_number_of_student,
                rating_list);

            Widget view_box = GestureDetector(
              child: courseClass.viewBox(context),
              onTap: () {
                Provider.of<Course>(context, listen: false).selectedCourse(
                  name,
                  category,
                  price,
                  rating.toDouble(),
                  tutor,
                  subCategory,
                  lecture_link,
                  total_number_of_student,
                  rating_list,
                );
                WidgetStyle().NextScreen(
                  context,
                  LectureCatalogPage(),
                );
              },
            );

            course_data_widget.add(view_box);
          }
        }
      }
      print("Total number of courses = ${course_data_widget.length}");
    } catch (e) {
      print("Error in my_course.dart ${e}");
    }
    return course_data_widget;
  }
}
