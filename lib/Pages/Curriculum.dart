import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/style.dart';
import './profile_page/profile_page.dart';

class Curriculcum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f9ff),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f9ff),
                ),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    title: const Text(
                      "Curriculcum",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Section: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Introduction",
                              style: TextStyle(
                                  color: Color(0xff0059f5),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "25 Min",
                              style: TextStyle(
                                color: Color(0xff0059f5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("01"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Why Using Graphic Design",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("15 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("02"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Setup Your Graphic Design",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("10 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("03"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Take a Look Graphic Design ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("08 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("04"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Working with Graphic Design ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("25 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("05"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Using Graphic Plugins",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("15 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xfff5f9ff),
                            child: const Text("06"),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Let's Design a Sign Up From UP",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("15 min")
                            ],
                          ),
                          trailing: Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xff005af5),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        WidgetStyle().NextScreen(context, ProfilePage());
                      },
                      child: Text("Profile Page"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Edit Profile Page"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
