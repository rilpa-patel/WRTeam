import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveLogin(bool islogin) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogin', islogin);
  }

  Future<bool> readLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final islogin = prefs.getBool('islogin') ?? false;
    return islogin;
  }

  Future<void> deleteLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('myList');
    prefs.remove('firstName');
    prefs.remove('lastName');

    prefs.remove('islogin');
  }

  Future<void> saveList(List<int> myList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = myList.map((e) => e.toString()).toList();
    log(stringList.toString());
    prefs.setStringList('myList', stringList);
  }

  Future<List<int>> loadList() async {
    List<int> myList = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList('myList');

    if (stringList != null) {
      myList = stringList.map((e) => int.parse(e)).toList();
      log(myList.toString());
    }
    return myList;
  }

  Future<void> saveUserData(
      String _firstNameController, String _lastNameController) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstName', _firstNameController);
    prefs.setString('lastName', _lastNameController);
  }
}
