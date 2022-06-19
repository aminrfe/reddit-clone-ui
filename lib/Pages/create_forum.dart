import 'package:flutter/material.dart';

import '../data.dart';
import '/Models/user_model.dart';
import '/Models/forum_model.dart';

class CreateForum extends StatefulWidget {
  CreateForum({Key key}) : super(key: key);
  final UserModel currentUser = Data().currentUser;

  @override
  State<CreateForum> createState() => _CreateForumState();
}

class _CreateForumState extends State<CreateForum> {
  bool isDoneActive = false;

  TextEditingController nameController;
  TextEditingController descController;

  void addForum(ForumModel forum) {
    widget.currentUser.followedForums.add(forum);
     widget.currentUser.followedForums
          .sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  void initState() {
    nameController = TextEditingController();
    descController = TextEditingController();

    nameController.addListener(() {
      descController.addListener(() {
        setState(() {
          isDoneActive =
              nameController.text.isNotEmpty && descController.text.isNotEmpty;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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
                        onPressed: isDoneActive
                            ? () {
                                ForumModel post = ForumModel(
                                    nameController.text,
                                    descController.text,
                                    widget.currentUser, []);

                                addForum(post);

                                nameController.clear();
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
                                  color: isDoneActive
                                      ? Colors.deepOrange
                                      : Colors.grey[300])),
                          primary: isDoneActive ? Colors.white : Colors.grey,
                          backgroundColor: isDoneActive
                              ? Colors.deepOrange
                              : Colors.grey[300],
                        ),
                        child: const Text('Done',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_rounded,
                      size: 50,
                    ),
                    title: TextField(
                      controller: nameController,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Forum Name",
                          hintStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          )),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: descController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add decription",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
