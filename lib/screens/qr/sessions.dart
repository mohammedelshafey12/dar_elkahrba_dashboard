import 'package:dar_elkahrba/screens/qr/session_item.dart';
import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class SessionScreen extends StatelessWidget {
  String date;
  String courseId;

  SessionScreen({
    Key? key,
    required this.date,
    required this.courseId,
  }) : super(key: key);

  static const routeName = '/SessionScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dash Board')),
        iconTheme: IconThemeData(color: Colors.black),
        //backgroundColor: Colors.white,
      ),
      body: SessionItem(
        date: date,
        courseId: courseId,
      ),
      drawer: AppDrawer(),
    );
  }
}
