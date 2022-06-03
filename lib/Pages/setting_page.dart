import 'package:flutter/material.dart';
import '/Pages/profile_page.dart';
import '/Pages/savedposts_page.dart';
import '/Models/user_model.dart';

class SettingPage extends StatelessWidget {
  final UserModel currentUser = UserModel('Amin rafiee', '', '', [], [], []);

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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
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
                  //TODO: Create Forum
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SavedPostsPage();
                  }));
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
                  //TODO: About Us
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
