import 'package:flutter/material.dart';
import '/Pages/sign_up.dart';
import 'package:reddit1/Pages/log_in.dart';
import '/Pages/home_page.dart';

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
      initialRoute: '/HomePage',
      routes: {
        '/SignUp': (context) => SignUp(),
        '/LogIn': (context) => LogIn(),
        '/HomePage': (context) => HomePage(),
      },
    );
  }
}
