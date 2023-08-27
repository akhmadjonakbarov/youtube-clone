// ignore_for_file: deprecated_member_use

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';

import '../../common/controllers/blocs/video/video_bloc.dart';

class VideoDetailScreen extends StatefulWidget {
  bool isMyChannel;
  final VideoModel videoModel;

  VideoDetailScreen({
    super.key,
    required this.videoModel,
    this.isMyChannel = false,
  });

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  // bool getVideo = true;

  @override
  void initState() {
    context.read<VideoBloc>().add(VideoGetEvent(
          uid: widget.videoModel.uid,
        ));
    videoPlayerController = VideoPlayerController.network(
      widget.videoModel.videoURL,
    )..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
    videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SingleVideoLoadedState) {
              return Column(
                children: [
                  videoPlayerController.value.isInitialized == true
                      ? CustomVideoPlayer(
                          customVideoPlayerController: _customVideoPlayerController,
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: MediaQuery.sizeOf(context).height * 0.3,
                          child: const CircularProgressIndicator(),
                        )
                ],
              );
            } else if (state is VideoErrorState) {
              return Center(
                child: Text('Xatolik! Iltimos keyinroq urunib ko\'ring! \n ${state.errorMsg}'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
