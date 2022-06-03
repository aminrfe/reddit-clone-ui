import 'package:flutter/material.dart';

import '../Models/forum_model.dart';

class SearchForums extends SearchDelegate<ForumModel> {
  SearchForums({this.allForums});

  final List<ForumModel> allForums;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ForumModel> suggested = allForums
        .where(
            (forum) => forum.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: suggested.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("r/" + suggested[index].name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            leading: Icon(
              Icons.account_circle_rounded,
              size: 35,
            ),
            horizontalTitleGap: 15,
            minLeadingWidth: 20,
            visualDensity: VisualDensity.compact,
            onTap: () {
              close(context, suggested[index]);
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ForumModel> suggested = allForums
        .where(
            (forum) => forum.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: suggested.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("r/" + suggested[index].name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            leading: Icon(
              Icons.account_circle_rounded,
              size: 35,
            ),
            horizontalTitleGap: 15,
            minLeadingWidth: 20,
            visualDensity: VisualDensity.comfortable,
            onTap: () {
              close(context, suggested[index]);
            },
          );
        },
      ),
    );
  }
}
