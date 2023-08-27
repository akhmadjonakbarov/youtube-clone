import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';

import '../../repositories/video_repository.dart';
import '../../services/video_api_service.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<MyVideoEvent, VideoState> {
  VideoBloc() : super(VideoInitialState()) {
    on<VideosGetEvent>(_getVideos);
    on<VideoGetEvent>(_getVideo);
    on<VideoAddEvent>(_addMyVideo);
  }

  _getVideos(VideosGetEvent event, Emitter<VideoState> emit) async {
    VideoGetRepository videoGetRepository = VideoGetRepository(
      videoGetApiService: VideoGetApiService(),
    );
    List<VideoModel> videos = [];
    try {
      emit(VideoLoadingState());
      if (event.userUid != null) {
        videos = await videoGetRepository.getVideosREPO();
        videos = videos.where((element) => element.userUid == event.userUid).toList();
      } else {
        videos = await videoGetRepository.getVideosREPO();
      }
      emit(VideoLoadedState(videos: videos));
    } catch (e) {
      log("BLOCVIDEOGET: $e");
      emit(VideoErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  _getVideo(VideoGetEvent event, Emitter<VideoState> emit) async {
    VideoGetRepository videoGetRepository = VideoGetRepository(
      videoGetApiService: VideoGetApiService(),
    );
    VideoUpdateViewRepository videoUpdateViewApiService = VideoUpdateViewRepository(
      videoUpdateViewApiService: VideoUpdateViewApiService(),
    );
    List<VideoModel> myVideos = [];
    VideoModel videoModel;
    try {
      emit(VideoLoadingState());
      myVideos = await videoGetRepository.getVideosREPO();
      videoModel = myVideos.firstWhere((element) => element.uid == event.uid);
      videoModel.views = videoModel.views + 1;
      await videoUpdateViewApiService.updateVideoViewREPO(videoModel: videoModel);
      emit(SingleVideoLoadedState(videoModel: videoModel));
    } catch (e) {
      log("BLOCVIDEOGET: $e");
      emit(VideoErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  Future<VideoModel> getSingleVideo({required String uid, required String channelUid}) async {
    VideoGetRepository videoGetRepository = VideoGetRepository(
      videoGetApiService: VideoGetApiService(),
    );
    List<VideoModel> myVideos = [];
    VideoModel videoModel;
    try {
      myVideos = await videoGetRepository.getVideosREPO();
      videoModel = myVideos.firstWhere((element) => element.uid == uid);
    } catch (e) {
      log("BLOCVIDEOGET: $e");
      rethrow;
    }
    return videoModel;
  }

  _addMyVideo(VideoAddEvent event, Emitter<VideoState> emit) async {
    VideoAddRepository videoAddRepository = VideoAddRepository(
      videoAddApiService: VideoAddApiService(),
    );
    VideoModel videoModel;
    List<VideoModel> myVideos = [];
    String uid;
    emit(VideoLoadingState());
    try {
      final videoFilePath = FirebaseStorage.instance.ref().child('videos').child(event.videoModel.title);
      await videoFilePath.putFile(event.videoFile);
      String videoFileUrl = await videoFilePath.getDownloadURL();
      event.videoModel.videoURL = videoFileUrl;

      videoModel = event.videoModel;
      await videoAddRepository.addVideoREPO(
        videoModel: videoModel,
      );
      // emit(MyVideoLoadedState(myVideos: myVideos));
    } catch (e) {
      emit(VideoErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  // void _deleteMyVideo() async {}
}
