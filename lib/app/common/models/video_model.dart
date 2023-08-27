// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VideoModel {
  final String uid;
  String channelUid;
  String userUid;
  final String id;
  final String title;
  final String description;
  String videoURL;
  int views;
  VideoModel({
    required this.uid,
    required this.channelUid,
    required this.userUid,
    required this.id,
    required this.title,
    required this.description,
    required this.videoURL,
    required this.views,
  });

  VideoModel copyWith({
    String? uid,
    String? channelUid,
    String? userUid,
    String? id,
    String? title,
    String? description,
    String? videoURL,
    int? views,
  }) {
    return VideoModel(
      uid: uid ?? this.uid,
      channelUid: channelUid ?? this.channelUid,
      userUid: userUid ?? this.userUid,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoURL: videoURL ?? this.videoURL,
      views: views ?? this.views,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'channelUid': channelUid,
      'userUid': userUid,
      'id': id,
      'title': title,
      'description': description,
      'videoURL': videoURL,
      'views': views,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      uid: map['uid'] as String,
      channelUid: map['channelUid'] as String,
      userUid: map['userUid'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      videoURL: map['videoURL'] as String,
      views: map['views'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(uid: $uid, channelUid: $channelUid, userUid: $userUid, id: $id, title: $title, description: $description, videoURL: $videoURL, views: $views)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.channelUid == channelUid &&
        other.userUid == userUid &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.videoURL == videoURL &&
        other.views == views;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        channelUid.hashCode ^
        userUid.hashCode ^
        id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        videoURL.hashCode ^
        views.hashCode;
  }
}
