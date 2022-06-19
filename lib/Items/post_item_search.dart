import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';

class PostItem extends StatelessWidget {
  PostItem(this.post, this.close);

  final UserModel currentUser = Data().currentUser;
  final PostModel post;
  final Function close;

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
              child: Column(children: [
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
                    'u/' +
                        post.user.username +
                        ' . ' +
                        DateFormat('yyyy-MM-dd – kk:mm').format(post.date),
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
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                            (post.upvotes.length - post.downvotes.length)
                                    .toString() +
                                " Upvotes  -  " +
                                post.comments.length.toString() +
                                " Comments",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                      ),
                    ],
                  ),
                )
              ])),
          onTap: close,
        ));
  }
}
