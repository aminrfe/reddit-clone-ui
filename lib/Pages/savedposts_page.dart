import 'package:flutter/material.dart';
import '/Models/forum_model.dart';
import '/Models/post_model.dart';
import '/Models/user_model.dart';
import '/Items/post_item.dart';

class SavedPostsPage extends StatefulWidget {
  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  
  UserModel currentUser = UserModel('Amin rafiee', '', '', [], [], [
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
  ]);

  void changeUpVotes(int index) {
    setState(() {
      if (currentUser.savedPosts[index].upvotes.contains(currentUser)) {
        currentUser.savedPosts[index].upvotes.remove(currentUser);
      } else if (currentUser.savedPosts[index].downvotes
          .contains(currentUser)) {
        currentUser.savedPosts[index].downvotes.remove(currentUser);
        currentUser.savedPosts[index].upvotes.add(currentUser);
      } else {
        currentUser.savedPosts[index].upvotes.add(currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (currentUser.savedPosts[index].downvotes.contains(currentUser)) {
        currentUser.savedPosts[index].downvotes.remove(currentUser);
      } else if (currentUser.savedPosts[index].upvotes.contains(currentUser)) {
        currentUser.savedPosts[index].upvotes.remove(currentUser);
        currentUser.savedPosts[index].downvotes.add(currentUser);
      } else {
        currentUser.savedPosts[index].downvotes.add(currentUser);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      currentUser.addSavedPost(currentUser.savedPosts[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: currentUser.savedPosts.length,
        itemBuilder: (context, index) {
          return PostItem(
              currentUser.savedPosts[index],
              currentUser,
              () => changeUpVotes(index),
              () => changeDownVotes(index),
              () => savePost(index));
        },
      ),
    );
  }
}
