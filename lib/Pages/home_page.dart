import 'package:flutter/material.dart';
import 'add_post.dart';
import 'feed_page.dart';
import 'forums_list.dart';
import 'setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentPage = 'FeedPage';
  int _selectedIndex = 0;

  final List<String> _pageKeys = [
    'FeedPage',
    'ForumsList',
    'AddPost',
    'SettingPage'
  ];

  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'FeedPage': GlobalKey<NavigatorState>(),
    'ForumsList': GlobalKey<NavigatorState>(),
    'AddPost': GlobalKey<NavigatorState>(),
    'SettingPage': GlobalKey<NavigatorState>(),
  };

  Widget _pageBuilders(String tabItem) {
    return {
      'FeedPage': FeedPage(),
      'ForumsList': ForumsList(),
      'AddPost': AddPost(),
      'SettingPage': SettingPage(onNext: _next, onLogout: _logout),
    }[tabItem];
  }

  final List<Map<String, dynamic>> _items = [
    {
      'icon': Icons.home_outlined,
      'activeIcon': Icons.home,
    },
    {
      'icon': Icons.list_alt,
      'activeIcon': Icons.list_alt,
    },
    {
      'icon': Icons.add,
      'activeIcon': Icons.add,
    },
    {
      'icon': Icons.settings,
      'activeIcon': Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab && _currentPage != "FeedPage") {
          _selectTab("FeedPage", 0);

          return false;
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator('FeedPage'),
            _buildOffstageNavigator('ForumsList'),
            _buildOffstageNavigator('AddPost'),
            _buildOffstageNavigator('SettingPage'),
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
              activeIcon: Icon(item['activeIcon'], color: Colors.deepOrange),
              label: '',
            );
          }).toList(),
          selectedItemColor: Colors.black,
          onTap: (int index) {
            if (_pageKeys[index] == 'AddPost') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPost()),
              );
            } else {
              _selectTab(_pageKeys[index], index);
            }
          },
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = _pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  void _next(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _logout() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/LogIn', (Route<dynamic> route) => false);
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
        offstage: _currentPage != tabItem,
        child: Navigator(
          key: _navigatorKeys[tabItem],
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
                builder: (context) => _pageBuilders(tabItem));
          },
        ));
  }
}
