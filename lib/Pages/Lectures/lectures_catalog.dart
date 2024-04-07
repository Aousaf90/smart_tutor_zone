import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
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
                  return Container(
                      child: ListView.builder(
                    itemCount: course_data['videos'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        height: 80,
                        width: double.infinity,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              child: Text(
                                index.toString(),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course_data["videos"][index][0],
                                ),
                                Text(
                                  "${course_data['videos'][index][1].toString()} seconds",
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ));
                }
              },
            ),
          ),
        );
      },
    );
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
      await for (var video in yt.playlists.getVideos(playlist_data.id)) {
        Duration video_duration = video.duration ??
            Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
        int video_dur = video_duration.inSeconds;
        total_duration = total_duration + video_dur;
        var video_detail = [video.title, video_dur];
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
