import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';

List course_view_box = [];
Future<Set<String>> getMainCategories() async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Courses_Categories");
  QuerySnapshot querySnapshot = await collectionRef.get();
  return querySnapshot.docs.map((doc) => doc.id).toSet();
}

Future<List<String>> getSubCategories(String categoryName) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection("Courses_Categories")
      .doc(categoryName)
      .get();
  if (snapshot.exists) {
    return List.from(snapshot['subCategories']);
  } else {
    throw Exception("Document does not exist");
  }
}

Future<Map<String, dynamic>> getCourses(
    String mainCategory, String subCategory) async {
  Map<String, dynamic> courseDetail = Map();
  List course_list = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection("/Courses_Categories/$mainCategory/$subCategory")
      .get();
  querySnapshot.docs.forEach(
    (element) {
      course_list.add(element.id);
    },
  );
  courseDetail[subCategory] = course_list;
  return courseDetail;
}

// Future<Map<String, List<String>>> getAllCategories() async {
//   Set<String> mainCategories = await getMainCategories();
//   Map<String, List<String>> courseDetail = {};
//   await Future.forEach(mainCategories, (mainCategory) async {
//     List<String> subCategories = await getSubCategories(mainCategory);
//     List<String> courses = [];
//     await Future.forEach(subCategories, (subCategory) async {
//       List<String> subCategoryCourses =
//           await getCourses(mainCategory, subCategory);
//       courses.addAll(subCategoryCourses);
//     });
//     courseDetail[mainCategory] = courses;
//   });
//   return courseDetail;
// }
getAllCategories() async {
  List sub_courses_list = [];
  final course_details = {};
  Map<String, List> subCategoryDetail = {};
  Map<String, dynamic> course_detail = Map();
  Set<String> main_categories = await getMainCategories();
  await Future.forEach(
    main_categories,
    (categorie) async {
      List sub_course_list = [];
      List subCategories = await getSubCategories(categorie);
      // print("SUb Category list for Category $categorie = ${subCategories}");
      for (var subCategory in subCategories) {
        Map<String, dynamic> courses = await getCourses(categorie, subCategory);
        sub_course_list.add(courses);
      }
      course_detail[categorie] = sub_course_list;
    },
  );
  return course_detail;
}

Future<List> getAllCourses() async {
  final courseList = [];
  final courseDetail = await getAllCategories();
  var main_category = courseDetail.keys.toList();
  for (var category in main_category) {
    var data = courseDetail[category];
    for (var subCategory in data) {
      var subCategoryName = subCategory.keys.first;
      List subCoursesList = subCategory[subCategoryName];
      for (var course in subCoursesList) {
        courseList.add([category, subCategoryName, course]);
      }
    }
  }
  return courseList;
}

Future<Map<String, dynamic>> getCourseData(
    String category, String subCategory, String course) async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .doc("/Courses_Categories/$category/$subCategory/$course")
      .get();
  return documentSnapshot.data() as Map<String, dynamic>;
}

Future<void> enrollStudentWithCourse(String studentEmail) async {
  print("Student to be Enrolled = $studentEmail");
}

setViewBoxList(List list_of_widget) {
  course_view_box = list_of_widget;
}

GestureDetector getViewBox(String course_name) {
  try {
    GestureDetector specificGestureDetector = course_view_box.firstWhere(
      <GestureDetector>(gestureDetector) {
        return (gestureDetector.child as Course).name == course_name;
      },
    ) as GestureDetector;
    return specificGestureDetector;
  } catch (e) {
    return GestureDetector(
      child: Container(
        height: 40,
        width: double.infinity,
      ),
      onTap: () {},
    );
  }
}

// Example usage:

