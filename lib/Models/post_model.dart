import 'forum_model.dart';
import 'user_model.dart';
import 'comment_model.dart';

class PostModel {
  String id;
  String title;
  String desc;
  ForumModel forum;
  UserModel user;
  DateTime date;
  List<UserModel> upvotes;
  List<UserModel> downvotes;
  List<CommentModel> comments;

  PostModel({this.id, this.title, this.desc, this.forum, this.user, this.date, this.upvotes, this.downvotes, this.comments});

  @override
  operator ==(other) => other is PostModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}