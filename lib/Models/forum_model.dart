import '/Models/post_model.dart';
import '/Models/user_model.dart';

class ForumModel {

  String _forumName;
  String _forumDesc;
  UserModel _admin;
  List<PostModel> _posts;

  ForumModel(this._forumName, this._forumDesc, this._admin, this._posts);

  String get forumName => _forumName;

  void set forumName(String forumName) {
    _forumName = forumName;
  }

  String get forumDesc => _forumDesc;

  void set forumDesc(String forumDesc) {
    _forumDesc = forumDesc;
  }

  UserModel get admin => _admin;

  void set admin(UserModel admin) {
    _admin = admin;
  }

  List<PostModel> get posts => _posts;

  void set posts(List<PostModel> posts) {
    _posts = posts;
  }

  void addPost(PostModel post) {
    _posts.add(post);
  }

}