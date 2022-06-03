import 'package:flutter/material.dart';

import 'add_post.dart';
import 'feed_page.dart';
import 'forums_list.dart';
import 'setting_page.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({Key key, this.navigatorKey, this.tabItem}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey;
  String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (tabItem == 'FeedPage') {
      child = FeedPage();
    } else if (tabItem == 'ForumsList') {
      child = ForumsList();
    } else if (tabItem == 'AddPost') {
      child = AddPost();
    } else if (tabItem == 'SettingPage') {
      child = SettingPage();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
