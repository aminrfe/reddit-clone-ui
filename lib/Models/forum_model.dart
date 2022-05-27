import 'package:flutter/material.dart';
import 'post_model.dart';
import 'user_model.dart';

class ForumModel {
  String _name;
  ImageProvider _avatar;
  String _desc;
  UserModel _admin;
  List<PostModel> _posts;

  ForumModel(this._name, this._desc, this._admin, this._posts);

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get desc => _desc;

  set desc(String desc) {
    _desc = desc;
  }

  ImageProvider get avatar => _avatar;
  set avatar(ImageProvider avatar) {
    _avatar = avatar;
  }

  UserModel get admin => _admin;

  set admin(UserModel admin) {
    _admin = admin;
  }

  List<PostModel> get posts => _posts;

  set posts(List<PostModel> posts) {
    _posts = posts;
  }

  void addPost(PostModel post) {
    _posts.add(post);
  }
}
