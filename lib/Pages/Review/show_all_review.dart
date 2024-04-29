import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Review/review_page.dart';
import 'package:smart_tutor_zone/style.dart';

class ShowAllReviews extends StatelessWidget {
  const ShowAllReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Course>(
      builder: (context, value, child) {
        double rating = value.selectedCourseDetail['rating'];
        List rating_list = value.selectedCourseDetail['rating_list'];

        print("Rating = ${rating}");
        print("rating_list =${rating_list}");
        return Scaffold(
          backgroundColor: Color(0xfff5f9ff),
          appBar: AppBar(
            backgroundColor: Color(0xfff5f9ff),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 40,
              ),
            ),
            title: const Text("Reviews",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "${rating}",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          RatingBar.builder(
                            initialRating: rating,
                            allowHalfRating: true,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (value) {},
                          ),
                          Text(
                            "Based on ${rating_list.length} Reviews",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: Container(
                      child: ListView.builder(
                        itemCount: rating_list.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 25,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 230,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${rating_list[index]['student']}",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Color(
                                                                0xff3e7eff),
                                                          ),
                                                          color: Color(
                                                              0xffe7f1ff)),
                                                      child: Row(children: [
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          "${rating_list[index]['rating']}",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              width: 230,
                                              child: Text(
                                                  softWrap: true,
                                                  "${rating_list[index]['review']}"),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.heart_broken,
                                                    color: Colors.red),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                const Text(
                                                  "2 Weeks Ago",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        WidgetStyle().NextScreen(
                          context,
                          ReviewPage(),
                        );
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
                            "Write a Review",
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
                  ),
                ],
              )),
        );
      },
    );
  }
}
