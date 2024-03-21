import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/allCategory.dart';
import 'package:smart_tutor_zone/Pages/course_overview.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/style.dart';
import '../Courses/courseHelper.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});
  @override
  State<homePage> createState() => _homePageState();
}

final studentModel = Student();
List mainCategory_List = [];
List<Course> course_list = [];
List subCateogry_List = [];
List course_List = [];
List<dynamic> courseData = [];
String selectedCategory = mainCategory_List[0];
String selected_subcategory = "";
List<dynamic> currentCourses = [];
getAllData() async {
  courseData = await getCourseData();
  for (var course in courseData) {
    String MCategory = course[0];
    String SubCategory = course[1];
    if (mainCategory_List.contains(MCategory) == false) {
      mainCategory_List.add(MCategory);
    }
  }
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    final studentModel = Student();
    setAllCourses();
    getAllData();
    // getAllCategories();
    print("Student Name in home Page = ${studentModel.getStudentName()}");
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //First Container (Greetings)
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StudentNameSection(),
                      const Text(
                        "What Would you like to learn Today? ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        "Search Below",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.circle_notifications_outlined,
                    size: 50, color: Color.fromARGB(255, 79, 72, 122))
              ],
            )),
            //Second Container (Search Bar)
            const SizedBox(height: 30),
            Container(
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 148, 149, 173),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: WidgetStyle().textInputDecorator.copyWith(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search For",
                        suffixIcon: const Icon(
                          Icons.filter_1_outlined,
                          color: Colors.black,
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            //Third Container (Discound Page)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/discournt_pic.png"),
                ),
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(height: 30),
            CourseFilterContainer(),
            ElevatedButton(
              onPressed: logout,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  logout() {
    final auth = FirebaseAuth.instance;
    auth.signOut();
    helperFunction.deleteStudentData();
    WidgetStyle().NextScreen(context, const LoginPage());
  }
}

class CourseFilterContainer extends StatefulWidget {
  @override
  State<CourseFilterContainer> createState() => _CourseFilterContainerState();
}

class _CourseFilterContainerState extends State<CourseFilterContainer> {
  @override
  Widget build(BuildContext context) {
    List<Widget> main_category_widget = [];
    List<Course> CourseList = [];
    for (var category in mainCategory_List) {
      main_category_widget.add(
        TextButton(
          onPressed: () async {
            List<dynamic> subCategories =
                await getSubCategory(selectedCategory);
            setState(
              () {
                selectedCategory = category;
                subCateogry_List = subCategories;
              },
            );
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              category == selectedCategory
                  ? Color(0xff0051f5)
                  : Color(0xffa0a4ab),
            ),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    }
    Future<List<Widget>> getsubCategoryListWidget(subCateogry_List) async {
      List<Widget> sub_category_list_widget = [];
      for (var subCategory in subCateogry_List) {
        sub_category_list_widget.add(
          TextButton(
            onPressed: () {
              setState(() {
                selected_subcategory = subCategory;
                getCourListWidget(context);
              });
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                selected_subcategory == subCategory
                    ? Color(0xff0051f5)
                    : Color(0xffa0a4ab),
              ),
            ),
            child: Text(
              subCategory,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        );
      }
      return sub_category_list_widget;
    }

    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        WidgetStyle().NextScreen(
                          context,
                          const allCatagories(),
                        );
                      },
                      child: const Row(
                        children: [
                          Text(
                            "SEE ALL",
                            style: TextStyle(
                              color: Color(0xff0051f5),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: main_category_widget,
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 30),
          //Fourth Container (Popular Courses Page)
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sub Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            "SEE ALL",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                      future: getsubCategoryListWidget(subCateogry_List),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("There is an Error");
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return Row(
                            children: snapshot.data!,
                          );
                        } else {
                          return Container(
                            height: 30,
                            width: 30,
                            color: Colors.blue,
                          );
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  height: 230,
                  child: FutureBuilder<List<Widget>>(
                    future: getCourListWidget(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return CircularProgressIndicator();
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: snapshot.data!,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top Mentors ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text(
                            "SEE ALL",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(child: const Text("Stream of Different Mentors"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Student Name Section
class StudentNameSection extends StatefulWidget {
  const StudentNameSection({super.key});

  @override
  State<StudentNameSection> createState() => _StudentNameSectionState();
}

class _StudentNameSectionState extends State<StudentNameSection> {
  final studentModel = Student();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: studentModel.getStudentName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
            "Hi There",
            style: WidgetStyle().mainHeading,
          );
        } else {
          return Text(
            "Hi ${snapshot.data}",
            style: WidgetStyle()
                .mainHeading
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }
}

Future<List> getSubCategory(String selectedCategory) async {
  List<String> subCategoryList = [];
  List<dynamic> courseData = await getCourseData();
  for (var course in courseData) {
    if (course.contains(selectedCategory) &&
        !subCategoryList.contains(
          course[1],
        )) {
      subCategoryList.add(course[1]);
    }
  }
  await Future.delayed(Durations.medium4);
  return subCategoryList;
}

Future<List> getCourseList() async {
  List<String> course_list = [];
  List<dynamic> courseData = await getCourseData();
  for (var course in courseData) {
    if (course.contains(selectedCategory) &&
        course.contains(selected_subcategory)) {
      course_list.add(course[2]);
    }
  }
  return course_list;
}

Future<List<Widget>> getCourListWidget(BuildContext context) async {
  List<Widget> courseListWidget = [];
  for (var course in await getCourseList()) {
    try {
      final data = await getEachCourseData(
          selectedCategory, selected_subcategory, course);

      Course Cr = Course(
          name: data['name'],
          category: selectedCategory,
          subCategory: selected_subcategory,
          price: data['price'],
          total_number_of_student: data['students'],
          tutor: data['tutor'],
          rating: data['rating'],
          lecture_link: data['lectures']);
      course_list.add(Cr);
      GestureDetector viewBoxGesture = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailPage(
                course_name: data['name'],
                instructure_name: data['tutor'],
                price: data['price'],
                rating: data['rating'],
                subCategory: selected_subcategory,
                videos_link: data['lectures'],
              ),
            ),
          );
        },
        child: Cr.viewBox(
          context,
        ),
      );
      courseListWidget.add(viewBoxGesture);
      courseListWidget.add(
        SizedBox(
          width: 30,
        ),
      );
    } catch (e) {
      print("Error = ${e}");
    }
  }

  return courseListWidget;
}
