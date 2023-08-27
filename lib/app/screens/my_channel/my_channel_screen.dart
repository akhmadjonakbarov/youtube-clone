import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/app/screens/my_channel/tabs/home/home_tab.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../common/controllers/blocs/video/video_bloc.dart';
import 'tabs/video/video_tab.dart';

class MyChannelBlocWrapper extends StatelessWidget {
  final ChannelModel channelModel;
  const MyChannelBlocWrapper({super.key, required this.channelModel});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VideoBloc(),
        ),
      ],
      child: MyChannelScreen(channelModel: channelModel),
    );
  }
}

class MyChannelScreen extends StatefulWidget {
  final ChannelModel? channelModel;

  const MyChannelScreen({super.key, this.channelModel});

  @override
  State<MyChannelScreen> createState() => _MyChannelScreenState();
}

class _MyChannelScreenState extends State<MyChannelScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.black,
            unselectedLabelColor: AppColors.greyColor,
            labelColor: Colors.black,
            isScrollable: true,
            labelStyle: AppStyle.latoStyle.copyWith(fontSize: 16),
            tabs: [
              _customTab(title: 'home'),
              _customTab(title: 'videos'),
              _customTab(title: 'playlist'),
              _customTab(title: 'community'),
              _customTab(title: 'About'),
            ],
          ),
          title: Text(
            widget.channelModel!.name,
            style: AppStyle.latoStyle.copyWith(color: Colors.black),
          ),
          leading: Ink(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            physics: ScrollPhysics(),
            children: [
              HomeTab(),
              VideoTab(
                channelModel: widget.channelModel!,
              ),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTab({required String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        title.toUpperCase(),
      ),
    );
  }
}
