import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/post_model.dart';
import '../Models/user_model.dart';
import '../data.dart';

class PostItem extends StatelessWidget {
  PostItem(this.post, this.changeDownVotes, this.changeUpVotes, this.savePost,
      this.addComment);

  final UserModel currentUser = Data().currentUser;
  final PostModel post;
  final Function changeUpVotes;
  final Function changeDownVotes;
  final Function savePost;
  final Function addComment;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'u/' +
                post.user.username +
                ' . ' +
                DateFormat('yyyy-MM-dd – kk:mm').format(post.date),
            style: const TextStyle(fontSize: 14, color: Colors.black45),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(
                  0.0,
                  1.0,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 14.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                    child: Text(post.title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child:
                          Text(post.desc, style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
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
                              : const Icon(Icons.arrow_upward),
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
                          onPressed: () {
                            addComment(post.comments);
                          
                          },
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
