import 'package:dar_elkahrba/screens/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/courses_overview_screen.dart';
import 'package:flutter/material.dart';

class HomePageGridItem extends StatelessWidget {
  final String title;

  HomePageGridItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          if (title == "Add a new course") {
            Navigator.of(context)
                .pushNamed(AddNewCourseScreen.routeName, arguments: '');
          } else if (title == "Courses") {
            Navigator.of(context).pushNamed(CoursesOverviewScreen.routeName);
          } else if (title == "Verify Students") {
            //Navigator.of(context).pushNamed(AddNewCourseScreen.routeName);
          } else if (title == "Students") {
            //Navigator.of(context).pushNamed(AddNewCourseScreen.routeName);
          }
        },
        child: GridTile(
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          )),
        ),
      ),
    );
  }
}
