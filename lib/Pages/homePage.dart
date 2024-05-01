import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/all_courses_provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lectures_catalog.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/course_overview.dart';

import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/profile_page.dart';
import 'package:smart_tutor_zone/style.dart';
import '../Courses/courseHelper.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});
  @override
  State<homePage> createState() => _homePageState();
}

final studentModel = Student();
List search_history = [];
List mainCategory_List = [];
List<Course> course_list = [];
List subCateogry_List = [];
List course_List = [];
List<dynamic> courseData = [];
String selectedCategory = mainCategory_List[0];
String selected_subcategory = "Entrepreneurship";
List<dynamic> currentCourses = [];
List courseListWidget = [];
getAllData(context) async {
  courseData = await getAllCourses();
  for (var course in courseData) {
    String MCategory = course[0];
    String SubCategory = course[1];
    if (mainCategory_List.contains(MCategory) == false) {
      mainCategory_List.add(MCategory);
    }
    selectedCategory = mainCategory_List[0];
    subCateogry_List = filterSubCategories(context, selectedCategory);
  }
}

class _homePageState extends State<homePage> {
  int current_page_index = 0;
  final SearchController controller = SearchController();
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(queryListener);
    controller.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    controller.removeListener(searchListener);
    searchController.dispose();
    controller.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  void queryListener() {
    filterCourse(controller.text);
  }

  void searchListener() {
    filterCourse(controller.text);
  }

  Widget show_all_courses() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: courseData.length,
      itemBuilder: (context, index) {
        Flexible(
            child: Card(
          child: Text(courseData[index][2]),
        ));
      },
    );
  }

  redirectSelectedCourse(selectedCourse) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    Map course_data = await searchCourse(selectedCourse);
    String student_email = await helperFunction.getStudentEmail() ?? "";
    Navigator.pop(context);
    Provider.of<Course>(context, listen: false).selectedCourse(
        course_data['name'],
        course_data['category'],
        course_data['price'],
        course_data['rating'].toDouble(),
        course_data['tutor'],
        course_data['subCategory'],
        course_data['lectures'],
        course_data['students'],
        (course_data['rating_list'] == null) ? [] : course_data['rating_list']);

    if (course_data['students'].contains(student_email)) {
      WidgetStyle().NextScreen(context, LectureCatalogPage());
    } else {
      WidgetStyle().NextScreen(context, CourseDetailPage());
    }
  }

  filterCourse(String value) {
    List search_list = [];
    for (var course in courseData) {
      String program = course[2];
      if (program.toLowerCase().contains(value.toLowerCase())) {
        // If the program contains the search value, add it to the search_list
        if (!search_list.contains(program)) {
          search_list.add(program);
        }
      }
    }

    return Container(
      height: 600,
      child: ListView.builder(
        itemCount: search_list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              redirectSelectedCourse(search_list[index]);
            },
            child: Card(
                child: Center(
                    child: Text(
              search_list[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ))),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentModel = Student();

    return Container(
      child: FutureBuilder(
        future: getAllData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
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
                      IconButton(
                        icon: Icon(Icons.person, size: 50, color: Colors.black),
                        onPressed: () => {
                          WidgetStyle().NextScreen(
                            context,
                            ProfilePage(),
                          ),
                        },
                      ),
                    ],
                  )),
                  //Second Container (Search Bar)
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(31, 148, 149, 173),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SearchAnchor(
                      searchController: controller,
                      viewHintText: "Search...",
                      viewTrailing: [
                        IconButton(
                          onPressed: () {
                            search_history.add(controller.text);
                            search_history =
                                search_history.reversed.toSet().toList();
                            controller.closeView(controller.text);
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                      builder: (context, controlle) {
                        return SearchBar(
                          controller: controlle,
                          leading: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                          trailing: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mic),
                            ),
                          ],
                          hintText: "Search For...",
                          onTap: () => controlle.openView(),
                        );
                      },
                      suggestionsBuilder: (context, controlle) {
                        return [
                          Wrap(
                            children:
                                List.generate(search_history.length, (index) {
                              final item = search_history[index];
                              return Container(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: ChoiceChip(
                                  label: Text(item),
                                  selected: item == controlle.text,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  onSelected: (value) {
                                    // search(item);
                                    controlle.closeView(item);
                                  },
                                ),
                              );
                            }),
                          ),
                          if (controller.text.isNotEmpty) ...[
                            filterCourse(controller.text),
                          ]

                          // if (controller.text.isEmpty) ...[
                          //   const Divider(),

                          // ]
                        ];
                      },
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
                ],
              ),
            );
          }
        },
      ),
    );
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
          onPressed: () {
            setState(
              () {
                subCateogry_List = filterSubCategories(context, category);
                selectedCategory = category;
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
            onPressed: () async {
              List<Widget> widgets = await getCourListWidget(context);
              setState(() {
                selected_subcategory = subCategory;
                courseListWidget = widgets;
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
                          if (snapshot.hasError) {
                            return CircularProgressIndicator();
                          } else {
                            return Container(
                              height: 30,
                              width: 30,
                              color: Colors.blue,
                            );
                          }
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
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: snapshot.data!,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Container(
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text(
          //             "Top Mentors ",
          //             style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           TextButton(
          //             onPressed: () {},
          //             child: const Row(
          //               children: [
          //                 Text(
          //                   "SEE ALL",
          //                   style: TextStyle(
          //                     color: Colors.blue,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 5,
          //                 ),
          //                 Icon(
          //                   Icons.arrow_forward_ios,
          //                   size: 20,
          //                 )
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //       Container(child: const Text("Stream of Different Mentors"))
          //     ],
          //   ),
          // ),
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
            "There",
            style: WidgetStyle().mainHeading,
          );
        } else {
          return Text(
            "Hi ${Provider.of<StudentModel>(context, listen: false).name_detail[0]}",
            style: WidgetStyle()
                .mainHeading
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }
}

filterSubCategories(context, category) {
  var subCategoryList = [];
  for (var data in courseData) {
    if (data.contains(category)) {
      subCategoryList.add(data[1]);
    }
  }
  var temp = subCategoryList.toSet();
  subCategoryList = temp.toList();
  Provider.of<AllCoursesProvider>(context, listen: false)
      .setAllSubCategories(subCategoryList);
  Provider.of<AllCoursesProvider>(context, listen: false)
      .setAllCategories(mainCategory_List);
  return subCategoryList;
}

Future<List> getCourseList(
  context,
) async {
  List<String> course_list = [];
  for (var course in courseData) {
    if (course.contains(selectedCategory) &&
        course.contains(selected_subcategory)) {
      course_list.add(course[2]);
    }
  }
  Provider.of<AllCoursesProvider>(context, listen: false)
      .setAllCourses(course_list);
  return course_list;
}

Future<List<Widget>> getCourListWidget(
  BuildContext context,
) async {
  List<Widget> courseListWidget = [];
  List courseList = await getCourseList(context);
  List<Future> futures = [];

  for (var course in courseList) {
    futures.add(getCourseData(selectedCategory, selected_subcategory, course));
  }

  List<dynamic> results = await Future.wait(futures);
  Provider.of<AllCoursesProvider>(context, listen: false)
      .setCourseData(results);
  int number = 0;
  for (var data in results) {
    number += 1;
    if (data['students'] == null) {
      data['students'] = [];
    }
    if (data['rating_list'] == null) {
      data['rating_list'] = [];
    }
    try {
      double rating = data['rating'].toDouble();

      Provider.of<Course>(context, listen: false).setValues(
          data['name'],
          selectedCategory,
          data['price'],
          rating,
          data['tutor'],
          selected_subcategory,
          data['lectures'],
          data['students'],
          data['rating_list']);
      GestureDetector viewBoxGesture = GestureDetector(
        onTap: () async {
          Provider.of<Course>(context, listen: false).selectedCourse(
              data['name'],
              selectedCategory,
              data['price'],
              data['rating'].toDouble(),
              data['tutor'],
              selected_subcategory,
              data['lectures'],
              data['students'],
              data['rating_list']);
          var courseData =
              Provider.of<Course>(context, listen: false).selectedCourseDetail;
          String student_email = await helperFunction.getStudentEmail() ?? "";

          if (data['students'].contains(student_email)) {
            WidgetStyle().NextScreen(context, LectureCatalogPage());
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailPage(),
              ),
            );
          }
        },
        child: Provider.of<Course>(context, listen: false).viewBox(context),
      );
      courseListWidget.add(viewBoxGesture);
      courseListWidget.add(SizedBox(width: 30));
      setViewBoxList(courseListWidget);
    } catch (e) {
      print("Error = $e");
    }
  }
  Provider.of<AllCoursesProvider>(context, listen: false)
      .setCourseViewBox(courseListWidget);
  return courseListWidget;
}
