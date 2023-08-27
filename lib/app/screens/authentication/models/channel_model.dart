// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:youtube_clone/app/common/models/video_model.dart';

class ChannelModel {
  final String id;
  final String uid;
  final String userUid;
  final String name;
  List<VideoModel> videos;
  String? imagePath;
  List<dynamic>? users;
  ChannelModel({
    required this.id,
    required this.uid,
    required this.userUid,
    required this.name,
    required this.videos,
    this.imagePath,
    this.users,
  });

  ChannelModel copyWith({
    String? id,
    String? uid,
    String? userUid,
    String? name,
    List<VideoModel>? videos,
    String? imagePath,
    List<dynamic>? users,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      userUid: userUid ?? this.userUid,
      name: name ?? this.name,
      videos: videos ?? this.videos,
      imagePath: imagePath ?? this.imagePath,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'userUid': userUid,
      'name': name,
      'videos': videos.map((x) => x.toMap()).toList(),
      'imagePath': imagePath,
      'users': users,
    };
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      userUid: map['userUid'] as String,
      name: map['name'] as String,
      videos: List<VideoModel>.from(
        (map['videos'] as List<int>).map<VideoModel>(
          (x) => VideoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      users: map['users'] != null ? List<dynamic>.from((map['users'] as List<dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelModel.fromJson(String source) => ChannelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelModel(id: $id, uid: $uid, userUid: $userUid, name: $name, videos: $videos, imagePath: $imagePath, users: $users)';
  }

  @override
  bool operator ==(covariant ChannelModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.userUid == userUid &&
        other.name == name &&
        listEquals(other.videos, videos) &&
        other.imagePath == imagePath &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        userUid.hashCode ^
        name.hashCode ^
        videos.hashCode ^
        imagePath.hashCode ^
        users.hashCode;
  }
}
