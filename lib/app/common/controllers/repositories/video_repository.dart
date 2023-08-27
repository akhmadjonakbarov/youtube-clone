// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:youtube_clone/app/common/models/video_model.dart';

import '../services/video_api_service.dart';

class VideoRepository {
  VideoApiService videoApiService;
  VideoRepository({
    required this.videoApiService,
  });
}

class VideoGetRepository extends VideoRepository {
  final VideoGetApiService videoGetApiService;

  VideoGetRepository({
    required this.videoGetApiService,
  }) : super(
          videoApiService: videoGetApiService,
        );
  Future<List<VideoModel>> getVideosREPO() async {
    return await videoGetApiService.getVideosAPI();
  }
}

class VideoAddRepository extends VideoRepository {
  final VideoAddApiService videoAddApiService;

  VideoAddRepository({
    required this.videoAddApiService,
  }) : super(
          videoApiService: videoAddApiService,
        );

  Future<List<VideoModel>> addVideoREPO({required VideoModel videoModel}) async {
    return await videoAddApiService.addVideoAPI(
      videoModel: videoModel,
    );
  }
}

class VideoUpdateViewRepository extends VideoRepository {
  final VideoUpdateViewApiService videoUpdateViewApiService;
  VideoUpdateViewRepository({required this.videoUpdateViewApiService})
      : super(
          videoApiService: videoUpdateViewApiService,
        );

  Future<void> updateVideoViewREPO({required VideoModel videoModel}) async {
    return await videoUpdateViewApiService.updateVideoViewAPI(videoModel: videoModel);
  }
}
