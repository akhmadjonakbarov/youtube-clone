// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:youtube_clone/app/screens/authentication/models/channel_model.dart';
import 'package:youtube_clone/app/common/controllers/services/channel_api_service.dart';

class ChannelRepository {
  ChannelApiService channelApiService;
  ChannelRepository({
    required this.channelApiService,
  });
}

class ChannelGetRepository extends ChannelRepository {
  final ChannelGetApiService channelGetApiService;

  ChannelGetRepository({
    required this.channelGetApiService,
  }) : super(
          channelApiService: channelGetApiService,
        );
  Future<List<ChannelModel>> getChannelsREPO() async {
    return await channelGetApiService.getChannelsAPI();
  }
}

class ChannelAddRepository extends ChannelRepository {
  final ChannelAddApiService channelAddApiService;

  ChannelAddRepository({
    required this.channelAddApiService,
  }) : super(
          channelApiService: channelAddApiService,
        );

  Future<void> addChannelREPO({required ChannelModel channelModel}) async {
    return await channelAddApiService.addChannelAPI(channelModel: channelModel);
  }
}
