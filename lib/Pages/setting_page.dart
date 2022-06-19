import 'package:flutter/material.dart';

import '/Pages/about_us.dart';
import '/Pages/create_forum.dart';
import '../data.dart';
import '/Pages/profile_page.dart';
import '/Pages/savedposts_page.dart';
import '/Models/user_model.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key key, this.onNext}) : super(key: key);
  final Function onNext;

  final UserModel currentUser = Data().currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52.0),
          child: AppBar(
            title: Text('Setting'),
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
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'Edit Profile',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.account_circle),
                onTap: () {
                  onNext(ProfilePage());
                },
              ),
              ListTile(
                title: const Text(
                  'Create Forum',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.forum_rounded),
                onTap: () {
                  onNext(CreateForum());
                },
              ),
              ListTile(
                title: const Text(
                  'Saved Posts',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.bookmark_border),
                onTap: () {
                  onNext(SavedPostsPage());
                },
              ),
              ListTile(
                title: const Text(
                  'About Us',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.info_outline),
                onTap: () {
                  onNext(AboutUs());
                },
              ),
              //TODO: DarkMode
            ],
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
          ),
        ),
      ),
    );
  }
}
