import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/app/screens/video_detail/video_detail_screen.dart';

import '../../../../constants/app_style.dart';
import '../../../common/controllers/blocs/video/video_bloc.dart';
import '../../../common/widgets/dash_btn.dart';

class VideoTile extends StatefulWidget {
  final ChannelModel channelModel;
  const VideoTile({super.key, required this.channelModel});

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _controller;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    if (widget.channelModel.videos.isNotEmpty) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.channelModel.videos.first.videoURL,
      ));
      _initializeVideoPlayerFuture = _controller.initialize();
    }
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
    return widget.channelModel.videos.isNotEmpty
        ? Ink(
            decoration: const BoxDecoration(),
            child: InkWell(
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => VideoBloc(),
                  child: VideoDetailScreen(
                    videoModel: widget.channelModel.videos.first,
                  ),
                ),
              )),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.green,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.channelModel.videos.first.title,
                                  style: AppStyle.latoStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  '${widget.channelModel.name} ${widget.channelModel.videos.first.views} views 2 weaks age ',
                                  style: AppStyle.latoStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                        DashBTN(
                          page: 'homepage',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
