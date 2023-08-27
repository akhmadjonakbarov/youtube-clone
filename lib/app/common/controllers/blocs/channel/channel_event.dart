part of 'channel_bloc.dart';

@immutable
abstract class ChannelEvent {}

class GetChannelEvent extends ChannelEvent {
  final String userUid;
  final String channelId;

  GetChannelEvent({required this.userUid, required this.channelId});
}

class ChannelsGetEvent extends ChannelEvent {}

class AddChannelEvent extends ChannelEvent {
  final String userUid;
  final ChannelModel channelModel;

  AddChannelEvent({required this.userUid, required this.channelModel});
}

class DeleteChannelEvent extends ChannelEvent {
  final String channelId;
  final String userUid;

  DeleteChannelEvent({required this.userUid, required this.channelId});
}
