import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wrteam/Screens/onboarding_screen.dart';
import 'package:wrteam/Screens/splash_screen.dart';

import '../../Screens/NoInternetPage.dart';
import '../../providers/connectivity_provder.dart';

 
class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) { // for change routes
    return MaterialPageRoute(builder: (context) {
      final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
      if(!isOnline){
        return const NoInternetPage();
      }
      log(settings.name.toString());
      switch (settings.name) {
        case "MainSplash":
          return ( SplashScreen());
    
      }
 
      // ignore: prefer_const_constructors
      return OnboardingScreen();
    });
  }
}

