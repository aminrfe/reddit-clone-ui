import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../data.dart';
import '/Models/user_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserModel currentUser = Data().currentUser;

  bool _isObscure = true;
  bool invalidEmail = false;

  bool isValidPass(String pass) {
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
        .hasMatch(pass)) {
      return true;
    }
    return false;
  }

  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(52.0),
            child: AppBar(
              title: Text('Edit Profile'),
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
            padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 48,
                  child: TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                      hintText: currentUser.email,
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
                  height: 25,
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
                      hintText: currentUser.username,
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
                  height: 25,
                ),
                Container(
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
                  height: 300,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 250,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                        ),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_emailController.text.isEmpty ||
                            _usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Error",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                content:
                                    const Text("Please fill all the fields"),
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
                        } else if (!EmailValidator.validate(
                            _emailController.text)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Invalid Email",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                                content:
                                    const Text("Please enter a valid email"),
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
                          //TODO: Update the user
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 250,
                        height: 50,
                        decoration: const BoxDecoration(
                          // gradient: LinearGradient(
                          //     colors: [Colors.deepOrange, Colors.yellow]),
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                        ),
                        child: const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
