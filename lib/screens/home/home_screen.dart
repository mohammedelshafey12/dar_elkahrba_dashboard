import 'package:dar_elkahrba/screens/home/home_body.dart';
import 'package:dar_elkahrba/screens/home/home_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Dash Board',
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      drawer: HomeDrawer(),
      body: HomeBody(),
    );
  }
}
