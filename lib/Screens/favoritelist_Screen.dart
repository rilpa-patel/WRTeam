import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wrteam/Services/localStorage.dart';
import 'package:wrteam/helper/fatchData.dart';
import 'package:wrteam/models/listdata.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  List<ListData> items = [];
  List<int> favoriteIds = [];
  bool loading = true;
  LocalStorage localStorage = LocalStorage();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    FatchData fatchData = FatchData();
    items = await fatchData.fetchData();
    favoriteIds = await localStorage.loadList();

    setState(() {
      loading = false;
    });
  }

  void toggleFavorite(int id) {
    setState(() {
      if (favoriteIds.contains(id)) {
        favoriteIds.remove(id);
      } else {
        favoriteIds.add(id);
      }
    });
    localStorage.saveList(favoriteIds);
  }

  @override
  Widget build(BuildContext context) {
    log(favoriteIds.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite List"),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final bool isFavorite = favoriteIds.contains(item.id);

                // Display only items that are in the favoriteIds list
                if (isFavorite) {
                  return ListTile(
                    title: Text(item.title),
                    trailing: IconButton(
                      icon: isFavorite
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      onPressed: () => toggleFavorite(item.id),
                      color: isFavorite ? Colors.red : null,
                    ),
                  );
                } else {
                  // Return an empty container for items that are not favorites
                  return Container();
                }
              },
            ),
    );
  }
}
