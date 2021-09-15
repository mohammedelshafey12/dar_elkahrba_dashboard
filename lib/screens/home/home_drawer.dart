import 'package:dar_elkahrba/screens/auth/login_screen.dart';
import 'package:dar_elkahrba/screens/course/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/course/course_place_screen.dart';
import 'package:dar_elkahrba/screens/student/student_place_screen.dart';
import 'package:dar_elkahrba/screens/varify/verify_doctor_screen.dart';
import 'package:dar_elkahrba/screens/varify/verify_student_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Welcome'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Constants.navigatorPush(
                context: context,
                screen: AddCourseScreen(),
              );
            },
            leading: Icon(Icons.add),
            title: Text('Add a new course'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Constants.navigatorPush(
                context: context,
                screen: CoursePlaceScreen(),
              );
            },
            leading: Icon(Icons.book),
            title: Text('Courses'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Constants.navigatorPush(
                context: context,
                screen: VerifyStudentScreen(),
              );
            },
            leading: Icon(Icons.mobile_friendly),
            title: Text('Verify students'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Constants.navigatorPush(
                context: context,
                screen: VerifyDoctorScreen(),
              );
            },
            leading: Icon(Icons.verified_outlined),
            title: Text('Verify Doctor'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Constants.navigatorPush(
                context: context,
                screen: StudentPlaceScreen(),
              );
            },
            leading: Icon(Icons.people),
            title: Text('Students'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Logout...'),
                  content: Text('Do you want to logout?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("you choose no");
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        auth.signOut().whenComplete(
                              () => Constants.navigatorPushAndRemove(
                                context: context,
                                screen: LogInScreen(),
                              ),
                            );
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          )
        ],
      ),
    );
  }
}
