import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';
import 'package:youtube_clone/app/common/controllers/repositories/channel_repostirory.dart';
import 'package:youtube_clone/app/common/controllers/services/channel_api_service.dart';

import '../../../../screens/authentication/models/channel_model.dart';
import '../../repositories/video_repository.dart';
import '../../services/video_api_service.dart';

part 'channel_event.dart';

part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ChannelBloc() : super(ChannelInitial()) {
    on<ChannelsGetEvent>(_getChannels);
    on<GetChannelEvent>(_getChannel);
    on<AddChannelEvent>(_addChannel);
    on<DeleteChannelEvent>(_deleteChannel);
  }

  _getChannels(ChannelsGetEvent event, Emitter<ChannelState> emit) async {
    ChannelGetRepository channelGetRepository = ChannelGetRepository(
      channelGetApiService: ChannelGetApiService(),
    );
    VideoGetRepository videoGetRepository = VideoGetRepository(
      videoGetApiService: VideoGetApiService(),
    );

    List<ChannelModel> channels = [];
    List<VideoModel> videos = [];

    try {
      emit(ChannelLoadingState());
      channels = await channelGetRepository.getChannelsREPO();
      videos = await videoGetRepository.getVideosREPO();
      for (ChannelModel channel in channels) {
        for (var video in videos) {
          if (channel.uid == video.channelUid) {
            channel.videos.add(video);
          }
        }
      }
      channels.removeWhere((element) => element.videos.isEmpty);
      emit(ChannelLoadedState(channels: channels));
    } catch (e) {
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  _getChannel(GetChannelEvent event, Emitter<ChannelState> emit) async {
    ChannelGetRepository channelGetRepository = ChannelGetRepository(channelGetApiService: ChannelGetApiService());
    ChannelModel? channelModel;
    List<ChannelModel> channels = [];

    try {
      emit(ChannelLoadingState());
      channels = await channelGetRepository.getChannelsREPO();
      channelModel = channels.firstWhere((element) => element.userUid == event.userUid);
      emit(SingleChannelLoadedState(
        channelModel: channelModel,
      ));
    } catch (e) {
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  Future<ChannelModel> getChannelGlobal({required String userUid}) async {
    ChannelGetRepository channelGetRepository = ChannelGetRepository(channelGetApiService: ChannelGetApiService());
    ChannelModel? channelModel;
    List<ChannelModel> channels = [];

    try {
      channels = await channelGetRepository.getChannelsREPO();
      channelModel = channels.firstWhere((element) => element.userUid == userUid);
    } catch (e) {}
    return channelModel!;
  }

  _addChannel(AddChannelEvent event, Emitter<ChannelState> emit) async {
    ChannelModel channelModel;
    int channelsCount = 0;
    ChannelAddRepository channelAddRepository = ChannelAddRepository(channelAddApiService: ChannelAddApiService());
    try {
      emit(ChannelLoadingState());
      channelModel = event.channelModel;
      channelAddRepository.addChannelREPO(
        channelModel: channelModel,
      );
      // emit(ChannelLoadedState(channelModel: channelModel));
    } catch (e) {
      log('ERROR: $e');
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  _deleteChannel(DeleteChannelEvent event, Emitter<ChannelState> emit) async {
    try {
      // emit(ChannelLoadingState());
      await _db.collection('users').doc(event.userUid).collection('channels').doc(event.channelId).delete();
    } catch (e) {
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }
}
