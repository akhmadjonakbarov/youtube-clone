import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/constants/app_style.dart';

import '../../../../common/controllers/blocs/video/video_bloc.dart';
import '../../../../common/widgets/common_video_tile.dart';

class VideoTab extends StatefulWidget {
  final ChannelModel channelModel;
  const VideoTab({
    super.key,
    required this.channelModel,
  });

  @override
  State<VideoTab> createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void didChangeDependencies() {
    context.read<VideoBloc>().add(
          VideosGetEvent(
            userUid: _user!.uid,
            channelUid: widget.channelModel.uid,
          ),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VideoLoadedState) {
              if (state.videos.isNotEmpty) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  itemBuilder: (context, index) {
                    VideoModel videoModel = state.videos[index];

                    return CommonVideoTile(
                      videoModel: videoModel,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: state.videos.length,
                );
              } else {
                return Center(
                  child: Text(
                    'Videos don\'t exist',
                    style: AppStyle.latoStyle,
                  ),
                );
              }
            } else if (state is VideoErrorState) {
              return Center(
                child: Text(state.errorMsg),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
