import 'package:flutter/material.dart';

import '../Models/post_model.dart';
import '/Items/post_item_search.dart';

class SearchPosts extends SearchDelegate<PostModel> {
  SearchPosts({this.allPosts});

  final List<PostModel> allPosts;

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
    List<PostModel> suggested = allPosts
        .where(
            (forum) => forum.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: suggested.length,
        itemBuilder: (context, index) {
          return PostItem(
              suggested[index], () => close(context, suggested[index]));
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PostModel> suggested = allPosts
        .where(
            (forum) => forum.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: suggested.length,
        itemBuilder: (context, index) {
          return PostItem(
              suggested[index], () => close(context, suggested[index]));
        },
      ),
    );
  }
}
