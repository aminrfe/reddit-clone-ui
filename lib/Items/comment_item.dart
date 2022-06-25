import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/comment_model.dart';
import '../Models/user_model.dart';
import '../data.dart';

class CommentItem extends StatefulWidget {
  CommentItem(
      this.comments, this.changeDownVotes, this.changeUpVotes, this.addComment);

  final UserModel currentUser = Data().currentUser;
  final List<CommentModel> comments;
  final Function changeDownVotes;
  final Function changeUpVotes;
  final Function addComment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.comments.length,
      itemBuilder: (context, index) {
        CommentModel comment = widget.comments[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              ),
            ],
          ),
          child: Column(children: [
            ListTile(
              horizontalTitleGap: 5,
              leading: const Icon(
                Icons.account_circle_rounded,
                size: 35,
                color: Colors.black54,
              ),
              title: Text(
                comment.user.username + ' . ' + timeAgo(comment.date),
                style: const TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(comment.comment,
                        style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                children: [
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       padding: EdgeInsets.zero,
                  //       constraints: BoxConstraints(),
                  //       splashColor: Colors.transparent,
                  //       highlightColor: Colors.transparent,
                  //       icon: Icon(Icons.reply_rounded, size: 20),
                  //       onPressed: () {
                  //         widget.addComment(comment.replies);
                  //       },
                  //     ),
                  //     Text(
                  //       "reply",
                  //       style: TextStyle(fontSize: 13),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(width: 10),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: comment.upvotes.contains(widget.currentUser)
                        ? const Icon(Icons.arrow_upward,
                            color: Colors.deepOrange, size: 20)
                        : const Icon(Icons.arrow_upward,
                            color: Colors.black, size: 20),
                    onPressed: () {
                      widget.changeUpVotes(comment);
                    },
                  ),
                  Text((comment.upvotes.length - comment.downvotes.length)
                      .toString()),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: comment.downvotes.contains(widget.currentUser)
                        ? const Icon(Icons.arrow_downward,
                            color: Colors.purple, size: 20)
                        : const Icon(Icons.arrow_downward,
                            color: Colors.black, size: 20),
                    onPressed: () {
                      widget.changeDownVotes(comment);
                    },
                  ),
                ],
              ),
            ]),
            // (comment.replies != null && comment.replies.isNotEmpty)
            //     ? Column(
            //         children: [
            //           Divider(
            //             color: Colors.grey,
            //           ),
            //           CommentItem(
            //             comment.replies,
            //             widget.changeDownVotes,
            //             widget.changeUpVotes,
            //           ),
            //         ],
            //       )
            //     : Container(),
          ]),
        );
      },
    );
  }
}
