part of 'channel_bloc.dart';

@immutable
abstract class ChannelState {}

class ChannelInitial extends ChannelState {}

class ChannelLoadingState extends ChannelState {}

class ChannelLoadedState extends ChannelState {
  final ChannelModel channelModel;

  ChannelLoadedState({required this.channelModel});
}

class ChannelErrorState extends ChannelState {
  final String errorMsg;

  ChannelErrorState({required this.errorMsg});
}
