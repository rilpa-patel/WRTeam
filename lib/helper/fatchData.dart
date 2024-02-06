import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wrteam/models/listdata.dart';

class FatchData {
  List<ListData> Data = [];

  Future<List<ListData>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      temp.forEach((element) {
        Data.add(ListData(element['userId'], element['id'], element['title'],
            element['completed'].toString()));
      });
      return Data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
