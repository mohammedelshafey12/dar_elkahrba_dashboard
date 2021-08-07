import 'package:dar_elkahrba/providers/course.dart';
import 'package:dar_elkahrba/screens/add_new_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesListItem extends StatelessWidget {
  const CoursesListItem({
    Key? key,
    required this.courses,
    required this.index,
    required this.constraints,
  }) : super(key: key);

  final List<Course> courses;
  final int index;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${index + 1}'),
      ),
      title: Text('${courses[index].title}'),
      subtitle: Text('${courses[index].instructor}'),
      trailing: Container(
        width: constraints.maxWidth * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddNewCourseScreen.routeName,
                      arguments: courses[index].id);
                },
                icon: Icon(
                  Icons.edit,
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                splashRadius: 20,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text(
                                'Are you sure that you want to delete this course'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Provider.of<CoursesProvider>(context,
                                          listen: false)
                                      .deleteCourse(courses[index].id);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('NO'),
                              ),
                            ],
                          ));
                },
                icon: Icon(Icons.delete),
              ),
            )
          ],
        ),
      ),
    );
  }
}
