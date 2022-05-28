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
      userposts[index].addUpvote(currentUser);
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      userposts[index].addDownvote(currentUser);
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
          return PostItem(userposts[index], currentUser, () => changeUpVotes,
              () => changeDownVotes);
        },
      ),
    );
  }
}
