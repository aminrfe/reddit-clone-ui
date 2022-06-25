import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Pages/post_detail.dart';
import '../data.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';

class PostItem extends StatelessWidget {
  PostItem(this.post, this.changeUpVotes, this.changeDownVotes, this.savePost,
      this.refresh);

  final UserModel currentUser = Data().currentUser;
  final PostModel post;
  final Function changeUpVotes;
  final Function changeDownVotes;
  final Function savePost;
  final Function refresh;

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      child: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  horizontalTitleGap: 5,
                  leading: const Icon(
                    Icons.account_circle_rounded,
                    size: 35,
                    color: Colors.black54,
                  ),
                  title: Text(
                    'r/' + post.forum.name,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'u/' + post.user.username + ' . ' + timeAgo(post.date),
                    style: const TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(post.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: post.upvotes.contains(currentUser)
                              ? const Icon(Icons.arrow_upward,
                                  color: Colors.deepOrange)
                              : const Icon(Icons.arrow_upward,
                                  color: Colors.black),
                          onPressed: () {
                            changeUpVotes();
                          },
                        ),
                        Text((post.upvotes.length - post.downvotes.length)
                            .toString()),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: post.downvotes.contains(currentUser)
                              ? const Icon(Icons.arrow_downward,
                                  color: Colors.purple)
                              : const Icon(Icons.arrow_downward,
                                  color: Colors.black),
                          onPressed: () {
                            changeDownVotes();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: const Icon(Icons.mode_comment_outlined),
                          onPressed: () {},
                        ),
                        Text(post.comments.length.toString()),
                      ],
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: currentUser.savedPosts.contains(post)
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border),
                      onPressed: () {
                        savePost();
                      },
                    ),
                  ],
                ),
              ],
            )),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PostDetail(currentPost: post);
          })).then(refresh);
        },
      ),
    );
  }
}
