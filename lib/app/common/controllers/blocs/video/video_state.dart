// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_bloc.dart';

@immutable
sealed class VideoState {}

class VideoInitialState extends VideoState {}

class VideoLoadingState extends VideoState {}

class VideoLoadedState extends VideoState {
  List<VideoModel> videos;
  VideoLoadedState({
    required this.videos,
  });
}

class SingleVideoLoadedState extends VideoState {
  VideoModel videoModel;
  SingleVideoLoadedState({
    required this.videoModel,
  });
}

class VideoAddedState extends VideoState {}

class VideoErrorState extends VideoState {
  final String errorMsg;
  VideoErrorState({
    required this.errorMsg,
  });
}
