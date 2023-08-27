// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'channel_bloc.dart';

@immutable
abstract class ChannelState {}

class ChannelInitial extends ChannelState {}

class ChannelLoadingState extends ChannelState {}

class ChannelLoadedState extends ChannelState {
  List<ChannelModel> channels;

  ChannelLoadedState({required this.channels});
}

class SingleChannelLoadedState extends ChannelState {
  ChannelModel channelModel;
  SingleChannelLoadedState({
    required this.channelModel,
  });
}

class ChannelErrorState extends ChannelState {
  final String errorMsg;

  ChannelErrorState({required this.errorMsg});
}
