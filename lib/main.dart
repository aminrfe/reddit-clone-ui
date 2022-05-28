import 'package:flutter/material.dart';
import '/Pages/sign_up.dart';
import '/Pages/log_in.dart';
import '/Pages/home_page.dart';
import '/Pages/profile_page.dart';
import '/Pages/savedposts_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      initialRoute: '/HomePage',
      routes: {
        '/SignUp': (context) => SignUp(),
        '/LogIn': (context) => LogIn(),
        '/HomePage': (context) => HomePage(),
        '/ProfilePage': (context) => ProfilePage(),
        '/SavedPostsPage': (context) => SavedPostsPage(),
      },
    );
  }
}
