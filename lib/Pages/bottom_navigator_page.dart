import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';
import 'package:smart_tutor_zone/Pages/chat_room/chat_list.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/Pages/my_courses.dart';

import 'package:smart_tutor_zone/profile_page.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int current_page_index = 1;

  List pageList = [
    ProfilePage(),
    homePage(),
    ChatListPage(),
    MyCoursesPage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[current_page_index],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffF5F9FF),
          fixedColor: Color(0xff0059F5),
          unselectedItemColor: Color(0xff088071),
          selectedIconTheme: IconThemeData(size: 40),
          currentIndex: current_page_index,
          onTap: (value) {
            setState(() {
              current_page_index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(
                  Icons.person,
                )),
            BottomNavigationBarItem(
                label: "Home ",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Chat",
                icon: Icon(
                  Icons.chat,
                )),
            BottomNavigationBarItem(
                label: "My Courses",
                icon: Icon(
                  Icons.folder,
                ))
          ]),
    );
  }
}
