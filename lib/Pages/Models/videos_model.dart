import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LectureVideos {
  getSongsFromPlaylist() async {
    Map<String, dynamic> playlist_data = Map();
    List playlist_videos = [];
    var video_link =
        "https://www.youtube.com/playlist?list=PLfqMhTWNBTe3LtFWcvwpqTkUSlB32kJop";
    var yt = YoutubeExplode();
    var playlist = await yt.playlists.get(video_link);
    playlist_data['title'] = playlist.title;
    await for (var videos in yt.playlists.getVideos(playlist.id)) {
      playlist_videos.add(videos.title);
    }
    var total_videos = playlist_videos.length;
    playlist_data['videos'] = playlist_videos;
    playlist_data['total_lectures'] = total_videos;
    return playlist_data;
  }
}
