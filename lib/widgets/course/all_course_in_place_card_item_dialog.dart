import 'package:dar_elkahrba/screens/course/course_all_student_screen.dart';
import 'package:dar_elkahrba/screens/course/course_session_enter_name_screen.dart';
import 'package:dar_elkahrba/screens/course/course_session_old_session_screen.dart';
import 'package:dar_elkahrba/screens/course/course_verify_student_screen.dart';
import 'package:dar_elkahrba/widgets/course/course_session_old_session_card_item.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'all_course_in_place_card_item_dialog_card_item.dart';

class AllCourseInPlaceCardItemDialog extends StatelessWidget {
  const AllCourseInPlaceCardItemDialog({
    Key? key,
    required this.courseData,
  });

  final courseData;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        'Course Sessions',
      ),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
        color: Color(0xffFF6176),
      ),
      content: Container(
        width: width * 0.8,
        height: height * 0.8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AllCourseInPlaceCardItemDialogCardItem(
                      title: 'New Session',
                      icon: Icons.add,
                      onTap: () {
                        Constants.navigatorPush(
                          context: context,
                          screen: CourseSessionEnterNameScreen(
                            courseId: courseData[Constants.courseId],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    AllCourseInPlaceCardItemDialogCardItem(
                      title: 'Old Sessions',
                      icon: Icons.book,
                      onTap: () {
                        Constants.navigatorPush(
                          context: context,
                          screen: CourseSessionOldSessionScreen(
                            courseId: courseData[Constants.courseId],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Row(
                  children: [
                    AllCourseInPlaceCardItemDialogCardItem(
                      title: 'Verify Student',
                      icon: Icons.mobile_friendly,
                      onTap: () {
                        Constants.navigatorPush(
                          context: context,
                          screen: CourseVerifyStudentScreen(
                            courseId: courseData[Constants.courseId],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    AllCourseInPlaceCardItemDialogCardItem(
                      title: 'Student',
                      icon: Icons.people,
                      onTap: () {
                        Constants.navigatorPush(
                          context: context,
                          screen: CourseAllStudentScreen(
                            courseData: courseData,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Return',
            style: TextStyle(
              color: Color(0xffFF6176),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
