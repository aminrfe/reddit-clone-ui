import 'user_model.dart';

class CommentModel {
  UserModel _user;
  String _comment;
  DateTime _date;
  List<UserModel> _upvotes;
  List<UserModel> _downvotes;
  List<CommentModel> _replies;

  CommentModel(
      this._user, this._comment, this._date, this._upvotes, this._downvotes);

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
  }

  String get comment => _comment;

  set comment(String comment) {
    _comment = comment;
  }

  DateTime get date => _date;

  set date(DateTime date) {
    _date = date;
  }

  List<UserModel> get upvotes => _upvotes;

  set upvotes(List<UserModel> upvotes) {
    _upvotes = upvotes;
  }

  List<UserModel> get downvotes => _downvotes;

  set downvotes(List<UserModel> downvotes) {
    _downvotes = downvotes;
  }

  List<CommentModel> get replies => _replies;

  set replies(List<CommentModel> replies) {
    _replies = replies;
  }
}
