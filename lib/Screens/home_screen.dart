
import 'package:flutter/material.dart';
import 'package:wrteam/Screens/favoritelist_Screen.dart';
import 'package:wrteam/Screens/login_screen.dart';
import 'package:wrteam/Screens/profile_screen.dart';
import 'package:wrteam/Services/localStorage.dart';

import '../Services/auth_service.dart';
import 'apiList.dart';

class HomePage extends StatelessWidget {
  AuthService authService = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  resizeToAvoidBottomInset: false,

      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
              LocalStorage localStorage = LocalStorage();
              localStorage.deleteLogin();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );

              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 60.2,
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 1.00,
        backgroundColor: Colors.blue,
        title: Text('Home'),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ), 
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  RestApiListView(),
                  FavouriteList(),
                  ProfilePage(),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.favorite)),
                  Tab(icon: Icon(Icons.person)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
