import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/constants/app_style.dart';

import '../../common/controllers/blocs/channel/channel_bloc.dart';
import '../../common/widgets/header.dart';
import 'widgets/video_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ChannelBloc>().add(ChannelsGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Header(),
          BlocBuilder<ChannelBloc, ChannelState>(
            builder: (context, state) {
              if (state is ChannelLoadingState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ChannelLoadedState) {
                return state.channels.isNotEmpty
                    ? ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ChannelModel channelModel = state.channels[index];
                          return VideoTile(
                            channelModel: channelModel,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: state.channels.length,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.sizeOf(context).height * 0.35,
                        ),
                        child: Center(
                          child: Text(
                            'Videos don\'t exist!',
                            style: AppStyle.latoStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
              } else if (state is ChannelErrorState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.35,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Text('There is some error!, Please try again later!'),
                      ),
                      Center(
                        child: Text('${state.errorMsg}'),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
