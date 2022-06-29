import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../convertor.dart';
import '../data.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isObscure = true;
  bool invalidEmail = false;

  bool isValidPass(String pass) {
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
        .hasMatch(pass)) {
      return true;
    }
    return false;
  }

  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
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
              Image.asset(
                'assets/images/reddit-logo.png',
                width: 40,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/SignUp', (Route<dynamic> route) => false);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text("Log In",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'User Agreement',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                'https://www.redditinc.com/policies/user-agreement-september-12-2021');
                          },
                      ),
                      const TextSpan(
                        text: ' and ',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                'https://www.reddit.com/policies/privacy-policy-revision-2021-09-12');
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset("assets/images/google-logo.png",
                          fit: BoxFit.cover, height: 22),
                      const SizedBox(width: 60),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(width: 1.2, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset("assets/images/apple2-logo.png",
                          fit: BoxFit.cover, height: 22),
                      const SizedBox(width: 64),
                      const Text(
                        "Continue with Apple",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(width: 1.2, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 10,
                      )),
                ),
                const Text("OR",
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 10,
                      )),
                ),
              ]),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 48,
                child: TextField(
                  controller: _usernameController,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                  ),
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    filled: true,
                    fillColor: Colors.grey[150],
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black38,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 48,
                child: TextField(
                  obscureText: _isObscure,
                  controller: _passwordController,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    filled: true,
                    fillColor: Colors.grey[150],
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black38,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 235,
              ),
              TextButton(
                onPressed: () async {
                  if (_usernameController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Error",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          content: const Text("Please fill all the fields"),
                          actions: [
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (!isValidPass(_passwordController.text)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Invalid Password",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          content: const Text(
                            "Password must contain at least one number, one lowercase and one uppercase letter",
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    await Data()
                        .request('checkUser',
                            'username::$username||password::$password')
                        .then((response) async {
                      if (response.contains('UserFound')) {
                        Data().currentUser.username = username;
                        Data().currentUser.password = password;
                        await Data()
                            .request('getUserAccount', 'username::$username')
                            .then((response) {
                          Data().currentUser.email =
                              Convertor.stringToMap(response)['email'];
                        });

                        Data().downloadPosts();
                        Data().downloadSavedPosts();
                        Data().downloadFollowedForums();
                        Data().downloadFavoriteForums();

                        _usernameController.clear();
                        _passwordController.clear();

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/HomePage', (Route<dynamic> route) => false);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Error",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              content: Text(response),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.yellow]),
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
