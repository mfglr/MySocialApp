// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isOwner: json['isOwner'] as bool,
      isEdited: json['isEdited'] as bool,
      conversationId: (json['conversationId'] as num).toInt(),
      ownerId: (json['ownerId'] as num).toInt(),
      content: json['content'] as String?,
      state: (json['state'] as num).toInt(),
      images: (json['images'] as List<dynamic>)
          .map((e) => MessageImage.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isOwner': instance.isOwner,
      'isEdited': instance.isEdited,
      'conversationId': instance.conversationId,
      'ownerId': instance.ownerId,
      'content': instance.content,
      'state': instance.state,
      'images': instance.images.toList(),
    };