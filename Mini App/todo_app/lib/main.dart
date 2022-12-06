import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/provider/auth.dart';
import 'package:todo_app/view/login.dart';
import 'package:todo_app/view/my_tab.dart';

import 'view/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: const MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, bloc, _) {
      return StreamBuilder<User?>(
          stream: bloc.streamAuthStatus,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              log(snapshot.data.toString());
            }
            return MaterialApp(
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: scaffoldMessengerKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.purple,
              ),
              home: snapshot.data != null ? const MyTab() : const LoginPage(),
            );
          });
    });
  }
}
