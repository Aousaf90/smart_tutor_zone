import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:smart_tutor_zone/Pages/Lectures/lecture_play.dart';
import 'package:smart_tutor_zone/Pages/Review/review_page.dart';
import 'package:smart_tutor_zone/Pages/Review/show_all_review.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';
import 'package:smart_tutor_zone/style.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LectureCatalogPage extends StatelessWidget {
  const LectureCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Course>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            focusColor: Color(0xff005af5),
            backgroundColor: Color(
              0xff005af5,
            ),
            child: Icon(Icons.rate_review_rounded, color: Colors.white),
            onPressed: () {
              WidgetStyle().NextScreen(context, ReviewPage());
            },
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                WidgetStyle().NextScreen(context, const homePage());
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
            title: Text(value.selectedCourseDetail['name']),
          ),
          backgroundColor: Color(0xfff6f9fe),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder(
              future: getCourseMediaFiles(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("There is some error");
                } else {
                  Map<String, dynamic> course_data = snapshot.data!;
                  var total_items = (course_data['videos'] == null)
                      ? null
                      : course_data['videos'].length;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 600,
                          child: ListView.builder(
                            itemCount: (total_items == null)
                                ? 0
                                : course_data['videos'].length,
                            itemBuilder: (context, index) {
                              var video_duration = format_time(
                                course_data['videos'][index][1],
                              );

                              return (total_items == null)
                                  ? Container(
                                      child: Center(
                                        child: Text(
                                            "There is some problem with the internet"),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            height: 80,
                                            width: double.infinity,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Color(
                                                  0xfff5f9ff,
                                                ),
                                                child: Text("${index + 1}"),
                                                radius: 20,
                                              ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  course_name_widget(
                                                      course_data: course_data,
                                                      index_number: index),
                                                  Text(
                                                    "${video_duration}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing: IconButton(
                                                color: Color(0xff005af5),
                                                onPressed: () =>
                                                    WidgetStyle().NextScreen(
                                                  context,
                                                  LecturePlay(
                                                    lecture_title:
                                                        course_data['videos']
                                                            [index][0],
                                                    videoId:
                                                        course_data['videos']
                                                            [index][2],
                                                  ),
                                                ),
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff005af5),
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              WidgetStyle().NextScreen(
                                context,
                                ShowAllReviews(),
                              );
                            },
                            child: Center(
                              child: const Text(
                                "Show All Reviews,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  format_time(var time) {
    String time_in_min = ((time ~/ 60)).toString();
    String time_in_sec = (time % 60).toString();
    return time_in_min + ":" + time_in_sec;
  }

  Future<Map<String, dynamic>> getCourseMediaFiles(context) async {
    try {
      final yt = YoutubeExplode();
      Map<String, dynamic> course_detail = {};
      num total_duration = 0;
      List videos = [];
      String lecture_link = Provider.of<Course>(context, listen: false)
          .selectedCourseDetail['lectures'];
      var playlist_data = await yt.playlists.get(lecture_link);
      var title = Provider.of<Course>(context, listen: false)
          .selectedCourseDetail['name'];
      String videoId = "";
      await for (var video in yt.playlists.getVideos(playlist_data.id)) {
        videoId = video.id.toString();
        Duration video_duration = video.duration ??
            Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
        int video_dur = video_duration.inSeconds;
        total_duration = total_duration + video_dur;
        var video_detail = [video.title, video_dur, videoId];
        videos.add(video_detail);
      }

      var total_videos = videos.length;
      course_detail = {
        'title': title,
        'videos': videos,
        'total_videos': total_videos,
        'duration': total_duration,
      };
      return course_detail;
    } catch (e) {
      print("Error occur while retriving playlist info = ${e}");
      return {};
    }
  }
}

class course_name_widget extends StatelessWidget {
  course_name_widget({
    super.key,
    required this.course_data,
    required this.index_number,
  });
  var index_number;
  final Map<String, dynamic> course_data;

  @override
  Widget build(BuildContext context) {
    var text = course_data['videos'][index_number][0];
    if (text.length >= 33) {
      text = text.substring(0, 33) + "...";
      return Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    return Text(
      course_data["videos"][index_number][0],
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
