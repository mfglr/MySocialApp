import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_social_app/constants/record_per_page.dart';
import 'package:my_social_app/state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/pagination.dart';
part 'comment.g.dart';

@immutable
@JsonSerializable()
class Comment{
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final int appUserId;
  final bool isEdited;
  final String content;
  final bool isLiked;
  final int numberOfLikes;
  final int numberOfReplies;
  final int? questionId;
  final int? solutionId;
  final int? parentId;

  const Comment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.appUserId,
    required this.isEdited,
    required this.content,
    required this.isLiked,
    required this.numberOfLikes,
    required this.numberOfReplies,
    required this.questionId,
    required this.solutionId,
    required this.parentId
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  CommentState toCommentState()
    => CommentState(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      appUserId: appUserId,
      userName: userName,
      questionId: questionId,
      isEdited: isEdited,
      content: content,
      numberOfLikes: numberOfLikes,
      isLiked: isLiked,
      likes: Pagination.init(usersPerPage),
      replies: Pagination.init(commentsPerPage),
      numberOfReplies: numberOfReplies,
      parentId: parentId,
      solutionId: solutionId,
      repliesVisibility: false,
      numberOfDisplayReplies: 0
    );

}