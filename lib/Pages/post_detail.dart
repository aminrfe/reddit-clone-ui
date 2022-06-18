import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Items/post_item_detail.dart';
import '../Models/forum_model.dart';
import '../Models/post_model.dart';
import '../Models/user_model.dart';

import '../data.dart';

class PostDetail extends StatefulWidget {
  PostDetail({Key key, this.currentPost}) : super(key: key);
  final PostModel currentPost;
  final UserModel currentUser = Data().currentUser;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  void changeUpVotes(PostModel post) {
    setState(() {
      if (post.upvotes.contains(widget.currentUser)) {
        post.upvotes.remove(widget.currentUser);
      } else if (post.downvotes.contains(widget.currentUser)) {
        post.downvotes.remove(widget.currentUser);
        post.upvotes.add(widget.currentUser);
      } else {
        post.upvotes.add(widget.currentUser);
      }
    });
  }

  void changeDownVotes(PostModel post) {
    setState(() {
      if (post.downvotes.contains(widget.currentUser)) {
        post.downvotes.remove(widget.currentUser);
      } else if (post.upvotes.contains(widget.currentUser)) {
        post.upvotes.remove(widget.currentUser);
        post.downvotes.add(widget.currentUser);
      } else {
        post.downvotes.add(widget.currentUser);
      }
    });
  }

  void savePost(PostModel post) {
    setState(() {
      widget.currentUser.addSavedPost(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrange,
                  Colors.orangeAccent,
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          PostItem(
              widget.currentPost,
              () => changeDownVotes(widget.currentPost),
              () => changeUpVotes(widget.currentPost),
              () => savePost(widget.currentPost))
        ],
      ),
    );
  }
}
