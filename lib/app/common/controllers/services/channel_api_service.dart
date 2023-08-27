import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:youtube_clone/app/common/models/video_model.dart';
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';

import '../../../../constants/api_url.dart';

class ChannelApiService {
  final Dio dio = Dio();
  final String channelURL = "channels";
}

class ChannelGetApiService extends ChannelApiService {
  Future<List<ChannelModel>> getChannelsAPI() async {
    List<ChannelModel> channels = [];

    try {
      Response response = await dio.get("$mainURL/$channelURL.json");
      if (response.data != null) {
        Map<String, dynamic> channelsData = response.data as Map<String, dynamic>;
        channelsData.forEach((key, channelData) {
          channels.add(
            ChannelModel(
              uid: key,
              id: channelData['id'],
              name: channelData['name'],
              userUid: channelData['userUid'],
              imagePath: channelData['imagePath'],
              videos: [],
              users: [],
            ),
          );
        });
      }
      log("Channels were got");
    } catch (e) {
      log("APIChannelGET: $e");
      rethrow;
    }
    return channels;
  }
}

class ChannelAddApiService extends ChannelApiService {
  Future addChannelAPI({required ChannelModel channelModel}) async {
    try {
      await dio.post(
        '$mainURL/$channelURL.json',
        data: channelModel.toMap(),
      );
      log("Channel was added");
    } catch (e) {
      log("APIChannelADD: $e");
      rethrow;
    }
  }
}
