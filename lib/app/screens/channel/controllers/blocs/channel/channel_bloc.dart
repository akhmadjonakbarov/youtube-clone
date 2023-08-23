import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../authentication/models/channel_model.dart';

part 'channel_event.dart';

part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ChannelBloc() : super(ChannelInitial()) {
    on<GetChannelEvent>(_getChannel);
    on<AddChannelEvent>(_addChannel);
    on<DeleteChannelEvent>(_deleteChannel);
  }

  _getChannel(GetChannelEvent event, Emitter<ChannelState> emit) async {
    ChannelModel channelModel;
    try {
      emit(ChannelLoadingState());
      QuerySnapshot channels = await _db
          .collection('users')
          .doc(event.userUid)
          .collection('channels')
          .get();
      channelModel = ChannelModel.fromSnapShot(channels.docs.first);
      emit(ChannelLoadedState(channelModel: channelModel));
    } catch (e) {
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }

  _addChannel(AddChannelEvent event, Emitter<ChannelState> emit) async {
    ChannelModel channelModel;
    int channelsCount = 0;
    try {
      emit(ChannelLoadingState());
      DocumentReference refChannel = await _db
          .collection('users')
          .doc(event.userUid)
          .collection('channels')
          .add(event.channelModel.toMap());

      refChannel.update({'uid': refChannel.id});
      DocumentSnapshot newChannel = await refChannel.get();
      channelModel = ChannelModel.fromSnapShot(newChannel);
      emit(ChannelLoadedState(channelModel: channelModel));
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
      await _db
          .collection('users')
          .doc(event.userUid)
          .collection('channels')
          .doc(event.channelId)
          .delete();
    } catch (e) {
      emit(ChannelErrorState(
        errorMsg: e.toString(),
      ));
    }
  }
}
