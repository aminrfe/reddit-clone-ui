import 'user_model.dart';

class CommentModel {
  UserModel _user;
  String _comment;
  DateTime _date;
  List<UserModel> _upvotes;
  List<UserModel> _downvotes;

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

  addUpvote(UserModel user) {
    if (!_upvotes.contains(user)) {
      _upvotes.add(user);
    } else {
      _upvotes.remove(user);
    }
  }

  List<UserModel> get downvotes => _downvotes;

  set downvotes(List<UserModel> downvotes) {
    _downvotes = downvotes;
  }

  addDownvote(UserModel user) {
    if (!_downvotes.contains(user)) {
      _downvotes.add(user);
    } else {
      _downvotes.remove(user);
    }
  }
}
