import 'dart:async';
import 'package:dar_elkahrba/screens/auth/login_screen.dart';
import 'package:dar_elkahrba/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../Constants.dart';

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
      Timer(
        Duration(seconds: 3),
        () => Constants.navigatorPushAndRemove(
          context: context,
          screen: userAuth == null ? LogInScreen() : HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
