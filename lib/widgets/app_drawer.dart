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
            onTap: () {},
            leading: Icon(Icons.add),
            title: Text('Add a new course'),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.work),
            title: Text('Courses'),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.check),
            title: Text('Verify students'),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.supervised_user_circle),
            title: Text('students'),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          )
        ],
      ),
    );
  }

  const AppDrawer();
}
