import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: Container(
                    child: player,
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.pause();
                          },
                          icon: Icon(Icons.pause),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.play();
                          },
                          icon: Icon(Icons.play_arrow),
                        ),
                      ],
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.mute();
                      },
                      icon: Icon(
                        Icons.volume_mute,
                      ),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
