import 'package:flutter/material.dart';
import 'package:my_social_app/state/comment_entity_state/actions.dart';
import 'package:my_social_app/state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/store.dart';

class DisplayRepliesButtonWidget extends StatelessWidget {
  final CommentState comment;
  const DisplayRepliesButtonWidget({super.key,required this.comment});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        store.dispatch(NextPageRepliesIfNoReplies(commentId: comment.id));
        store.dispatch(ChangeRepliesVisibilityAction(commentId: comment.id, visibility: true));
      },
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: const Icon(Icons.reply)
          ),
          Text(comment.numberOfReplies.toString())
        ],
      ),
    );
  }
}