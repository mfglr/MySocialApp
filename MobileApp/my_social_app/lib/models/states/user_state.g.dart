// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) => UserState(
      json['id'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['updatedDAt'] == null
          ? null
          : DateTime.parse(json['updatedDAt'] as String),
      json['userName'] as String,
      json['name'] as String?,
      (json['gender'] as num).toInt(),
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      (json['profileVisibility'] as num).toInt(),
      (json['numberOfPosts'] as num).toInt(),
      (json['numberOfFollowers'] as num).toInt(),
      (json['numberOfFolloweds'] as num).toInt(),
      bool.parse(json['isFollower'].toString(),caseSensitive: false),
      bool.parse(json['isFollowed'].toString(),caseSensitive: false),
    );

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedDAt': instance.updatedDAt?.toIso8601String(),
      'userName': instance.userName,
      'name': instance.name,
      'birthDate': instance.birthDate?.toIso8601String(),
      'profileVisibility': instance.profileVisibility,
      'gender': instance.gender,
      'numberOfPosts': instance.numberOfPosts,
      'numberOfFollowers': instance.numberOfFollowers,
      'numberOfFolloweds': instance.numberOfFolloweds,
      'isFollower': instance.isFollower,
      'isFollowed': instance.isFollowed,
    };
