import 'package:flutter/material.dart';
import 'package:reddit_clone_ui/Models/comment_model.dart';
import 'package:reddit_clone_ui/Models/post_model.dart';
import '/Models/user_model.dart';
import '/Models/forum_model.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  List<ForumModel> forums = [
    ForumModel(
        'Programming',
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
        UserModel('Amin Rafiee', '88', '', [], [], []), []),
    ForumModel(
        'vim',
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        UserModel('Amin Rafiee', '88', '', [], [], []), []),
    ForumModel(
        'Dota2',
        'Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.',
        UserModel('Amin Rafiee', '88', '', [], [], []), []),
    ForumModel(
        'Nasa',
        'Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.',
        UserModel('Amin Rafiee', '88', '', [], [], []), [])
  ];
  bool isNextActive = false;
  UserModel currentUser;
  ForumModel currentForum;

  TextEditingController titleController;
  TextEditingController descController;

  @override
  void initState() {
    currentUser = UserModel('Amin Rafiee', '88', '', forums, [], []);
    
    titleController = TextEditingController();
    descController = TextEditingController();
    currentForum = (currentUser.followedForums != null)
        ? currentUser.followedForums[0]
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
                            ? () {
                                PostModel post = PostModel(
                                    titleController.text,
                                    descController.text,
                                    currentForum,
                                    currentUser,
                                    DateTime.now(),
                                    <UserModel>[],
                                    <UserModel>[],
                                    <CommentModel>[]);
                                currentForum.addPost(post);
                                currentUser.addPost(post);

                                titleController.clear();
                                descController.clear();
                                Navigator.pop(context);
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
                        itemBuilder: (context) => (currentUser.followedForums !=
                                null)
                            ? currentUser.followedForums
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
