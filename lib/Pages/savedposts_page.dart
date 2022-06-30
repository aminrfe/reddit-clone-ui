import 'package:flutter/material.dart';
import '../Models/post_model.dart';
import '../convertor.dart';
import '/Models/user_model.dart';
import '/Items/post_item_feed.dart';
import '../data.dart';

class SavedPostsPage extends StatefulWidget {
  final UserModel currentUser = Data().currentUser;

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
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

  @override
  Widget build(BuildContext context) {
    (_) => setState(() {});
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52.0),
        child: AppBar(
          title: Text('Saved Posts'),
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
      body: RefreshIndicator(
        color: Colors.deepOrange,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: widget.currentUser.savedPosts.isEmpty
            ? const Center(
                child: Text('No SavedPost',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              )
            : ListView.builder(
                itemCount: widget.currentUser.savedPosts.length,
                itemBuilder: (context, index) {
                  return PostItem(
                      widget.currentUser.savedPosts[index],
                      () => changeUpVotes(widget.currentUser.savedPosts[index]),
                      () =>
                          changeDownVotes(widget.currentUser.savedPosts[index]),
                      () => savePost(widget.currentUser.savedPosts[index]),
                      (_) => setState(() {}));
                },
              ),
      ),
    );
  }
}
