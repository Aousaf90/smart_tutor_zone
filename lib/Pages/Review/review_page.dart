import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Models/review_model.dart';

import 'package:smart_tutor_zone/helperFunction.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController review_controller = TextEditingController();

  double course_rating = 0.0;
  String review_text = "";
  String category = "";

  String sub_category = "";

  String course = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f9fe),
      appBar: AppBar(
        backgroundColor: Color(0xfff6f9fe),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "Write a Review",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<Course>(
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: Couse_Detail_Box(value: value),
                ),
                Write_Review_Box(
                  review_text: review_text,
                  onReviewChange: (value) {
                    setState(() {
                      review_text = value;
                    });
                  },
                ),
                Rating_Box(
                  course_rating: course_rating,
                  onRatingUpdate: (rating) {
                    setState(() {
                      course_rating = rating;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: TextButton(
        onPressed: () async {
          String? studen_name = await helperFunction.getStudentName();
          String student = studen_name!;
          await update_raview(
            review_text,
            course_rating,
            context,
          ).then((value) {
            Provider.of<Course>(context, listen: false)
                .updateReview(course_rating, review_text, student);
            Navigator.pop(context);
          });
        },
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: Color(0xff005af5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListTile(
            leading: SizedBox(
              width: 70,
            ),
            title: const Text(
              "Submit Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_forward,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future update_raview(String review_text, double rating, context) async {
    String? student_name = await helperFunction.getStudentName();

    ReviewCourse(
        student_name: student_name.toString(),
        review_text: review_text,
        rating: rating)
      ..addReview(context).then((value) {
        setState(() {
          review_text = "";
          rating = 0;
          Navigator.pop(context);
        });
      });
  }
}

class Rating_Box extends StatefulWidget {
  Rating_Box({required this.course_rating, required this.onRatingUpdate});
  void Function(double) onRatingUpdate;
  double course_rating;

  @override
  State<Rating_Box> createState() => _Rating_BoxState();
}

class _Rating_BoxState extends State<Rating_Box> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: widget.onRatingUpdate,
                ),
                Text(
                  "${widget.course_rating}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }
}

class Write_Review_Box extends StatelessWidget {
  Write_Review_Box({required this.review_text, required this.onReviewChange});
  String review_text;
  void Function(String)? onReviewChange;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Write your Review: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                onChanged: onReviewChange,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText:
                      "Would you like to write anything about this Course ?",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Couse_Detail_Box extends StatelessWidget {
  var value;
  Couse_Detail_Box({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.selectedCourseDetail['subCategory'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffed742e)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      value.selectedCourseDetail['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
