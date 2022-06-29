import 'package:flutter/material.dart';
import 'package:reddit_clone_ui/convertor.dart';

import '/Models/post_model.dart';
import '../data.dart';
import '/Models/user_model.dart';
import '/Models/forum_model.dart';

class AddPost extends StatefulWidget {
  AddPost({Key key}) : super(key: key);
  final UserModel currentUser = Data().currentUser;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool isNextActive = false;
  List<ForumModel> forums;
  ForumModel currentForum;

  TextEditingController titleController;
  TextEditingController descController;

  void addPost(PostModel post) async {
    widget.currentUser.posts.add(post);
    currentForum.posts.add(post);
    await Data().request(
        "insertPost", Convertor.mapToString(Convertor.modelToMap(post)));
    await Data().request("insertUserPost",
        "username::${widget.currentUser.username}||posts::${post.id}");
    await Data().request(
        "insertForumPost", "forum::${currentForum.name}||posts::${post.id}");
  }

  @override
  void initState() {
    forums = widget.currentUser.followedForums;

    titleController = TextEditingController();
    descController = TextEditingController();
    currentForum = (widget.currentUser.followedForums != null &&
            widget.currentUser.followedForums.isNotEmpty)
        ? widget.currentUser.followedForums[0]
        : null;

    titleController.addListener(() {
      descController.addListener(() {
        setState(() {
          isNextActive = currentForum != null &&
              titleController.text.isNotEmpty &&
              descController.text.isNotEmpty;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black87,
                        size: 33,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, right: 15),
                      child: TextButton(
                        onPressed: isNextActive
                            ? () async {
                                await Data()
                                    .request('genPostId',
                                        'title::${titleController.text}')
                                    .then((response) {
                                  PostModel post = PostModel(
                                      id: response,
                                      title: titleController.text,
                                      desc: descController.text,
                                      forum: currentForum,
                                      user: widget.currentUser,
                                      date: DateTime.now(),
                                      upvotes: [],
                                      downvotes: [],
                                      comments: []);

                                  addPost(post);

                                  titleController.clear();
                                  descController.clear();
                                  Navigator.pop(context);
                                });
                              }
                            : null,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  width: 1,
                                  color: isNextActive
                                      ? Colors.deepOrange
                                      : Colors.grey[300])),
                          primary: isNextActive ? Colors.white : Colors.grey,
                          backgroundColor: isNextActive
                              ? Colors.deepOrange
                              : Colors.grey[300],
                        ),
                        child: const Text('Next',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle_rounded,
                          size: 35, color: Colors.deepOrange),
                      const SizedBox(
                        width: 10,
                      ),
                      PopupMenuButton<ForumModel>(
                        itemBuilder: (context) => (widget
                                    .currentUser.followedForums !=
                                null && widget.currentUser.followedForums.isNotEmpty)
                            ? widget.currentUser.followedForums
                                .map((forum) => PopupMenuItem<ForumModel>(
                                      value: forum,
                                      child: ListTile(
                                        leading: const Icon(
                                            Icons.account_circle_rounded,
                                            size: 30),
                                        title: Text("r/" + forum.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        horizontalTitleGap: 0,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    ))
                                .toList()
                            : null,
                        child: Row(
                          children: [
                            Text(
                                (currentForum != null)
                                    ? "r/" + currentForum.name
                                    : "No Forums",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Icon(Icons.keyboard_arrow_down_rounded, size: 25),
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        elevation: 1,
                        onSelected: (forum) {
                          setState(() {
                            currentForum = forum;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[400],
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a title",
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        )),
                  ),
                  TextField(
                    controller: descController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add body text",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
