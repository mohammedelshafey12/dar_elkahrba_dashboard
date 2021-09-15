import 'package:dar_elkahrba/screens/home/home_screen.dart';
import 'package:dar_elkahrba/widgets/course/course_session_home_card_item.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'course_session_qr_code_screen.dart';
import 'course_session_student_screen.dart';

class CourseSessionHomeScreen extends StatelessWidget {
  const CourseSessionHomeScreen({
    Key? key,
    required this.courseId,
    required this.sessionName,
    required this.sessionDate,
  });
  final courseId;
  final sessionName;
  final sessionDate;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Constants.navigatorPushAndRemove(
              context: context,
              screen: HomeScreen(),
            );
          },
        ),
        title: Text('Session Home [ $sessionName ]'),
      ),
      body: Center(
        child: Container(
          height: height * 0.7,
          width: width * 0.7,
          child: Row(
            children: [
              CourseSessionHomeCardItem(
                title: 'Qr Code',
                icon: Icons.qr_code,
                onTap: () {
                  Constants.navigatorPush(
                    context: context,
                    screen: CourseSessionQrCodeScreen(
                      sessionName: sessionName,
                      sessionDate: sessionDate,
                    ),
                  );
                },
              ),
              SizedBox(
                width: width * 0.05,
              ),
              CourseSessionHomeCardItem(
                title: 'Student',
                icon: Icons.group,
                onTap: () {
                  Constants.navigatorPush(
                    context: context,
                    screen: CourseSessionStudentScreen(
                      courseId: courseId,
                      sessionName: sessionName,
                      sessionDate: sessionDate,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
