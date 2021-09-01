
 import 'dart:async';
import 'package:dar_elkahrba/screens/authentication/login_screen.dart';
import 'package:dar_elkahrba/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// this fuc to wait app for build and do timer to avoid un save operations
    SchedulerBinding.instance!.addPostFrameCallback((_) {

      User? userAuth = FirebaseAuth.instance.currentUser;
      //userProvider.getUserId(userAuth!.uid);
      //print(userAuth.uid);
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) =>
              userAuth== null ? LoginScreen(): HomeScreen()
                //  HomePage()
              )));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
