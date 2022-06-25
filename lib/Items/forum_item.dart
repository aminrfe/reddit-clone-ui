import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddit_clone_ui/Pages/post_detail.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';
import '/Models/forum_model.dart';

class ForumItem extends StatelessWidget {
  ForumItem(this.post, this.currentUser, this.forum, this.changeUpVotes,
      this.changeDownVotes, this.removePost, this.savePost);

  final PostModel post;
  final UserModel currentUser;
  final ForumModel forum;
  final Function changeUpVotes;
  final Function changeDownVotes;
  final Function removePost;
  final Function savePost;

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
                offset: const Offset(
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
                title: Text(
                  'u/' + post.user.username + ' . ' + timeAgo(post.date),
                  style: const TextStyle(fontSize: 15, color: Colors.black45),
                ),
                trailing: (currentUser.username == forum.admin.username)
                    ? IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          removePost();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        })
                    : null,
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(post.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                        icon: const Icon(Icons.mode_comment_outlined),
                        onPressed: () {},
                      ),
                      Text(post.comments.length.toString()),
                    ],
                  ),
                  IconButton(
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
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PostDetail(currentPost: post);
          }));
        },
      ),
    );
  }
}
