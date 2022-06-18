import 'package:flutter/material.dart';
import '../data.dart';
import '/Models/forum_model.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';
import '/Items/post_item_feed.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);
  final UserModel currentUser = Data().currentUser;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<PostModel> posts;

  @override
  void initState() {
    posts = widget.currentUser.followedForums
        .map((e) => e.posts)
        .expand((e) => e)
        .toList();
    super.initState();
  }

  void refresh() {
    setState(() {
      posts = widget.currentUser.followedForums
          .map((e) => e.posts)
          .expand((e) => e)
          .toList();
    });
  }

  void changeUpVotes(int index) {
    setState(() {
      if (posts[index].upvotes.contains(widget.currentUser)) {
        posts[index].upvotes.remove(widget.currentUser);
      } else if (posts[index].downvotes.contains(widget.currentUser)) {
        posts[index].downvotes.remove(widget.currentUser);
        posts[index].upvotes.add(widget.currentUser);
      } else {
        posts[index].upvotes.add(widget.currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (posts[index].downvotes.contains(widget.currentUser)) {
        posts[index].downvotes.remove(widget.currentUser);
      } else if (posts[index].upvotes.contains(widget.currentUser)) {
        posts[index].upvotes.remove(widget.currentUser);
        posts[index].downvotes.add(widget.currentUser);
      } else {
        posts[index].downvotes.add(widget.currentUser);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      widget.currentUser.addSavedPost(posts[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    refresh();
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
          leading: IconButton(
            icon: Image.asset('assets/images/reddit-logo.png'),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.deepOrange,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          refresh();
        },
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostItem(
                posts[index],
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
