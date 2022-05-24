import 'package:flutter/material.dart';
import 'package:reddit1/sign_up.dart';
<<<<<<< HEAD
import 'package:reddit1/Pages/log_in.dart';
import 'package:reddit1/home_page.dart';
=======
import 'package:reddit1/log_in.dart';
import 'package:reddit1/feed_page.dart';
>>>>>>> 77e07c3498f806eb3f3ca16a02b340349f62bdcd

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      // theme: ThemeData(
      //   primaryColor: Colors.deepOrange,
      //   primarySwatch: Colors.blue,
      //   backgroundColor: Colors.white,
      // ),
<<<<<<< HEAD
      initialRoute: '/HomePage',
      routes: {
        '/SignUp': (context) => SignUp(),
        '/LogIn': (context) => LogIn(),
        '/HomePage': (context) => HomePage(),
=======
      initialRoute: '/FeedPage',
      routes: {
        '/SignUp': (context) => SignUp(),
        '/LogIn': (context) => LogIn(),
        '/FeedPage': (context) => FeedPage(),
>>>>>>> 77e07c3498f806eb3f3ca16a02b340349f62bdcd
      },
      
    );
  }
}



