import 'package:flutter/material.dart';
import '../convertor.dart';
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

  void removePost(PostModel post) async {
    setState(() {
      widget.currentForum.posts.remove(post);
      if (widget.currentUser.savedPosts.contains(post)) {
        widget.currentUser.savedPosts.remove(post);
      }
    });

    String posts = Convertor.listToString(
        widget.currentForum.posts.map((e) => e.id).toList());
    String savedPosts = Convertor.listToString(
        widget.currentUser.savedPosts.map((e) => e.id).toList());

    await Data().request('deletePost', 'id::${post.id}');
    await Data().request(
        'updateForumPosts', 'name::${widget.currentForum.name}||posts::$posts');
    await Data().request('updateUserPosts',
        'username::${widget.currentUser.username}||posts::$savedPosts');
  }

  void toggleJoin() async {
    setState(() {
      if (widget.currentUser.followedForums.contains(widget.currentForum)) {
        widget.currentUser.followedForums.remove(widget.currentForum);
        widget.removeForum(widget.currentForum, true);
      } else {
        widget.currentUser.followedForums.add(widget.currentForum);
        widget.removeForum(widget.currentForum, false);
      }
    });

    String followedForums = Convertor.listToString(
        widget.currentUser.followedForums.map((e) => e.name).toList());
    String favoriteForums = Convertor.listToString(
        widget.currentUser.favoriteForums.map((e) => e.name).toList());
    await Data().request('updateUserForums',
        'username::${widget.currentUser.username}||followedForums::$followedForums||favoriteForums::$favoriteForums');
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.currentForum.desc,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ],
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
                                                  onPressed: () async {
                                                    await Data().request(
                                                        'updateForumDetail',
                                                        'name::${_forumNameController.text}||desc::${_forumDescController.text}');
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
                    () => changeUpVotes(widget.currentForum.posts[index]),
                    () => changeDownVotes(widget.currentForum.posts[index]),
                    () => removePost(widget.currentForum.posts[index]),
                    () => savePost(widget.currentForum.posts[index]),
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
