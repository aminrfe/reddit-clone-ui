import 'package:flutter/material.dart';

import '../convertor.dart';
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
        child: posts.isEmpty
            ? const Center(
                child: Text('No Post',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              )
            : ListView.builder(
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
