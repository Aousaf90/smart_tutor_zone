import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_tutor_zone/AuthenticationPage/LoginPage.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Pages/allCategory.dart';
import 'package:smart_tutor_zone/helperFunction.dart';
import 'package:smart_tutor_zone/style.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

final studentModel = Student();

class _homePageState extends State<homePage> {
  final String studentName = studentModel.getStudentName();
  @override
  Widget build(BuildContext context) {
    final studentModel = Student();
    String studentName = studentModel.getStudentName();
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
                      Text("Hi, $studentName",
                          style: WidgetStyle()
                              .mainHeading
                              .copyWith(color: Colors.black)),
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
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(height: 30),
            //Fourth Container (Categories Page)
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
                  Container(child: const Text("Stream of Different Categoris"))
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
                        "Popular Courses",
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
                  Container(
                      child: const Text("Stream of Different Popular Courses"))
                ],
              ),
            ),
            //Fifth Container (Top Mentors)
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
