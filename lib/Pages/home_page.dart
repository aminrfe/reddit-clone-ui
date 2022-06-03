import 'package:flutter/material.dart';
import '/Models/user_model.dart';
import '/Pages/add_post.dart';
import 'tab_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel currentUser;
  String currentPage = 'FeedPage';
  int selectedIndex = 0;

  final List<String> pageKeys = [
    'FeedPage',
    'ForumsList',
    'AddPost',
    'SettingPage'
  ];

  final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    'FeedPage': GlobalKey<NavigatorState>(),
    'ForumsList': GlobalKey<NavigatorState>(),
    'AddPost': GlobalKey<NavigatorState>(),
    'SettingPage': GlobalKey<NavigatorState>(),
  };

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  void selectTab(String tabItem, int index) {
    if (tabItem == currentPage) {
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pageKeys[index];
        selectedIndex = index;
      });
    }
  }

  final List<Map<String, dynamic>> _items = [
    {
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home,
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.list_alt,
      'activeIcon': Icons.list_alt,
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.add,
      'activeIcon': Icons.add,
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.settings,
      'activeIcon': Icons.settings,
      'color': Colors.deepOrange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await navigatorKeys[currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentPage != "Page1") {
            selectTab("Page1", 1);

            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            buildOffstageNavigator('FeedPage'),
            buildOffstageNavigator('ForumsList'),
            buildOffstageNavigator('AddPost'),
            buildOffstageNavigator('SettingPage'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedIconTheme: const IconThemeData(
            color: Colors.black26,
          ),
          iconSize: 30,
          items: _items.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item['icon']),
              activeIcon: Icon(item['activeIcon'], color: item['color']),
              label: '',
            );
          }).toList(),
          selectedItemColor: Colors.black,
          onTap: (int index) {
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPost()),
              );
            } else {
              selectTab(pageKeys[index], index);
            }
          },
          currentIndex: selectedIndex,
        ),
      ),
    );
  }
}
