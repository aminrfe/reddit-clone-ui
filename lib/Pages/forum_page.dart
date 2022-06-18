import 'package:flutter/material.dart';
import '../data.dart';
import '/Models/forum_model.dart';
import '/Models/user_model.dart';
import '/Models/post_model.dart';
import '/Items/forum_item.dart';

class ForumPage extends StatefulWidget {
  ForumPage({Key key, this.currentForum, this.removeForum}) : super(key: key);
  final ForumModel currentForum;
  final Function removeForum;
  final UserModel currentUser = Data().currentUser;

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  void changeUpVotes(int index) {
    setState(() {
      if (widget.currentForum.posts[index].upvotes
          .contains(widget.currentUser)) {
        widget.currentForum.posts[index].upvotes.remove(widget.currentUser);
      } else if (widget.currentForum.posts[index].downvotes
          .contains(widget.currentUser)) {
        widget.currentForum.posts[index].downvotes.remove(widget.currentUser);
        widget.currentForum.posts[index].upvotes.add(widget.currentUser);
      } else {
        widget.currentForum.posts[index].upvotes.add(widget.currentUser);
      }
    });
  }

  void changeDownVotes(int index) {
    setState(() {
      if (widget.currentForum.posts[index].downvotes
          .contains(widget.currentUser)) {
        widget.currentForum.posts[index].downvotes.remove(widget.currentUser);
      } else if (widget.currentForum.posts[index].upvotes
          .contains(widget.currentUser)) {
        widget.currentForum.posts[index].upvotes.remove(widget.currentUser);
        widget.currentForum.posts[index].downvotes.add(widget.currentUser);
      } else {
        widget.currentForum.posts[index].downvotes.add(widget.currentUser);
      }
    });
  }

  void removePost(int index) {
    setState(() {
      widget.currentForum.posts.removeAt(index);
    });
  }

  void toggleJoin() {
    setState(() {
      if (widget.currentUser.followedForums.contains(widget.currentForum)) {
        widget.currentUser.followedForums.remove(widget.currentForum);
        widget.removeForum(widget.currentForum, true);
      } else {
        widget.currentUser.followedForums.add(widget.currentForum);
        widget.removeForum(widget.currentForum, false);
      }
    });
  }

  void savePost(int index) {
    setState(() {
      widget.currentUser.addSavedPost(widget.currentForum.posts[index]);
    });
  }

  TextEditingController _forumNameController;
  TextEditingController _forumDescController;
  @override
  void initState() {
    _forumNameController =
        TextEditingController(text: widget.currentForum.name);
    _forumDescController =
        TextEditingController(text: widget.currentForum.desc);
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
      body: RefreshIndicator(
        color: Colors.deepOrange,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {});
        },
        child: CustomScrollView(
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
                                      'r/' + widget.currentForum.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    ),
                                    TextButton(
                                      child: Center(
                                        child: Text(
                                          widget.currentUser.followedForums
                                                  .contains(widget.currentForum)
                                              ? 'Joined'
                                              : 'Join',
                                          style: TextStyle(
                                            color: widget
                                                    .currentUser.followedForums
                                                    .contains(
                                                        widget.currentForum)
                                                ? Colors.white
                                                : Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        toggleJoin();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: widget
                                                .currentUser.followedForums
                                                .contains(widget.currentForum)
                                            ? Colors.blueAccent
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                            color: widget
                                                    .currentUser.followedForums
                                                    .contains(
                                                        widget.currentForum)
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
                                  widget.currentForum.desc,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            if (widget.currentUser.username ==
                                widget.currentForum.admin.username) {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                      widget.currentForum.name =
                                                          _forumNameController
                                                              .text;
                                                      widget.currentForum.desc =
                                                          _forumDescController
                                                              .text;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.deepOrange,
                                                    shape:
                                                        RoundedRectangleBorder(
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
                                                controller:
                                                    _forumNameController,
                                                decoration:
                                                    const InputDecoration(
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
                                                  labelText:
                                                      'Forum Description',
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
                              Image.asset('assets/images/reddit-logo.png')
                                  .image,
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
                    widget.currentForum.posts[index],
                    widget.currentUser,
                    widget.currentForum,
                    () => changeUpVotes(index),
                    () => changeDownVotes(index),
                    () => removePost(index),
                    () => savePost(index),
                  );
                },
                childCount: widget.currentForum.posts.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
