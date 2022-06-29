import 'package:flutter/cupertino.dart';
import 'forum_model.dart';
import 'post_model.dart';

class UserModel {
  String username;
  String password;
  String email;
  Image avatar;
  List<ForumModel> followedForums;
  List<ForumModel> favoriteForums;
  List<PostModel> posts;
  List<PostModel> savedPosts;

  UserModel(
      {this.username,
      this.password,
      this.email,
      this.followedForums,
      this.posts,
      this.savedPosts,
      this.favoriteForums});

  @override
  operator ==(other) => other is UserModel && other.username == username;

  @override
  int get hashCode => username.hashCode;

  addSavedPost(PostModel post) {
    if (!savedPosts.contains(post)) {
      savedPosts.add(post);
    } else {
      savedPosts.remove(post);
    }
  }
}
