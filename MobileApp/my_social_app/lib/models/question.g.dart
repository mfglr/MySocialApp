// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      appUserId: (json['appUserId'] as num).toInt(),
      userName: json['userName'] as String,
      content: json['content'] as String?,
      topics: (json['topics'] as List<dynamic>)
          .map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      exam: Exam.fromJson(json['exam'] as Map<String, dynamic>),
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((e) => QuestionImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLiked: json['isLiked'] as bool,
      numberOfLikes: (json['numberOfLikes'] as num).toInt(),
      numberOfSolutions: (json['numberOfSolutions'] as num).toInt(),
      numberOfComments: (json['numberOfComments'] as num).toInt(),
      isOwner: json['isOwner'] as bool,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'appUserId': instance.appUserId,
      'userName': instance.userName,
      'content': instance.content,
      'exam': instance.exam,
      'subject': instance.subject,
      'topics': instance.topics,
      'images': instance.images,
      'isLiked': instance.isLiked,
      'numberOfLikes': instance.numberOfLikes,
      'numberOfSolutions': instance.numberOfSolutions,
      'numberOfComments': instance.numberOfComments,
      'isOwner': instance.isOwner,
    };
