import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoursePayment extends StatelessWidget {
  GestureDetector course_view_box;
  CoursePayment({required this.course_view_box});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Container(
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    weight: 40,
                  ),
                ),
                title: const Text(
                  "Payment Methods",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
