import 'package:flutter/cupertino.dart';
import 'forum_model.dart';
import 'post_model.dart';

class UserModel {
  String _username;
  String _password;
  String _email;
  ImageProvider _avatar;
  List<ForumModel> _followedForums;
  List<PostModel> _posts;
  List<PostModel> _savedPosts;

  UserModel(this._username, this._password, this._email, this._followedForums,
      this._posts, this._savedPosts);

  String get username => _username;

  set username(String username) {
    _username = username;
  }

  String get password => _password;

  set password(String password) {
    _password = password;
  }

  String get email => _email;

  set email(String email) {
    _email = email;
  }

  ImageProvider get avatar => _avatar;
  set avatar(ImageProvider avatar) {
    _avatar = avatar;
  }

  List<ForumModel> get followedForums => _followedForums;

  set followedForums(List<ForumModel> followedForums) {
    _followedForums = followedForums;
  }

  addFollowedForum(ForumModel forum) {
    if (!_followedForums.contains(forum)) {
      _followedForums.add(forum);
    } else {
      _followedForums.remove(forum);
    }
  }

  List<PostModel> get posts => _posts;

  set posts(List<PostModel> posts) {
    _posts = posts;
  }

  addPost(PostModel post) {
    _posts.add(post);
  }

  List<PostModel> get savedPosts => _savedPosts;

  set savedPosts(List<PostModel> savedPosts) {
    _savedPosts = savedPosts;
  }

  addSavedPost(PostModel post) {
    if (!_savedPosts.contains(post)) {
      _savedPosts.add(post);
    } else {
      _savedPosts.remove(post);
    }
  }
}