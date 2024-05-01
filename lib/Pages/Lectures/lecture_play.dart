import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Courses/coursesModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturePlay extends StatefulWidget {
  LecturePlay({
    required this.lecture_title,
    required this.videoId,
  });
  String lecture_title;
  String videoId;

  @override
  State<LecturePlay> createState() => _LecturePlayState();
}

class _LecturePlayState extends State<LecturePlay> {
  late YoutubePlayerController controller;
  int volumn = 50;
  bool is_mute = false;
  @override
  void initState() {
    try {
      String url = "https://www.youtube.com/watch?v=${widget.videoId}";
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      // TODO: implement initState
      super.initState();
    } catch (e) {
      print("There is some error ");
    }
  }

  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map course_detail =
        Provider.of<Course>(context, listen: false).selectedCourseDetail;
    String lecture_title = widget.lecture_title;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        aspectRatio: 16 / 9,
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          controller.addListener(() {
            Listener();
          });
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(lecture_title),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: player),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: IconButton(
                      onPressed: () {
                        controller.play();
                      },
                      icon: Icon(Icons.play_arrow, size: 40),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        controller.pause();
                      },
                      icon: Icon(Icons.stop, size: 40),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (volumn <= 100) {
                            volumn += 10;
                          }
                        });
                        controller.setVolume(volumn);
                      },
                      icon: Icon(Icons.volume_up_outlined, size: 40),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            if (volumn >= 0) {
                              volumn -= 10;
                            }
                          },
                        );
                        controller.setVolume(volumn);
                      },
                      icon: Icon(Icons.volume_down, size: 40),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        if (is_mute) {
                          controller.mute();
                        } else {
                          controller.unMute();
                        }
                        setState(() {
                          is_mute = !is_mute;
                        });
                      },
                      icon: Icon(Icons.volume_mute_rounded, size: 40),
                    ),
                  ),
                ],
              ),
              Divider(height: 10),
              Container(
                child: ListTile(
                  title: Text("Course: ", style: mainTextStyle),
                  subtitle:
                      Text("${course_detail['name']}", style: subTextStyle),
                ),
              ),
              Divider(),
              Container(
                child: ListTile(
                  title: Text(
                    "Tutor:",
                    style: mainTextStyle,
                  ),
                  subtitle: Text(
                    "${course_detail['tutor']}",
                    style: subTextStyle,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "${course_detail['tutor']} an exemplary educator, is renowned for her unwavering dedication and infectious +" +
                      " enthusiasm. Her ability to foster a supportive classroom environment cultivates a sense " +
                      "of belonging among students. With a keen eye for individual strengths, she tailors lessons to ignite " +
                      "each student's potential. Ms. Thompson's passion for lifelong learning serves as a beacon, inspiring her " +
                      "students to embrace challenges and strive for excellence.",
                  softWrap: true,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(),
              Text("Rating : ${course_detail['rating']}", style: subTextStyle)
            ],
          ),
        ),
      ),
    );
  }

  TextStyle mainTextStyle = TextStyle(color: Colors.blue, fontSize: 20);
  TextStyle subTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
}
