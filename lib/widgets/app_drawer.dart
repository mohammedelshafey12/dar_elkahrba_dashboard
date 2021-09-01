import 'package:dar_elkahrba/screens/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
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
              Navigator.pushNamed(context, '/HomeScreen');
            },
            leading: Icon(Icons.home),
            title: Text('Home Page'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/Add-new-course');
            },
            leading: Icon(Icons.add),
            title: Text('Add a new course'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/courses-overview');
            },
            leading: Icon(Icons.book),
            title: Text('Courses'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/VerifiedScreen');
            },
            leading: Icon(Icons.mobile_friendly),
            title: Text('Verify students'),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/StudentScreen');
            },
            leading: Icon(Icons.people),
            title: Text('students'),
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
                              () => Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false),
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

  const AppDrawer();
}
