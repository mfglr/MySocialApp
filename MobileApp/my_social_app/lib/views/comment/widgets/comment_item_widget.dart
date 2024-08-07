import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_social_app/state/comment_entity_state/comment_state.dart';
import 'package:my_social_app/state/state.dart';
import 'package:my_social_app/views/user/pages/user_page.dart';
import 'package:my_social_app/views/comment/widgets/comment_content_widget.dart';
import 'package:my_social_app/views/comment/widgets/comment_like_button_widget.dart';
import 'package:my_social_app/views/comment/widgets/comment_reply_items_widget.dart';
import 'package:my_social_app/views/comment/widgets/display_remain_replies_button_widget.dart';
import 'package:my_social_app/views/comment/widgets/display_replies_button_widget.dart';
import 'package:my_social_app/views/comment/widgets/hide_replies_button_widget.dart';
import 'package:my_social_app/views/comment/widgets/reply_comment_button_widget.dart';
import 'package:my_social_app/views/user/widgets/user_image_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItemWidget extends StatelessWidget {
  final TextEditingController contentController;
  final FocusNode focusNode;
  final CommentState comment;
  
  const CommentItemWidget({
    super.key,
    required this.contentController,
    required this.focusNode,
    required this.comment
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPage(userId: comment.appUserId,userName: null,))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: UserImageWidget(userId: comment.appUserId, diameter: 35)
                    ),
                    Text(
                      comment.userName,
                      style: const TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  timeago.format(
                    comment.createdAt,
                    locale: 'en_short'
                  ),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5,bottom: 5),
            child: CommentContentWidget(comment: comment,),
          ),
          Row(
            children:[
              CommentButtonLikeWidget(
                comment: comment,
              ),
              Builder(
                builder: (context){
                  if(comment.numberOfReplies > 0){
                    if(!comment.repliesVisibility){
                      return DisplayRepliesButtonWidget(comment: comment);
                    }
                    return HideRepliesButtonWidget(comment: comment);
                  }
                  return const SizedBox.shrink();
                }
              ),
              ReplyCommentButtonWidget(
                contentController: contentController,
                focusNode: focusNode,
                comment: comment,
                isRoot: true,
              )
            ]
          ),
          Builder(
            builder: (context){
              if(comment.repliesVisibility){
                return StoreConnector<AppState,Iterable<CommentState>>(
                  converter: (store) => store.state.getCommentReplies(comment.id),
                  builder: (context,replies){
                    return Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: CommentReplyItemsWidget(
                        contentController: contentController,
                        focusNode: focusNode,
                        replies: replies,
                      )
                    );
                  }
                );
              }
              return const SizedBox.shrink();
            }
          ),
          Builder(
            builder: (context){
              if(comment.repliesVisibility){
                return Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      HideRepliesButtonWidget(comment: comment,),
                      Builder(
                        builder: (context) {
                          if(comment.numberOfNotDisplayedReplies > 0){
                            return DisplayRemainRepliesButtonWidget(comment: comment);
                          }
                          return const SizedBox.shrink();
                        }
                      )
                    ]
                  ),
                );
              }
              return const SizedBox.shrink();
            }
          )
        ],
      ),
    );
  }
}