import 'package:flutter/material.dart';
import 'package:reddit_clone_ui/Pages/search_forums.dart';
import '../data.dart';
import '/Models/forum_model.dart';
import '/Models/user_model.dart';
import 'forum_page.dart';

class ForumsList extends StatefulWidget {
  const ForumsList({Key key}) : super(key: key);

  @override
  State<ForumsList> createState() => _ForumsListState();
}

class _ForumsListState extends State<ForumsList> {
  UserModel currentUser = Data().currentUser;
  List<ForumModel> unfavoritedForums;
  List<Map<String, dynamic>> _items;

  @override
  void initState() {
    unfavoritedForums = currentUser.followedForums
        .toSet()
        .difference(currentUser.favoriteForums.toSet())
        .toList();

    _items = [
      {
        'icon': Icons.star_rounded,
        'title': "Favorites",
        'list': currentUser.favoriteForums,
        'isExpanded': true
      },
      {
        'icon': Icons.view_list_rounded,
        'title': "Followed",
        'list': unfavoritedForums,
        'isExpanded': true
      }
    ];

    super.initState();
  }

  bool isfavorite(ForumModel forum) {
    return currentUser.favoriteForums.contains(forum);
  }

  void toggleFavorite(ForumModel forum) {
    if (currentUser.favoriteForums.contains(forum)) {
      setState(() {
        currentUser.favoriteForums.remove(forum);
        unfavoritedForums.add(forum);
      });

      unfavoritedForums.sort((a, b) => a.name.compareTo(b.name));
    } else {
      setState(() {
        unfavoritedForums.remove(forum);
        currentUser.favoriteForums.add(forum);
      });

      currentUser.favoriteForums.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(52),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.orangeAccent,
                  ],
                ),
              ),
            ),
            leading: IconButton(
              icon: Image.asset('assets/images/reddit-logo.png'),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final finalResult = await showSearch(
                      context: context,
                      delegate:
                          SearchForums(allForums: currentUser.followedForums));
                  if (finalResult != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForumPage(
                                currentForum: finalResult,
                              )),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: ExpansionPanelList(
            elevation: 0,
            expansionCallback: (index, isExpanded) {
              setState(() {
                _items[index]['isExpanded'] = !isExpanded;
              });
            },
            animationDuration: Duration(milliseconds: 600),
            children: _items
                .map(
                  (item) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (_, isExpanded) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(children: [
                        Icon(item['icon'], size: 30),
                        SizedBox(width: 10),
                        Text(
                          item['title'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                    body: SingleChildScrollView(
                      child: Column(children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: item['list'].length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("r/" + item['list'][index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              // leading: CircleAvatar(
                              //   backgroundImage: unfavoritedForums[index].avatar,
                              //   radius: 20,
                              // ),
                              leading: Icon(
                                Icons.account_circle_rounded,
                                size: 35,
                              ),
                              horizontalTitleGap: 15,
                              minLeadingWidth: 20,
                              visualDensity: VisualDensity.compact,
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    toggleFavorite(item['list'][index]);
                                  });
                                },
                                child: isfavorite(item['list'][index])
                                    ? Icon(Icons.star_rounded,
                                        color: Colors.yellow[700], size: 30)
                                    : Icon(Icons.star_border_rounded, size: 30),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForumPage(
                                              currentForum: item['list'][index],
                                            )));
                              },
                            );
                          },
                        ),
                      ]),
                    ),
                    isExpanded: item['isExpanded'],
                  ),
                )
                .toList(),
          ),
        ));
  }
}
