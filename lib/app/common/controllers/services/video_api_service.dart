import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';
import 'package:youtube_clone/constants/api_url.dart';

class VideoApiService {
  Dio dio = Dio();
  String vidoesURL = "videos";
}

class VideoGetApiService extends VideoApiService {
  Future<List<VideoModel>> getVideosAPI() async {
    List<VideoModel> videos = [];
    try {
      Response response = await dio.get("$mainURL/$vidoesURL.json");
      if (response.data != null) {
        Map<String, dynamic> videosData = response.data as Map<String, dynamic>;
        videosData.forEach((key, value) {
          videos.add(
            VideoModel(
                uid: key,
                userUid: value['userUid'],
                id: value['id'],
                title: value['title'],
                description: value['description'],
                videoURL: value['videoURL'],
                channelUid: value['channelUid'],
                views: value['views']),
          );
        });
      }
      log("Videos were got");
    } catch (e) {
      log("APIVIDEOGET: $e");
      rethrow;
    }
    return videos;
  }
}

class VideoAddApiService extends VideoApiService {
  Future addVideoAPI({required VideoModel videoModel}) async {
    try {
      await dio.post(
        '$mainURL/$vidoesURL.json',
        data: videoModel.toMap(),
      );
      log("Video was added");
    } catch (e) {
      log("APIVIDEOADD: $e");
      rethrow;
    }
  }
}

class VideoUpdateViewApiService extends VideoApiService {
  Future updateVideoViewAPI({required VideoModel videoModel}) async {
    log(videoModel.toString());
    try {
      await dio.patch(
        '$mainURL/$vidoesURL/${videoModel.uid}.json',
        data: videoModel.toMap(),
      );
      log("View was updated");
    } catch (e) {
      log("APIVIDEOVIEWUPDATE: $e");
      rethrow;
    }
  }
}
