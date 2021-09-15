import 'package:dar_elkahrba/screens/course/add_new_course_screen.dart';
import 'package:dar_elkahrba/screens/course/course_place_screen.dart';
import 'package:dar_elkahrba/screens/student/student_place_screen.dart';
import 'package:dar_elkahrba/screens/varify/verify_doctor_screen.dart';
import 'package:dar_elkahrba/screens/varify/verify_student_screen.dart';
import 'package:dar_elkahrba/widgets/home/home_card_item.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
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
                      Constants.navigatorPush(
                        context: context,
                        screen: AddCourseScreen(),
                      );
                    },
                    text: 'Add a new Course',
                    icon: Icons.add,
                  ),
                  SizedBox(
                    width: height * 0.08,
                  ),
                  HomeCardItem(
                    onTap: () {
                      Constants.navigatorPush(
                        context: context,
                        screen: VerifyStudentScreen(),
                      );
                    },
                    text: 'Verify Students',
                    icon: Icons.mobile_friendly,
                  ),
                  SizedBox(
                    width: height * 0.08,
                  ),
                  HomeCardItem(
                    onTap: () {
                      Constants.navigatorPush(
                        context: context,
                        screen: VerifyDoctorScreen(),
                      );
                    },
                    text: 'Verify Doctor',
                    icon: Icons.verified_outlined,
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
                      Constants.navigatorPush(
                        context: context,
                        screen: CoursePlaceScreen(),
                      );
                    },
                    text: 'Courses',
                    icon: Icons.book,
                  ),
                  SizedBox(
                    width: height * 0.08,
                  ),
                  HomeCardItem(
                    onTap: () {
                      Constants.navigatorPush(
                        context: context,
                        screen: StudentPlaceScreen(),
                      );
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
    );
  }
}
