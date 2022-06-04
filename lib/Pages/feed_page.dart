import 'package:flutter/material.dart';
import '../data.dart';
import '/Models/forum_model.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';
import '/Items/post_item.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final UserModel currentUser = Data().currentUser;
  List<PostModel> posts;

  void initState() {
    posts = currentUser.followedForums
        .map((e) => e.posts)
        .expand((e) => e)
        .toList();
    super.initState();
  }

  void changeUpVotes(int index) {
    setState(() {
      if (posts[index].upvotes.contains(currentUser)) {
        posts[index].upvotes.remove(currentUser);
      } else if (posts[index].downvotes.contains(currentUser)) {
        posts[index].downvotes.remove(currentUser);
        posts[index].upvotes.add(currentUser);
      } else {
        posts[index].upvotes.add(currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (posts[index].downvotes.contains(currentUser)) {
        posts[index].downvotes.remove(currentUser);
      } else if (posts[index].upvotes.contains(currentUser)) {
        posts[index].upvotes.remove(currentUser);
        posts[index].downvotes.add(currentUser);
      } else {
        posts[index].downvotes.add(currentUser);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      currentUser.addSavedPost(posts[index]);
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
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(posts[index], currentUser, () => changeUpVotes(index),
              () => changeDownVotes(index), () => savePost(index));
        },
      ),
    );
  }
}
