// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChannelModel {
  final String id;
  final String uid;
  final String name;
  String? imagePath;
  List? users;

  ChannelModel({
    required this.id,
    required this.uid,
    required this.name,
    this.imagePath,
    this.users,
  });

  ChannelModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? imagePath,
    List? users,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'imagePath': imagePath,
      'users': users,
    };
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      id: map['id'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      imagePath: map['imagePath'] as String,
      users: List.from((map['users'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelModel.fromJson(String source) =>
      ChannelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ChannelModel.fromSnapShot(DocumentSnapshot snapshot) {
    return ChannelModel(
      id: "",
      uid: snapshot.id,
      name: snapshot['name'],
      imagePath: snapshot['imagePath'] ?? "",
      users: [],
    );
  }

  @override
  String toString() {
    return 'ChannelModel(id: $id, uid: $uid, name: $name, users: $users)';
  }

  @override
  bool operator ==(covariant ChannelModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.name == name &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^ uid.hashCode ^ name.hashCode ^ users.hashCode;
  }
}
