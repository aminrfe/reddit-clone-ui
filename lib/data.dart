import 'dart:io';
import 'dart:typed_data';

import 'Models/forum_model.dart';
import 'Models/comment_model.dart';
import 'Models/post_model.dart';
import 'Models/user_model.dart';
import 'convertor.dart';

class Data {
  UserModel currentUser;

  Data._() {
    currentUser = UserModel(
        savedPosts: [], followedForums: [], favoriteForums: []);
  }

  static final Data _instance = Data._();

  factory Data() {
    return _instance;
  }

  Future<String> request(String command, String data) async {
    String result = "";
    if (data.contains('\n')) {
      data = data.replaceAll('\n', '[]');
    }

    await Socket.connect('10.0.2.2', 8080).then((socket) async {
      socket.write(command + '\n' + data + '\u0000');
      await socket.flush();

      var listen = socket.listen((response) async {
        result = String.fromCharCodes(response).trim();
        print("Received response: $result");
      });
      await listen.asFuture<void>();

      if (result.contains('[]')) {
        result = result.replaceAll('[]', '\n');
      }
      // socket.close();
    });
    return result;
  }


  void downloadSavedPosts() async {
    String username = currentUser.username;

    String savedPosts =
        await request('getUserSavedPosts', 'username::$username');
    if (savedPosts == '-') {
      return;
    }
    List<Map<String, String>> savedPostsList = [];
    savedPosts.split('\n').forEach((post) {
      savedPostsList.add(Convertor.stringToMap(post));
    });

    for (var post in savedPostsList) {
      PostModel postModel = PostModel(
          id: post['id'],
          title: post['title'],
          desc: post['desc'],
          date: DateTime.parse(post['date']),
          forum: ForumModel(name: post['name']),
          upvotes: Convertor.stringToList(post['upvotes'])
              .map((e) => UserModel(username: e))
              .toList(),
          downvotes: Convertor.stringToList(post['downvotes'])
              .map((e) => UserModel(username: e))
              .toList(),
          comments: Convertor.stringToList(post['comments'])
              .map((e) => CommentModel(id: e))
              .toList());

      currentUser.savedPosts.add(postModel);
    }
  }

  void downloadFollowedForums() async {
    String username = currentUser.username;

    String followedForums =
        await request('getUserFollowedForums', 'username::$username');

    if (followedForums == '-') {
      return;
    }
    List<Map<String, String>> followedForumsList = [];
    followedForums.split('\n').forEach((forum) {
      followedForumsList.add(Convertor.stringToMap(forum));
    });

    for (var forum in followedForumsList) {
      ForumModel forumModel = ForumModel(
        name: forum['name'],
        desc: forum['desc'],
        admin: UserModel(username: forum['admin']),
        posts: Convertor.stringToList(forum['posts'])
            .map((e) => PostModel(id: e))
            .toList(),
      );

      currentUser.followedForums.add(forumModel);
    }
  }

  void downloadFavoriteForums() async {
    String username = currentUser.username;

    String favoriteForums =
        await request('getUserFavoriteForums', 'username::$username');
    if (favoriteForums == '-') {
      return;
    }

    List<Map<String, String>> favoriteForumsList = [];
    favoriteForums.split('\n').forEach((forum) {
      favoriteForumsList.add(Convertor.stringToMap(forum));
    });

    for (var forum in favoriteForumsList) {
      ForumModel forumModel = ForumModel(
        name: forum['name'],
        desc: forum['desc'],
        admin: UserModel(username: forum['admin']),
        posts: Convertor.stringToList(forum['posts'])
            .map((e) => PostModel(id: e))
            .toList(),
      );

      currentUser.favoriteForums.add(forumModel);
    }
  }
}
