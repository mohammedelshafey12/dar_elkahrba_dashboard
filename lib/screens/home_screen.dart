import 'package:dar_elkahrba/screens/student_screen.dart';
import 'package:dar_elkahrba/widgets/app_drawer.dart';
import 'package:dar_elkahrba/widgets/home_card_item.dart';
import 'package:flutter/material.dart';

import 'verify_screen.dart';
import 'course/add_new_course_screen.dart';
import 'course/courses_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dash Board')),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Container(
          width: width * 0.7,
          height: height * 0.7,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeCardItem(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AddNewCourseScreen.routeName);
                      },
                      text: 'Add a new Course',
                      icon: Icons.add,
                    ),
                    SizedBox(
                      width: width * 0.08,
                    ),
                    HomeCardItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(CoursesOverviewScreen.routeName);
                      },
                      text: 'Courses',
                      icon: Icons.book,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeCardItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(VerifiedScreen.routeName);
                      },
                      text: 'Verify Students',
                      icon: Icons.mobile_friendly,
                    ),
                    SizedBox(
                      width: width * 0.08,
                    ),
                    HomeCardItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(StudentScreen.routeName);
                      },
                      text: 'Student',
                      icon: Icons.people,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
