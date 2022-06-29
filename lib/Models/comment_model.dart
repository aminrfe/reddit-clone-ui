import 'user_model.dart';

class CommentModel {
  String id;
  UserModel user;
  String comment;
  DateTime date;
  List<UserModel> upvotes;
  List<UserModel> downvotes;

  CommentModel(
      {this.id,
      this.user,
      this.comment,
      this.date,
      this.upvotes,
      this.downvotes});

  @override
  operator ==(other) => other is CommentModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
