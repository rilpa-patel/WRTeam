import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'helper/network_connectivity/customRoute.dart';
import 'providers/connectivity_provder.dart';
import 'providers/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.location.request(); 
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => LoginProvider()),
          ChangeNotifierProvider(create: (ctx) => ConnectivityProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Your App Name',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: CustomRoute.allRoutes,
          initialRoute: "MainSplash",
          home: SplashScreen(),
        ));
  }
}
