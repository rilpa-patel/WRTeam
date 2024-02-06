import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier{
  late bool _isOnline = false;
  bool get isOnline => _isOnline;

  ConnectivityProvider(){
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((event) async {
      if(event == ConnectivityResult.none){
        _isOnline = false;
        notifyListeners();
      }else{
        _isOnline = true;
        notifyListeners();
      }
     });
  }
}