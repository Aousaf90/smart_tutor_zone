import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
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
    String lecture_title = widget.lecture_title;
    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       onPressed: () => Navigator.pop(context),
    //       icon: Icon(
    //         Icons.arrow_back,
    //       ),
    //     ),
    //     title: Text(lecture_title),
    //   ),
    //   body: Container(),
    // );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
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
        body: player,
      ),
    );
  }
}
