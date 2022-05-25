import '/Models/user_model.dart';

class CommentModel {
  UserModel _user;
  String _comment;
  DateTime _date;
  List<UserModel> _like;
  List<UserModel> _dislike;

  CommentModel(this._user, this._comment, this._date, this._like, this._dislike);

  UserModel get user => _user;

  void set user(UserModel user) {
    _user = user;
  }

  String get comment => _comment;

  void set comment(String comment) {
    _comment = comment;
  }

  DateTime get date => _date;

  void set date(DateTime date) {
    _date = date;
  }

  List<UserModel> get like => _like;

  void set like(List<UserModel> like) {
    _like = like;
  }

  void addLike(UserModel user) {
    if(!_like.contains(user)) {
      _like.add(user);
    } else {
      _like.remove(user);
    }
  }

  List<UserModel> get dislike => _dislike;

  void set dislike(List<UserModel> dislike) {
    _dislike = dislike;
  }

  void addDislike(UserModel user) {
    if(!_dislike.contains(user)) {
      _dislike.add(user);
    } else {
      _dislike.remove(user);
    }
  }

}