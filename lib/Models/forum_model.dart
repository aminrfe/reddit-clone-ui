import 'package:flutter/material.dart';
import 'post_model.dart';
import 'user_model.dart';

class ForumModel {
  String name;
  Image avatar;
  String desc;
  UserModel admin;
  List<PostModel> posts;

  ForumModel({this.name, this.desc, this.admin, this.posts});

  @override
  operator ==(other) => other is ForumModel && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
