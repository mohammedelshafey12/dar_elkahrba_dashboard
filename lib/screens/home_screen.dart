import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:dar_elkahrba/widgets/home_page_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> titles = [
    'Add a new course',
    'Courses',
    'Verify Students',
    'Students',
  ];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dash Board')),
        iconTheme: IconThemeData(color: Colors.black),
        //backgroundColor: Colors.white,
      ),
      drawer: AppDrawer(),
      body: HomePageGrid(deviceSize: deviceSize, titles: titles),
    );
  }
}
