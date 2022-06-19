import 'package:flutter/material.dart';

import '../data.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';
import 'post_detail.dart';
import '/Items/post_item_feed.dart';
import 'search_posts.dart';

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
    posts.sort((a, b) => b.date.compareTo(a.date));
    super.initState();
  }

  void refresh() {
    setState(() {
      posts = widget.currentUser.followedForums
          .map((e) => e.posts)
          .expand((e) => e)
          .toList();
      posts.sort((a, b) => b.date.compareTo(a.date));
    });
  }

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
              onPressed: () async {
                final finalResult = await showSearch(
                    context: context, delegate: SearchPosts(allPosts: posts));
                if (finalResult != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PostDetail(currentPost: finalResult)),
                  ).then((_) => setState(() {}));
                }
              },
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
                () => changeUpVotes(posts[index]),
                () => changeDownVotes(posts[index]),
                () => savePost(posts[index]),
                (_) => setState(() {}));
          },
        ),
      ),
    );
  }
}
