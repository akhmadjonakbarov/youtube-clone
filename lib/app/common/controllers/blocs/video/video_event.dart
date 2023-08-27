part of 'video_bloc.dart';

@immutable
sealed class MyVideoEvent {}

class VideosGetEvent extends MyVideoEvent {
  String? userUid;
  final String channelUid;
  VideosGetEvent({this.userUid, required this.channelUid});
}

class VideoGetEvent extends MyVideoEvent {
  final String uid;

  VideoGetEvent({
    required this.uid,
  });
}

class VideoAddEvent extends MyVideoEvent {
  final File videoFile;
  final VideoModel videoModel;

  VideoAddEvent({
    required this.videoModel,
    required this.videoFile,
  });
}
