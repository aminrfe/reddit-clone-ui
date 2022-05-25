import '/Models/forum_model.dart';
import '/Models/post_model.dart';

class UserModel {
  String _username;
  String _password;
  String _email;
  List<ForumModel> _followedForums;
  List<PostModel> _posts;
  List<PostModel> _savedPosts;

  UserModel(this._username, this._password, this._email, this._followedForums, this._posts, this._savedPosts);

  String get username => _username;

  void set username(String username) {
    _username = username;
  }

  String get password => _password;

  void set password(String password) {
    _password = password;
  }

  String get email => _email;

  void set email(String email) {
    _email = email;
  }

  List<ForumModel> get followedForums => _followedForums;

  void set followedForums(List<ForumModel> followedForums) {
    _followedForums = followedForums;
  }

  void addFollowedForum(ForumModel forum) {
    if(!_followedForums.contains(forum)) {
      _followedForums.add(forum);
    } else {
      _followedForums.remove(forum);
    }
  }

  List<PostModel> get posts => _posts;

  void set posts(List<PostModel> posts) {
    _posts = posts;
  }

  void addPost(PostModel post) {
    _posts.add(post);
  }

  List<PostModel> get savedPosts => _savedPosts;

  void set savedPosts(List<PostModel> savedPosts) {
    _savedPosts = savedPosts;
  }

  void addSavedPost(PostModel post) {
    if (!_savedPosts.contains(post)) {
      _savedPosts.add(post);
    } else {
      _savedPosts.remove(post);
    }
  }


}