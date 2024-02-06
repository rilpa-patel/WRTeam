import 'dart:developer';

import 'package:flutter/material.dart';

import '../Services/localStorage.dart';
import '../helper/fatchData.dart';
import '../models/listdata.dart';


class RestApiListView extends StatefulWidget {
  const RestApiListView({super.key});

  @override
  State<RestApiListView> createState() => _RestApiListViewState();
}

class _RestApiListViewState extends State<RestApiListView> {
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
        title: const Text("List"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final bool isFavorite = favoriteIds.contains(item.id);
                return ListTile(
                  title: Text(item.title),
                  trailing: IconButton(
                    icon: isFavorite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                    onPressed: () => toggleFavorite(item.id),
                    color: isFavorite ? Colors.red : null,
                  ),
                );
              },
            ),
    );
  }
}
