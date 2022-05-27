import 'forum_model.dart';
import 'user_model.dart';
import 'comment_model.dart';

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

  set title(String title) {
    _title = title;
  }

  String get desc => _desc;

  set desc(String desc) {
    _desc = desc;
  }

  ForumModel get forum => _forum;

  set forum(ForumModel forum) {
    _forum = forum;
  }

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
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
    if(!_upvotes.contains(user)) {
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
    if(!_downvotes.contains(user)) {
      _downvotes.add(user);
    } else {
      _downvotes.remove(user);
    }
  }

  List<CommentModel> get comments => _comments;

  set comments(List<CommentModel> comments) {
    _comments = comments;
  }

  addComment(CommentModel comment) {
    _comments.add(comment);
  }




}