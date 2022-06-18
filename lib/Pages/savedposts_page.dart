import 'package:flutter/material.dart';
import '/Models/user_model.dart';
import '/Items/post_item_feed.dart';
import '../data.dart';

class SavedPostsPage extends StatefulWidget {
  final UserModel currentUser = Data().currentUser;

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  void changeUpVotes(int index) {
    setState(() {
      if (widget.currentUser.savedPosts[index].upvotes
          .contains(widget.currentUser)) {
        widget.currentUser.savedPosts[index].upvotes.remove(widget.currentUser);
      } else if (widget.currentUser.savedPosts[index].downvotes
          .contains(widget.currentUser)) {
        widget.currentUser.savedPosts[index].downvotes
            .remove(widget.currentUser);
        widget.currentUser.savedPosts[index].upvotes.add(widget.currentUser);
      } else {
        widget.currentUser.savedPosts[index].upvotes.add(widget.currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (widget.currentUser.savedPosts[index].downvotes
          .contains(widget.currentUser)) {
        widget.currentUser.savedPosts[index].downvotes
            .remove(widget.currentUser);
      } else if (widget.currentUser.savedPosts[index].upvotes
          .contains(widget.currentUser)) {
        widget.currentUser.savedPosts[index].upvotes.remove(widget.currentUser);
        widget.currentUser.savedPosts[index].downvotes.add(widget.currentUser);
      } else {
        widget.currentUser.savedPosts[index].downvotes.add(widget.currentUser);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      widget.currentUser.addSavedPost(widget.currentUser.savedPosts[index]);
    });
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
        child: ListView.builder(
          itemCount: widget.currentUser.savedPosts.length,
          itemBuilder: (context, index) {
            return PostItem(
                widget.currentUser.savedPosts[index],
                () => changeUpVotes(index),
                () => changeDownVotes(index),
                () => savePost(index),
                (_) => setState(() {}));
          },
        ),
      ),
    );
  }
}
