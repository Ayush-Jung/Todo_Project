import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/homePage.dart';
import 'package:todo/screens/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Condition(),
    );
  }
}
//checking either  redirect user to loginpage or homepage.

class Condition extends StatelessWidget {
  // Firebase initilization
  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFirebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("error:${snapshot.error}"),
            ),
          );
        }
        //checking connection.
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  User user = snapshot.data;
                  if (user == null) {
                    return LoginPage();
                  } else {
                    return HomePage();
                  }
                }
                // return this incase of connection is not active
                return Scaffold(
                  body: Center(
                    child: Text("Checking user credential.."),
                  ),
                );
              });
        }
        // return if connection takes more time.
        return Scaffold(
          body: Center(
            child: Text("Loading..."),
          ),
        );
      },
    );
  }
}
