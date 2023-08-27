import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/controllers/blocs/channel/channel_bloc.dart';
import '../../common/controllers/blocs/video/video_bloc.dart';
import '../../common/models/video_model.dart';
import '../authentication/models/channel_model.dart';

class VideoUploadScreen extends StatefulWidget {
  const VideoUploadScreen({
    super.key,
  });

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  FirebaseAuth _auth = FirebaseAuth.instance;

  VideoModel videoModel = VideoModel(
    uid: "",
    userUid: "",
    id: UniqueKey().toString(),
    title: "",
    description: " ",
    videoURL: "",
    channelUid: "",
    views: 0,
  );
  ChannelModel? channelModel;

  File? videoFile;
  final _videoUploadFormKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getChannel();
  }

  void getChannel() async {
    channelModel = await context.read<ChannelBloc>().getChannelGlobal(userUid: _auth.currentUser!.uid);
    setState(() {});
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  void _submit() async {
    // bool isValid = _videoUploadFormKey.currentState!.validate();
    // if (isValid) {
    if (videoFile != null && channelModel != null) {
      _videoUploadFormKey.currentState!.save();
      videoModel.userUid = _auth.currentUser!.uid;
      videoModel.channelUid = channelModel!.uid;

      context.read<VideoBloc>().add(
            VideoAddEvent(
              videoModel: videoModel,
              videoFile: videoFile!,
            ),
          );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: _videoUploadFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Video title",
                  ),
                  onSaved: (videoTitle) {
                    videoModel = VideoModel(
                      uid: videoModel.uid,
                      userUid: videoModel.uid,
                      id: UniqueKey().toString(),
                      title: videoTitle!,
                      description: videoModel.description,
                      videoURL: videoModel.videoURL,
                      channelUid: videoModel.channelUid,
                      views: videoModel.views,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Video description",
                  ),
                  onSaved: (videoDesc) {
                    videoModel = VideoModel(
                      uid: videoModel.uid,
                      userUid: videoModel.uid,
                      id: UniqueKey().toString(),
                      title: videoModel.title,
                      description: videoDesc!,
                      videoURL: videoModel.videoURL,
                      channelUid: videoModel.channelUid,
                      views: videoModel.views,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Ink(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (videoFile == null) {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                        if (result == null) return;
                        setState(() {
                          videoFile = File(result.files.single.path!);
                          _controller = VideoPlayerController.file(videoFile!);
                          _initializeVideoPlayerFuture = _controller.initialize();
                        });
                      }
                      return;
                    },
                    child: videoFile != null
                        ? FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the video.
                                return AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  // Use the VideoPlayer widget to display the video.
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      VideoPlayer(_controller),
                                      Positioned(
                                        bottom: 15,
                                        child: Row(
                                          children: [
                                            Ink(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _controller.seekTo(
                                                        Duration(seconds: _controller.value.aspectRatio.toInt() + 10));
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.back_hand,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Ink(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (_controller.value.isPlaying) {
                                                      _controller.pause();
                                                    } else {
                                                      _controller.play();
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        : Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text('Select video file'),
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    'Upload',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
