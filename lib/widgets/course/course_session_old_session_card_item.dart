import 'package:dar_elkahrba/screens/course/course_session_student_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CourseSessionOldSessionCardItem extends StatelessWidget {
  const CourseSessionOldSessionCardItem({
    Key? key,
    required this.sessionData, required this.courseId,
  });
  final courseId;
  final sessionData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Constants.navigatorPush(
            context: context,
            screen: CourseSessionStudentScreen(
              courseId: courseId,
              sessionName: sessionData[Constants.courseSessionName],
              sessionDate: sessionData[Constants.courseSessionDate],
            ),
          );
        },
        child: ListTile(
          leading: Icon(Icons.qr_code),
          title: Column(
            children: [
              Text(
                sessionData[Constants.courseSessionName],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                '${sessionData[Constants.courseSessionDate]}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Icon(Icons.info),
        ),
      ),
    );
  }
}
