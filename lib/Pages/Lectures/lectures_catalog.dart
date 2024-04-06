import 'package:flutter/material.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/style.dart';

class LectureCatalogPage extends StatelessWidget {
  const LectureCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              WidgetStyle().NextScreen(context, homePage());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Text("Course Catalog Page"),
      ),
    );
  }
}
