import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                  'u/' +
                      post.user.username +
                      ' . ' +
                      DateFormat('yyyy-MM-dd – kk:mm').format(post.date),
                  style: const TextStyle(fontSize: 15, color: Colors.black45),
                ),
                trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      if (currentUser.username == forum.admin.username) {
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
                      }
                    }),
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(post.desc,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
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
          //TODO: Navigate to post details page
        },
      ),
    );
  }
}
