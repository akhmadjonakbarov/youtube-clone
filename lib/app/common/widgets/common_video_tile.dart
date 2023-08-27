import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';
import 'package:youtube_clone/app/common/widgets/dash_btn.dart';
import 'package:youtube_clone/app/screens/video_detail/video_detail_screen.dart';
import 'package:youtube_clone/constants/app_style.dart';

import '../controllers/blocs/video/video_bloc.dart';

class CommonVideoTile extends StatefulWidget {
  final VideoModel videoModel;
  const CommonVideoTile({super.key, required this.videoModel});

  @override
  State<CommonVideoTile> createState() => _CommonVideoTileState();
}

class _CommonVideoTileState extends State<CommonVideoTile> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   videoPlayerController = VideoPlayerController.network(widget.videoModel.videoURL)
  //     ..initialize().then((value) => setState(() {}));
  //   _customVideoPlayerController = CustomVideoPlayerController(
  //     context: context,
  //     videoPlayerController: videoPlayerController,
  //   );
  // }

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
      widget.videoModel.videoURL,
    ));

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // _controller.setLooping(false);
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: MediaQuery.sizeOf(context).height * 0.12,
      width: double.infinity,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => VideoBloc(),
                    child: VideoDetailScreen(
                      videoModel: widget.videoModel,
                    ),
                  ),
              settings: RouteSettings(
                arguments: widget.videoModel.uid,
              )),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(),
                width: constraints.maxWidth * 0.4,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    Duration videoDuration = _controller.value.duration;
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            VideoPlayer(_controller),
                            Positioned(
                              bottom: 8,
                              right: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '${videoDuration.inMinutes}:${videoDuration.inSeconds}',
                                  style: AppStyle.latoStyle.copyWith(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.5,
                decoration: const BoxDecoration(),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.videoModel.title,
                      overflow: TextOverflow.fade,
                      style: AppStyle.latoStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text('70 views 6 days ago'),
                  ],
                ),
              ),
              DashBTN(
                page: 'videotab',
              )
            ],
          ),
        ),
      ),
    );
  }
}
