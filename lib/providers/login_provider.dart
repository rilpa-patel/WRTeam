import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
   bool _login = false ;

  bool get login => _login;

Future<void> setLogin(bool value) async{
  _login = value;
  notifyListeners();
}
}



