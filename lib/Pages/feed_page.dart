import 'package:flutter/material.dart';
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
  UserModel currentUser = UserModel('Amin rafiee', '', '', [], [], []);

  List<PostModel> userposts = [
    PostModel(
        "title1",
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        "title1",
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        "title1",
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        "title1",
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        "title1",
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
  ];

  void changeUpVotes(int index) {
    setState(() {
      if (userposts[index].upvotes.contains(currentUser)) {
        userposts[index].upvotes.remove(currentUser);
      } else if (userposts[index].downvotes.contains(currentUser)) {
        userposts[index].downvotes.remove(currentUser);
        userposts[index].upvotes.add(currentUser);
      } else {
        userposts[index].upvotes.add(currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (userposts[index].downvotes.contains(currentUser)) {
        userposts[index].downvotes.remove(currentUser);
      } else if (userposts[index].upvotes.contains(currentUser)) {
        userposts[index].upvotes.remove(currentUser);
        userposts[index].downvotes.add(currentUser);
      } else {
        userposts[index].downvotes.add(currentUser);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      currentUser.addSavedPost(userposts[index]);
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
        itemCount: userposts.length,
        itemBuilder: (context, index) {
          return PostItem(
              userposts[index],
              currentUser,
              () => changeUpVotes(index),
              () => changeDownVotes(index),
              () => savePost(index));
        },
      ),
    );
  }
}
