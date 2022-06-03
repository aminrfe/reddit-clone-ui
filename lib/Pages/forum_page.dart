import 'package:flutter/material.dart';
import '/Models/forum_model.dart';
import '/Models/user_model.dart';
import '/Models/post_model.dart';
import '/Items/forum_item.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key key, this.currentForumm}) : super(key: key);
  final ForumModel currentForumm;

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  UserModel currentUser = UserModel('Amin rafiee', '', '', [], [], []);
  ForumModel currentForum = ForumModel(
      'Nasa',
      'NASA is for anything related to the National Aeronautics and Space Administration; the latest news, events, current and future missions, and more.',
      UserModel('Amin rafiee', '', '', [], [], []), [
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel(
            'Nasa', 'Desc', UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel(
            'Nasa', 'Desc', UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel(
            'Nasa', 'Desc', UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel(
            'Nasa', 'Desc', UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel(
            'Nasa', 'Desc', UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        []),
    PostModel(
        'title1',
        'This is a test for reddit ui.\nIt is second line of text.',
        ForumModel('Programming', 'Desc',
            UserModel('Amin Rafiee', '88', '', [], [], []), []),
        UserModel('Amin rafiee', '', '', [], [], []),
        DateTime.now(),
        [],
        [],
        [])
  ]);

  void changeUpVotes(int index) {
    setState(() {
      if (currentForum.posts[index].upvotes.contains(currentUser)) {
        currentForum.posts[index].upvotes.remove(currentUser);
      } else if (currentForum.posts[index].downvotes.contains(currentUser)) {
        currentForum.posts[index].downvotes.remove(currentUser);
        currentForum.posts[index].upvotes.add(currentUser);
      } else {
        currentForum.posts[index].upvotes.add(currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (currentForum.posts[index].downvotes.contains(currentUser)) {
        currentForum.posts[index].downvotes.remove(currentUser);
      } else if (currentForum.posts[index].upvotes.contains(currentUser)) {
        currentForum.posts[index].upvotes.remove(currentUser);
        currentForum.posts[index].downvotes.add(currentUser);
      } else {
        currentForum.posts[index].downvotes.add(currentUser);
      }
    });
  }

  void removePost(int index) {
    setState(() {
      currentForum.posts.removeAt(index);
    });
  }

  void savePost(int index) {
    setState(() {
      currentUser.addSavedPost(currentForum.posts[index]);
    });
  }

  TextEditingController _forumNameController;
  TextEditingController _forumDescController;
  @override
  void initState() {
    _forumNameController = TextEditingController(text: currentForum.name);
    _forumDescController = TextEditingController(text: currentForum.desc);
    super.initState();
  }

  @override
  void dispose() {
    _forumNameController.dispose();
    _forumDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepOrange,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Image.asset('assets/images/reddit-avatars.png',
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'r/' + currentForum.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  ),
                                  TextButton(
                                    child: Center(
                                      child: Text(
                                        currentUser.followedForums
                                                .contains(currentForum)
                                            ? 'Joined'
                                            : 'Join',
                                        style: TextStyle(
                                          color: currentUser.followedForums
                                                  .contains(currentForum)
                                              ? Colors.white
                                              : Colors.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (currentUser.followedForums
                                            .contains(currentForum)) {
                                          currentUser.followedForums
                                              .remove(currentForum);
                                        } else {
                                          currentUser.followedForums
                                              .add(currentForum);
                                        }
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: currentUser
                                              .followedForums
                                              .contains(currentForum)
                                          ? Colors.blueAccent
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: currentUser.followedForums
                                                  .contains(currentForum)
                                              ? Colors.white
                                              : Colors.blue,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                currentForum.desc,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (currentUser.username ==
                              currentForum.admin.username) {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'Edit Forum',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextButton(
                                                child: const Text('Save',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15)),
                                                onPressed: () {
                                                  setState(() {
                                                    currentForum.name =
                                                        _forumNameController
                                                            .text;
                                                    currentForum.desc =
                                                        _forumDescController
                                                            .text;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                              controller: _forumNameController,
                                              decoration: const InputDecoration(
                                                labelText: 'Forum Name',
                                                border: InputBorder.none,
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _forumDescController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                                labelText: 'Forum Description',
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 75,
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 120,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 27,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.deepOrange,
                        backgroundImage:
                            Image.asset('assets/images/reddit-logo.png').image,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 300,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ForumItem(
                  currentForum.posts[index],
                  currentUser,
                  currentForum,
                  () => changeUpVotes(index),
                  () => changeDownVotes(index),
                  () => removePost(index),
                  () => savePost(index),
                );
              },
              childCount: currentForum.posts.length,
            ),
          )
        ],
      ),
    );
  }
}
