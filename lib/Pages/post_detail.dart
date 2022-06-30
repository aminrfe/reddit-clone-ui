import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Items/comment_item.dart';
import '../Items/post_item_detail.dart';
import '../Models/comment_model.dart';
import '../Models/forum_model.dart';
import '../Models/post_model.dart';
import '../Models/user_model.dart';

import '../convertor.dart';
import '../data.dart';

class PostDetail extends StatefulWidget {
  PostDetail({Key key, this.currentPost}) : super(key: key);
  final PostModel currentPost;
  final UserModel currentUser = Data().currentUser;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  TextEditingController commentController;
  String dropdownvalue = 'Best';

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void changeUpVotes(PostModel post) async {
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
    String upvotes =
        Convertor.listToString(post.upvotes.map((e) => e.username).toList());
    String downvotes =
        Convertor.listToString(post.downvotes.map((e) => e.username).toList());
    await Data().request('updatePostVotes',
        'id::${post.id}||upvotes::$upvotes||downvotes::$downvotes');
  }

  void changeDownVotes(PostModel post) async {
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
    String upvotes =
        Convertor.listToString(post.upvotes.map((e) => e.username).toList());
    String downvotes =
        Convertor.listToString(post.downvotes.map((e) => e.username).toList());
    await Data().request('updatePostVotes',
        'id::${post.id}||upvotes::$upvotes||downvotes::$downvotes');
  }

  void savePost(PostModel post) async {
    setState(() {
      widget.currentUser.addSavedPost(post);
    });
    String savedPosts = Convertor.listToString(
        widget.currentUser.savedPosts.map((e) => e.id).toList());
    await Data().request('updateUserPosts',
        'username::${widget.currentUser.username}||savedPosts::$savedPosts');
  }

  void changeUpVotesComment(CommentModel comment) async {
    setState(() {
      if (comment.upvotes.contains(widget.currentUser)) {
        comment.upvotes.remove(widget.currentUser);
      } else if (comment.downvotes.contains(widget.currentUser)) {
        comment.downvotes.remove(widget.currentUser);
        comment.upvotes.add(widget.currentUser);
      } else {
        comment.upvotes.add(widget.currentUser);
      }
      sortComments(widget.currentPost.comments, dropdownvalue);
    });

    String upvotes =
        Convertor.listToString(comment.upvotes.map((e) => e.username).toList());
    String downvotes = Convertor.listToString(
        comment.downvotes.map((e) => e.username).toList());
    await Data().request('updateCommentVotes',
        'id::${comment.id}||upvotes::$upvotes||downvotes::$downvotes');
  }

  void changeDownVotesComment(CommentModel comment) async {
    setState(() {
      if (comment.downvotes.contains(widget.currentUser)) {
        comment.downvotes.remove(widget.currentUser);
      } else if (comment.upvotes.contains(widget.currentUser)) {
        comment.upvotes.remove(widget.currentUser);
        comment.downvotes.add(widget.currentUser);
      } else {
        comment.downvotes.add(widget.currentUser);
      }
      sortComments(widget.currentPost.comments, dropdownvalue);
    });

    String upvotes =
        Convertor.listToString(comment.upvotes.map((e) => e.username).toList());
    String downvotes = Convertor.listToString(
        comment.downvotes.map((e) => e.username).toList());
    await Data().request('updateCommentVotes',
        'id::${comment.id}||upvotes::$upvotes||downvotes::$downvotes');
  }

  void sortComments(List<CommentModel> comments, String sortBy) {
    if (sortBy == "Best") {
      widget.currentPost.comments.sort((a, b) {
        return (b.upvotes.length - b.downvotes.length) -
            (a.upvotes.length - a.downvotes.length);
      });
    } else if (sortBy == "Recently") {
      widget.currentPost.comments.sort((a, b) {
        return b.date.compareTo(a.date);
      });
    }
  }

  void addComment(List<CommentModel> comments) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              title: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: commentController,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrange, width: 3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    isDense: true,
                    hintText: 'Add a comment',
                    hintStyle: TextStyle(
                      fontSize: 16,
                    )),
              ),
              trailing: ValueListenableBuilder<TextEditingValue>(
                valueListenable: commentController,
                builder: (context, value, child) {
                  return IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: value.text.isNotEmpty
                          ? Icon(Icons.send, color: Colors.deepOrange, size: 25)
                          : Icon(Icons.send, color: Colors.grey, size: 25),
                      onPressed: value.text.isNotEmpty
                          ? () async {
                              await Data()
                                  .request('genCommentId',
                                      'comment::${commentController.text}')
                                  .then((response) async {
                                CommentModel comment = CommentModel(
                                    id: response,
                                    user: widget.currentUser,
                                    comment: commentController.text,
                                    date: DateTime.now(),
                                    upvotes: [],
                                    downvotes: []);
                                setState(() {
                                  comments.add(comment);
                                });
                                await Data().request('insertPostComment',
                                    'id::${widget.currentPost.id}||comments::${comment.id}');
                                await Data().request(
                                    'insertComment',
                                    Convertor.mapToString(
                                        Convertor.modelToMap(comment)));

                                commentController.clear();
                                Navigator.pop(context);
                              });
                            }
                          : null);
                },
              ),
            ),
          ],
        );
      },
    );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostItem(
                widget.currentPost,
                () => changeDownVotes(widget.currentPost),
                () => changeUpVotes(widget.currentPost),
                () => savePost(widget.currentPost),
                addComment),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton(
                        underline: Container(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        value: dropdownvalue,
                        items: [
                          DropdownMenuItem(
                            child: Text('Best Comments'),
                            value: 'Best',
                          ),
                          DropdownMenuItem(
                            child: Text('Recently Comments'),
                            value: 'Recently',
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            dropdownvalue = value;
                            sortComments(widget.currentPost.comments, value);
                          });
                        }),
                  ),
                ],
              ),
            ),
            CommentItem(
              widget.currentPost.comments,
              changeDownVotesComment,
              changeUpVotesComment,
              addComment,
            )
          ],
        ),
      ),
    );
  }
}
