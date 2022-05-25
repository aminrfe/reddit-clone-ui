import '/Models/forum_model.dart';
import '/Models/user_model.dart';
import '/Models/comment_model.dart';

class PostModel {
  String _title;
  String _desc;
  ForumModel _forum;
  UserModel _user;
  DateTime _date;
  List<UserModel> _upvotes;
  List<UserModel> _downvotes;
  List<CommentModel> _comments;

  PostModel(this._title, this._desc, this._forum, this._user, this._date, this._upvotes, this._downvotes, this._comments);

  String get title => _title;

  void set title(String title) {
    _title = title;
  }

  String get desc => _desc;

  void set desc(String desc) {
    _desc = desc;
  }

  ForumModel get forum => _forum;

  void set forum(ForumModel forum) {
    _forum = forum;
  }

  UserModel get user => _user;

  void set user(UserModel user) {
    _user = user;
  }

  DateTime get date => _date;

  void set date(DateTime date) {
    _date = date;
  }

  List<UserModel> get upvotes => _upvotes;

  void set upvotes(List<UserModel> upvotes) {
    _upvotes = upvotes;
  }

  void addUpvote(UserModel user) {
    if(!_upvotes.contains(user)) {
      _upvotes.add(user);
    } else {
      _upvotes.remove(user);
    }
  }

  List<UserModel> get downvotes => _downvotes;

  void set downvotes(List<UserModel> downvotes) {
    _downvotes = downvotes;
  }

  void addDownvote(UserModel user) {
    if(!_downvotes.contains(user)) {
      _downvotes.add(user);
    } else {
      _downvotes.remove(user);
    }
  }

  List<CommentModel> get comments => _comments;

  void set comments(List<CommentModel> comments) {
    _comments = comments;
  }

  void addComment(CommentModel comment) {
    _comments.add(comment);
  }




}