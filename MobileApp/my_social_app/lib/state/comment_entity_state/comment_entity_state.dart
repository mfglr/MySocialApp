import 'package:flutter/material.dart';
import 'package:my_social_app/state/entity_state.dart';
import 'package:my_social_app/state/comment_entity_state/comment_state.dart';

@immutable
class CommentEntityState extends EntityState<CommentState>{
  const CommentEntityState({required super.entities});

  CommentEntityState getNextPageLikes(int commentId)
    => CommentEntityState(entities: updateOne(entities[commentId]!.getNextPageLikes()));
  CommentEntityState addNextPageLikes(int commentId, Iterable<int> nextIds)
    => CommentEntityState(entities: updateOne(entities[commentId]!.addNextPageLikes(nextIds)));
  CommentEntityState like(int commentId, int userId)
    => CommentEntityState(entities: updateOne(entities[commentId]!.like(userId)));
  CommentEntityState dislike(int commentId, int userId)
    => CommentEntityState(entities: updateOne(entities[commentId]!.dislike(userId)));
  
  CommentEntityState nextPageReplies(int commentId)
    => CommentEntityState(entities: updateOne(entities[commentId]!.nextPageReplies()));
  CommentEntityState addNextPageReplies(int commentId,Iterable<int> replyIds)
    => CommentEntityState(entities: updateOne(entities[commentId]!.addNextPageReplies(replyIds)));
  CommentEntityState addReply(int commentId, int replyId)
    => CommentEntityState(entities: updateOne(entities[commentId]!.addReply(replyId)));

  
  CommentEntityState changeVisibility(int commentId,bool visibility)
    => CommentEntityState(entities: updateOne(entities[commentId]!.changeVisibility(visibility)));
}