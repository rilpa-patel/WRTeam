
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Image(
                image: AssetImage('assets/images/connection.jpg'),
                fit: BoxFit.contain,
                height: 250,
              ),
               Text("Connect Your Internet", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.redAccent ),)
        ],)
      ),
    );
  }
}