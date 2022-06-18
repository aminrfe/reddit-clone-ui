import 'dart:typed_data';

import 'Models/forum_model.dart';

import 'Models/post_model.dart';
import 'Models/user_model.dart';

class Data {
  ForumModel f1;
  ForumModel f2;
  ForumModel f3;
  ForumModel f4;

  UserModel currentUser;

  List<PostModel> userPosts;
  List<PostModel> userSavedPosts;
  
  Data._() {
    userPosts = [
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "title1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
    ];

    userSavedPosts = [
      PostModel(
          "stitle1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "stitle1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "stitle1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "stitle1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], []),
      PostModel(
          "stitle1",
          'This is a test for reddit ui.\nIt is second line of text.',
          null,
          null,
          DateTime.now(), [], [], [])
    ];

    f1 = ForumModel(
        'Programming',
        'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.',
        null,
        [userSavedPosts[0], userSavedPosts[1], userSavedPosts[2]]);

    f2 = ForumModel(
        'vim',
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        null,
        [userPosts[0], userPosts[1]]);

    f3 = ForumModel(
        'Dota2',
        'Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.',
        null,
        [userPosts[2], userPosts[3]]);

    f4 = ForumModel(
        'Nasa',
        'Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.',
        null,
        [userPosts[4], userPosts[5]]);

    currentUser = UserModel('Amin Rafiee', '88', '', [f1, f2, f3, f4],
        userPosts + userSavedPosts, userSavedPosts);

    currentUser.favoriteForums = [f1, f3];

    userPosts.forEach((element) {
      element.forum = f1;
      element.user = currentUser;
    });
    userSavedPosts.forEach((element) {
      element.forum = f2;
      element.user = currentUser;
    });

    f1.admin = currentUser;
    f2.admin = currentUser;
    f3.admin = currentUser;
    f4.admin = currentUser;
  }

  static final Data _instance = Data._();

  factory Data() {
    return _instance;
  }
}
