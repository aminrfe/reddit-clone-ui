import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';

class PostItem extends StatelessWidget {
  PostItem(this.post, this.currentUser, this.changeUpVotes,
      this.changeDownVotes, this.savePost);

  final PostModel post;
  final UserModel currentUser;
  final Function changeUpVotes;
  final Function changeDownVotes;
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
                    size: 40,
                    color: Colors.black54,
                  ),
                  title: Text(
                    'r/' + post.forum.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'u/' +
                        post.user.username +
                        ' . ' +
                        DateFormat('yyyy-MM-dd – kk:mm').format(post.date),
                    style: const TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child:
                          Text(post.desc, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                              : const Icon(Icons.arrow_upward, color: Colors.black),
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
                              : const Icon(Icons.arrow_downward, color: Colors.black),
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
            )),
        onTap: () {
          //ToDo: Navigate to post deatails page
        },
      ),
    );
  }
}
