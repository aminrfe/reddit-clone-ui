import 'dart:io';
import 'package:intl/intl.dart';

import 'Models/forum_model.dart';
import 'Models/comment_model.dart';
import 'Models/post_model.dart';
import 'Models/user_model.dart';
import 'convertor.dart';

class Data {
  UserModel currentUser;

  Data._() {
    currentUser =
        UserModel(savedPosts: [], followedForums: [], favoriteForums: []);
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
        print("Received response: $result");
        result = String.fromCharCodes(response).trim();
      });
      await listen.asFuture<void>();

      if (result.contains('[]')) {
        result = result.replaceAll('[]', '\n');
      }
      // socket.close();
    });
    return result;
  }

  Future<void> downloadSavedPosts() async {
    String username = currentUser.username;

    await request('getUserSavedPosts', 'username::$username')
        .then((savedPosts) async {
      if (savedPosts != '-') {
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
              user: UserModel(username: post['user']),
              upvotes: Convertor.stringToList(post['upvotes'])
                  .map((e) => UserModel(username: e))
                  .toList(),
              downvotes: Convertor.stringToList(post['downvotes'])
                  .map((e) => UserModel(username: e))
                  .toList(),
              comments: []);
          await Future.forEach(Convertor.stringToList(post['comments']),
              (e) async {
            await getCommentById(e).then((comment) {
              postModel.comments.add(comment);
            });
          });

          currentUser.savedPosts.add(postModel);
        }
      }
    });
  }

  Future<void> downloadFollowedForums() async {
    String username = currentUser.username;

    await request('getUserFollowedForums', 'username::$username')
        .then((followedForums) async {
      if (followedForums != '-') {
        print("followedForums: $followedForums");
        List<Map<String, String>> followedForumsList = [];
        followedForums.split('\n').forEach((forum) {
          print("forum: " + forum);
          followedForumsList.add(Convertor.stringToMap(forum));
        });
        print(followedForumsList);

        for (var forum in followedForumsList) {
          ForumModel forumModel = ForumModel(
              name: forum['name'],
              desc: forum['desc'],
              admin: UserModel(username: forum['admin']),
              posts: []);

          await Future.forEach(Convertor.stringToList(forum['posts']),
              (e) async {
            await getPostById(e).then((post) {
              forumModel.posts.add(post);
            });
          });

          currentUser.followedForums.add(forumModel);
        }
      }
    });
  }

  Future<void> downloadFavoriteForums() async {
    String username = currentUser.username;

    await request('getUserFavoriteForums', 'username::$username')
        .then((favoriteForums) async {
      if (favoriteForums != '-') {
        List<Map<String, String>> favoriteForumsList = [];
        favoriteForums.split('\n').forEach((forum) {
          favoriteForumsList.add(Convertor.stringToMap(forum));
        });

        for (var forum in favoriteForumsList) {
          ForumModel forumModel = ForumModel(
              name: forum['name'],
              desc: forum['desc'],
              admin: UserModel(username: forum['admin']),
              posts: []);

          await Future.forEach(Convertor.stringToList(forum['posts']),
              (e) async {
            await getPostById(e).then((post) {
              print(Convertor.modelToString(post));
              forumModel.posts.add(post);
            });
          });

          currentUser.favoriteForums.add(forumModel);
        }
      }
    });
  }

  Future<PostModel> getPostById(String id) async {
    PostModel postModel;
    await request('getPost', 'id::$id').then((postString) async {
      Map<String, String> post = Convertor.stringToMap(postString);

      postModel = PostModel(
          id: post['id'],
          title: post['title'],
          desc: post['desc'],
          date: DateTime.parse(post['date']),
          forum: ForumModel(name: post['forum']),
          user: UserModel(username: post['user']),
          upvotes: Convertor.stringToList(post['upvotes'])
              .map((e) => UserModel(username: e))
              .toList(),
          downvotes: Convertor.stringToList(post['downvotes'])
              .map((e) => UserModel(username: e))
              .toList(),
          comments: []);

      await Future.forEach(Convertor.stringToList(post['comments']), (e) async {
        await getCommentById(e).then((comment) {
          print(Convertor.modelToString(comment));
          postModel.comments.add(comment);
        });
      });
    });
    return postModel;
  }

  Future<CommentModel> getCommentById(String id) async {
    CommentModel commentModel;
    await request('getComment', 'id::$id').then((commentString) async {
      Map<String, String> comment = Convertor.stringToMap(commentString);
      commentModel = CommentModel(
          id: comment['id'],
          comment: comment['comment'],
          user: UserModel(username: comment['user']),
          date: DateTime.parse(comment['date']),
          upvotes: Convertor.stringToList(comment['upvotes'])
              .map((e) => UserModel(username: e))
              .toList(),
          downvotes: Convertor.stringToList(comment['downvotes'])
              .map((e) => UserModel(username: e))
              .toList());
    });
    return commentModel;
  }
}
